import 'dart:io';

import 'package:flutter/material.dart';
import 'package:show_qrcode/show_qrcode.dart';
import 'package:xgateapp/core/models/gateman_resident_visitors.dart';
import 'package:xgateapp/core/service/gateman_service.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/widgets/ResidentExpansionTile/resident_expansion_tile.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';

class VisitorCheckout extends StatefulWidget {
  final String visitorName;
  final String visitorPhoneNumber;
  final String visitorDesc;
  final String visitorETA;
  final String name;
  final String phoneNumber;
  final String houseAddr;
  final String qrCode;

  const VisitorCheckout({
    Key key,
    @required this.visitorName,
    @required this.visitorPhoneNumber,
    @required this.visitorDesc,
    @required this.visitorETA,
    @required this.name,
    @required this.phoneNumber,
    @required this.houseAddr,
    @required this.qrCode,
  }) : super(key: key);

  @override
  _VisitorCheckoutState createState() => _VisitorCheckoutState();
}

class _VisitorCheckoutState extends State<VisitorCheckout> {
  File qrFile;
  bool isLoading = false;
  LoadingDialog dialog;
  List<GatemanResidentVisitors> _visitors;

  @override
  void initState() {
    super.initState();
    dialog = LoadingDialog(context, LoadingDialogType.Normal);
    initQRCode();
  }

  initQRCode() async {
    setState(() => isLoading = true);
    var file = await Qrcode.generateQRCode(widget.qrCode);
    setState(() {
      qrFile = file;
      isLoading = false;
    });
  }

  onFinishTapped() async {
    dialog.show();

    List<GatemanResidentVisitors> result = await GatemanService.admitVisitor(
      qrCode: widget.qrCode,
      authToken: await authToken(context),
    );
    dialog.hide();

    if (result.length > 0) {
      await PaysmosmoAlert.showError(
          context: context, message: 'Could not admit visitor');
    } else {
      await PaysmosmoAlert.showError(
              context: context, message: 'Visitor admitted successfully')
          .then((_) {
        Navigator.of(context).pushReplacementNamed('/gateman-menu');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          SizedBox(height: size.height * 0.01),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                qrFile == null
                    ? Icon(Icons.broken_image, size: 33.0)
                    : Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: 9.0, horizontal: 2.0),
                        height: size.height * 0.3,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: FileImage(qrFile),
                        )),
                      ),
                Divider(
                  color: Colors.grey,
                  height: .4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'Visitor Info',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Approved',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15.0,
                          color: GateManColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                TextRow(
                  title: 'Name',
                  text: widget.visitorName ?? '',
                ),
                TextRow(
                  title: 'Phone Number',
                  text: widget.visitorPhoneNumber ?? '',
                ),
                TextRow(title: 'Description', text: widget.visitorDesc),
                TextRow(
                  title: 'ETA',
                  text: widget.visitorETA ?? '',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'Authorized By',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                TextRow(
                  title: 'Name',
                  text: widget.name ?? '',
                ),
                TextRow(
                  title: 'Phone Number',
                  text: widget.phoneNumber ?? '',
                ),
                TextRow(title: 'Address', text: 'Block 4A'),
              ],
            ),
          ),
          ActionButton(
            buttonText: 'FINISH',
            onPressed: onFinishTapped,
          ),
        ],
      ),
    );
  }
}
