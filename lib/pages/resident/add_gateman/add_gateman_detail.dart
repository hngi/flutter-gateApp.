import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xgateapp/core/service/resident_service.dart';
import 'package:xgateapp/pages/resident/add_gateman/widgets/progress_loader.dart';
import 'package:xgateapp/providers/resident_gateman_provider.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'dart:async';
import 'package:xgateapp/widgets/CustomInputField/custom_input_field.dart';

enum AddGateManDetailStatus {
  NONE,
  SEARCHING,
  MESSAGE_SENT,
  AWAITING_CONFIRMATION
}
final ChangeNotifier statusNotiifer = ChangeNotifier();

class AddGateManDetail extends StatefulWidget {
  @override
  _AddGateManDetailState createState() => _AddGateManDetailState();
}

class _AddGateManDetailState extends State<AddGateManDetail>
    with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController;
  double angle;
  AddGateManDetailStatus loadingState = AddGateManDetailStatus.SEARCHING;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    ScreenUtil.instance = ScreenUtil(width: 360, height: 780)..init(context);
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Add a Security Guard'),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('* Phone Number', style: TextStyle(color: Colors.grey)),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: CustomInputField(
                    hint: '',
                    keyboardType: TextInputType.phone,
                    prefix: null,
                    textEditingController: _textEditingController,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.all(20),
            child: FlatButton(
              child: Text(
                'Continue',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (_textEditingController.text.length > 0) {
                  addGateMan(_textEditingController.text, context);
                } else {
                  PaysmosmoAlert.showWarning(
                      context: context,
                      message: 'Phone number cannot be empty');
                }
              },
              color: GateManColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
          )
        ],
      ),
    );
  }

  void setLoadingState(AddGateManDetailStatus status) {
    setState(() {
      loadingState = status;
    });
  }

  Future _showMaterialDialog(context, String phoneNumber, String gateManName,
      {AddGateManDetailStatus ldStatus}) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          AddGateManDetailStatus loadStatus =
              ldStatus ?? AddGateManDetailStatus.AWAITING_CONFIRMATION;
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            content: Container(
              width: ScreenUtil().setWidth(250),
              height: ScreenUtil().setHeight(350),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: loadStatus == AddGateManDetailStatus.SEARCHING
                      ? <Widget>[
                          Text('Searching for $phoneNumber'),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: ProgressLoader(
                              width: 30,
                              height: 30,
                            ),
                          )
                        ]
                      : loadStatus == AddGateManDetailStatus.MESSAGE_SENT
                          ? <Widget>[
                              Image.asset(
                                'assets/images/gateman_not_found.png',
                                width: ScreenUtil().setWidth(50),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Text(
                                  'Security Guard not registered to \nyour estate',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Invite ${phoneNumber.length > 4 ? phoneNumber.replaceRange(3, phoneNumber.length, "*******") : phoneNumber} to join Gateguard to enjoy the benefits of connecting with them as a security guard',
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: GateManColors.primaryColor),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Share.text('GateGuard', 'Hey there, Download GateGuard(https://play.google.com/store/apps/details?id=com.hng.xgateapp)! \n The best and secure community management solutions for estates', 'text/plain');
                                  },
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/invite_icon.png',
                                          scale: 2,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text('Invite',
                                              style: TextStyle(
                                                color:
                                                    GateManColors.primaryColor,
                                                fontSize: 18,
                                              )),
                                        )
                                      ],
                                    ),
                                  )),
                                ),
                              )
                            ]
                          : loadStatus ==
                                  AddGateManDetailStatus.AWAITING_CONFIRMATION
                              ? <Widget>[
                                  Image.asset(
                                    'assets/images/gateman/ok.png',
                                    width: ScreenUtil().setWidth(50),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Text(
                                      'Security Guard\nAdded succesfully',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Text(
                                    'Awaiting Confirmation from',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Text(gateManName ?? 'its null'),
                                  ),
                                ]
                              : <Widget>[Container(width: 0, height: 0)]),
            ),
          );
        });
  }

  void addGateMan(String phoneNumber, BuildContext context) async {
    LoadingDialog dialog = LoadingDialog(context, LoadingDialogType.Normal);
    dialog.show();
    try {
      String token = await authToken(context);
      dynamic response =
          await ResidentsGatemanRelatedService.findGateManByPhone(
              authToken: token, phone: phoneNumber);
      print(response);
      if (response is ErrorType) {
        if (response == ErrorType.request_already_sent_to_gateman) {
          await PaysmosmoAlert.showWarning(
              context: context, message: GateManHelpers.errorTypeMap(response));
          Navigator.pop(context);
        } else {
          print('error in searching');

          print(response);
          if (response == ErrorType.no_gateman_found) {
            Navigator.pop(context);

            _showMaterialDialog(context, phoneNumber, '',
                ldStatus: AddGateManDetailStatus.MESSAGE_SENT);
          } else {
            await PaysmosmoAlert.showError(
                context: context,
                message: GateManHelpers.errorTypeMap(response));
            Navigator.pop(context);
          }

          //setLoadingStateInDialog(AddGateManDetailStatus.AWAITING_CONFIRMATION,'');
        }
      } else {
        if (response == null) {
          print('error in finding a match');
          await PaysmosmoAlert.showError(
              context: context,
              message: 'Couldnt find a match for the Gateman');
          Navigator.pop(context);
        } else {
          print(response['id'].toString());
          dynamic gateManRequest =
              await ResidentsGatemanRelatedService.addGateman(
                  authToken: token, gatemanId: response['id']);

          if (gateManRequest is ErrorType) {
            if (gateManRequest == ErrorType.request_already_sent_to_gateman) {
              Navigator.pop(context);
              await PaysmosmoAlert.showWarning(
                  context: context,
                  message: GateManHelpers.errorTypeMap(gateManRequest));
            } else {
              Navigator.pop(context);
              await PaysmosmoAlert.showError(
                  context: context,
                  message: GateManHelpers.errorTypeMap(gateManRequest));
            }
          } else {
            ResidentsGateManModel gateManModel =
                ResidentsGateManModel.fromJson(response);
            getResidentsGateManProvider(context)
                .addAwaitingResidentsGateManModel(gateManModel);
            loadGateManThatArePending(context);
            Navigator.pop(context);
            _showMaterialDialog(context, phoneNumber, gateManModel.name);
          }
        }
      }
    } catch (error) {
      throw error;
    }
  }
}
