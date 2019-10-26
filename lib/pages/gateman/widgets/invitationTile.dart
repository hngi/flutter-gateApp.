import 'package:flutter/material.dart';
import 'package:gateapp/core/service/gateman_service.dart';
import 'package:gateapp/pages/gateman/widgets/button.dart';
import 'package:gateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'customDialog.dart';

class InvitationTile extends StatefulWidget {
  final rname;
  final raddress;
  final rphone;
  final int requestId;
  final Function func;
  final BuildContext parentContext;

  InvitationTile({
    @required this.rname,
    @required this.raddress,
    @required this.rphone,
    @required this.requestId,
    this.func,
    @required this.parentContext,
  });

  @override
  _InvitationTileState createState() => _InvitationTileState();
}

class _InvitationTileState extends State<InvitationTile> {
  bool drag = true;
  bool exist = true;
  void toggle() {
    setState(() {
      drag = !drag;
    });
  }

  _acceptResident(LoadingDialog dialog) async {
    dialog.show();

    print('Request ID: ${widget.requestId}');

    var res = await GateManService.acceptRequest(
      requestId: widget.requestId,
      authToken: await authToken(context),
    );

    if (res is ErrorType) {
      dialog.hide();
      await PaysmosmoAlert.showError(
        context: context,
        message: GateManHelpers.errorTypeMap(res),
      );
    } else {
      dialog.hide();
      // await PaysmosmoAlert.showSuccess(
      //   context: context,
      //   message: 'Invitation accepted successfully',
      // );

      showAcceptDialog();
    }
  }

  _declineResident(LoadingDialog dialog) async {
    dialog.show();

    var res = await GateManService.rejectRequest(
      requestId: widget.requestId,
      authToken: await authToken(context),
    );

    if (res is ErrorType) {
      dialog.hide();
      await PaysmosmoAlert.showError(
        context: context,
        message: GateManHelpers.errorTypeMap(res),
      );
    } else {
      dialog.hide();

      await PaysmosmoAlert.showSuccess(
        context: context,
        message: 'Invitation declined successfully',
      );
    }
  }

  void decline() {
    setState(() {
      exist = !exist;
    });
  }

  void showAcceptDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
          title: " ",
          description: "${widget.rname} \nhas been added to \nResidents",
          buttonText: "View Residents",
          func: () {
            // Navigator.pushNamed(context, '/residents-gate');
            Navigator.pushNamed(context, '/residents');
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    LoadingDialog dialog = LoadingDialog(context, LoadingDialogType.Normal);

    return exist
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, top: 20.0, bottom: 3.0),
                child: Text(
                  '${widget.rname} invited you as a gateman',
                  style: TextStyle(color: Color(0xff2A2E43), fontSize: 14.0),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 5.0),
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.4))),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 7.0, right: 10.0),
                          child: Button(
                            color: Colors.green,
                            text: 'Accept',
                            func: () {
                              _acceptResident(dialog);
                            },
                          ),
                        ),
                        Button(
                          color: Colors.red,
                          text: 'Decline',
                          func: () {
                            _declineResident(dialog);
                          },
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: FlatButton(
                              onPressed: toggle,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Details',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Icon(
                                      drag
                                          ? MdiIcons.chevronUp
                                          : MdiIcons.chevronDown,
                                      color: Colors.green)
                                ],
                              )),
                        )
                      ],
                    ),
                    drag
                        ? ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.rname,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 7.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        size: 14.0,
                                        color: Color(0xff4F4F4F),
                                      ),
                                      Text(widget.raddress ?? 'null',
                                          style: TextStyle(
                                            fontSize: 11.0,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.phone,
                                      size: 14.0, color: Color(0xff4F4F4F)),
                                  Text('${widget.rphone}',
                                      style: TextStyle(
                                        fontSize: 11.0,
                                      ))
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          )
        : Container();
  }
}
