import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xgateapp/core/service/resident_service.dart';
import 'package:xgateapp/pages/resident/add_gateman/widgets/progress_loader.dart';
import 'package:xgateapp/providers/resident_gateman_provider.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/constants.dart' as prefix0;
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'dart:async';
import 'package:xgateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:xgateapp/widgets/ResidentExpansionTile/resident_expansion_tile.dart';

enum AddGateManDetailStatus {
  NONE,
  SEARCHING,
  MESSAGE_SENT,
  AWAITING_CONFIRMATION
}
final ChangeNotifier statusNotiifer= ChangeNotifier();

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
      appBar: GateManHelpers.appBar(context, 'Add Gateman'),
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
                if(_textEditingController.text.length > 0){
                    _showMaterialDialog(context, _textEditingController.text);
                  
                  
                } else {
                  PaysmosmoAlert.showWarning(context: context,message: 'Phone number cannot be empty');
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

  Future _showMaterialDialog(context, String phoneNumber) async {
    await showDialog(
        context: context,
        builder: (context) {
          AddGateManDetailStatus loadStatus = AddGateManDetailStatus.SEARCHING;
          bool gateManAddRun = false;
          String gateManName = 'GateApp';
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              if(gateManAddRun == false){
                print('Running check to see if its been added twice');
                addGateMan(phoneNumber,context,(status,nameFound){
                  setState((){
                    loadStatus = status;
                    gateManAddRun = true;
                    gateManName = nameFound;
                    
              });},(gatemanAddRunStatus){
                setState((){
                    gateManAddRun = gatemanAddRunStatus;
                });
              });
              } else{

              }
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
                                              padding: const EdgeInsets.only(top:18.0),
                                              child: ProgressLoader(
                                                width: 30,
                                                height: 30,
                                              ),
                                            )
                                          ]
                                        : loadStatus == AddGateManDetailStatus.MESSAGE_SENT
                                            ? <Widget>[
                                                Image.asset('assets/images/gateman/ok.png',
                                                width: ScreenUtil().setWidth(50),),
                                                Padding(
                                                  padding: const EdgeInsets.only(top:18.0),
                                                  child: Text('Message Sent Succesfully\nto',textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),),
                                                ),
                                                Text(phoneNumber,style: TextStyle(fontSize: 19),)
                                              ]
                                            : loadStatus ==
                                                    AddGateManDetailStatus
                                                        .AWAITING_CONFIRMATION
                                                ? <Widget>[
                                                    Image.asset(
                                                        'assets/images/gateman/ok.png',
                                                        width: ScreenUtil().setWidth(50),
                                                        ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(18.0),
                                                      child: Text('Gate Man\nAdded succesfully',textAlign: TextAlign.center,
                                                      style: TextStyle(color: Colors.grey),),
                                                    ),
                                                    Text('Awaiting Confirmation from',textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 9),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(18.0),
                                                      child: Text(gateManName??'its null'),
                                                    ),

                                                  ]
                                                : <Widget>[Container(width: 0, height: 0)]),
                              ),
                            );
                          },
                        );
                      });
                }
              
                void addGateMan(String phoneNumber,BuildContext context,Function(AddGateManDetailStatus status,String nameFound) setLoadingStateInDialog,
                Function(bool gatemanAddrun) setRun) async {
                  setRun(true);
                  try{
                  String token = await authToken(context);
                  dynamic response = await ResidentsGatemanRelatedService.findGateManByPhone(authToken: token, phone: phoneNumber);
                  print(response);
                  if(response is ErrorType){

                    if (response == ErrorType.request_already_sent_to_gateman){

                      PaysmosmoAlert.showWarning(context: context,message: GateManHelpers.errorTypeMap(response));

                    } else{
                  
                      print('error in searching');
                      print(response);
                      Navigator.of(context).pop();
                      PaysmosmoAlert.showError(context: context,message: GateManHelpers.errorTypeMap(response));
                      //setLoadingStateInDialog(AddGateManDetailStatus.AWAITING_CONFIRMATION,'');
                      }

                        } else {
                          print(response);
                   
                   
                    if(response==null){
                        Navigator.of(context).pop();
                        print('error in finding a match');
                        PaysmosmoAlert.showError(context: context,message: 'Couldnt find a match for the Gateman');
                    } else{
                      print(response['id'].toString());
                    dynamic gateManRequest = await ResidentsGatemanRelatedService.addGateman(authToken: token, gatemanId: response['id']);

                          if (gateManRequest is ErrorType){
                            Navigator.of(context).pop();

                             if (gateManRequest == ErrorType.request_already_sent_to_gateman){
                               print('dddddddddddddddddddd');
                              

                      PaysmosmoAlert.showWarning(context: context,message: GateManHelpers.errorTypeMap(gateManRequest));

                    } else{

                            PaysmosmoAlert.showError(context: context,message: GateManHelpers.errorTypeMap(gateManRequest));
                    }

                          } else {
                            ResidentsGateManModel gateManModel = ResidentsGateManModel.fromJson(response);
                            getResidentsGateManProvider(context).addAwaitingResidentsGateManModel(gateManModel);
                            loadGateManThatArePending(context);
                            
                          setLoadingStateInDialog(AddGateManDetailStatus.AWAITING_CONFIRMATION,gateManModel.name);
                            print('done');
                          }

                        }
                        }
                  }catch(error){
                    throw error;
                  }



                    
                  }


                }



