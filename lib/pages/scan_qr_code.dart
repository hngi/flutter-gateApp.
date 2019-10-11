import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
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
                child: QrCamera(
                  qrCodeCallback: (code) {
                    // ...
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
