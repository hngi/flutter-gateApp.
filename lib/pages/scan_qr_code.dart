import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/DashSeperator/dash_seperator.dart';
import 'package:gateapp/widgets/ScannerOverlayShape/scanner_overlay_shape.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class ScanQRCode extends StatefulWidget {
  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          SizedBox(height: size.height * 0.06),
          Padding(
            padding: const EdgeInsets.only(bottom: 23.0),
            child: Text('Scan QR Code',
                style: TextStyle(
                  color: GateManColors.blackColor,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Text('Align the QR code within the frame to scan',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Card(
              child: Container(
                alignment: Alignment.center,
                width: size.width * 0.75,
                height: size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.5,
                      decoration: ShapeDecoration(
                        shape: ScannerOverlayShape(
                          borderColor: GateManColors.primaryColor,
                          borderWidth: 3.0,
                          // overlayColor: Colors.red,
                        ),
                      ),
                      child: QrCamera(
                        qrCodeCallback: (code) {
                          // ...
                          print(code);
                        },
                      ),
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
