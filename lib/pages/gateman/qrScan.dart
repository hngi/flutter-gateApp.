import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/widgets/DashSeperator/dash_seperator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:qrcode_reader/QRCodeReader.dart';
//import 'package:qr_mobile_vision/qr_camera.dart';

class ScanQRCode2 extends StatefulWidget {
  @override
  _ScanQRCode2State createState() => _ScanQRCode2State();
}

class _ScanQRCode2State extends State<ScanQRCode2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FlatButton(
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text("< Back",
                    style: TextStyle(
                      color: GateManColors.primaryColor,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
          // SizedBox(height: size.height * 0.06),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 23.0, top: 7.0),
              child: Text('Scan QR Code',
                  style: TextStyle(
                    color: GateManColors.blackColor,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Text('Align the QR code within the frame to scan',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w800,
                  )),
            ),
          ),
          SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Card(
              child: Container(
                alignment: Alignment.center,
                width: size.width * 0.75,
                height: size.height * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.4,
                      // decoration: ShapeDecoration(
                      //   shape: ScannerOverlayShape(
                      //     borderColor: GateManColors.primaryColor,
                      //     borderWidth: 3.0,
                      //   ),
                      // ),
                      child: Container(),
                    ),
                    DashSeparator(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      child: Text(
                        "Or enter the visitor's code below.",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                          color: GateManColors.blackColor,
                        ),
                      ),
                    ),

                    // TextField(
                    //   decoration: InputDecoration(

                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
