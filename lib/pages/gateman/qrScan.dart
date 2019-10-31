import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/gateman_resident_visitors.dart';
import 'package:xgateapp/pages/gateman/visitor_check.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/core/service/gateman_service.dart';
import 'package:qrcode/qrcode.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/widgets/DashSeperator/dash_seperator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:qrcode_reader/QRCodeReader.dart';
//import 'package:qr_mobile_vision/qr_camera.dart';

enum CheckoutAction { scan, validate }

class ScanQRCode2 extends StatefulWidget {
  @override
  _ScanQRCode2State createState() => _ScanQRCode2State();
}

class _ScanQRCode2State extends State<ScanQRCode2> {
  QRCaptureController _captureController = QRCaptureController();
  TextEditingController _qrTextField = TextEditingController();

  GatemanResidentVisitors _visitor;
  bool _isScanning = false;
  bool _isValidating = false;

  bool _isTorchOn = false;

  @override
  void initState() {
    super.initState();

    _captureController.onCapture((data) {
      //pause camera
      print('onCapture----$data');
      _checkoutQR(data, CheckoutAction.scan);
      _captureController.pause();
    });
  }

  // _onValidate()

  _checkoutQR(String qrCode, CheckoutAction action) async {
    setState(() {
      action == CheckoutAction.scan ? _isScanning = true : _isValidating = true;
    });

    var res = await GatemanService.checkVisitors(
      authToken: await authToken(context),
      qrCode: qrCode,
    );

    setState(() {
      action == CheckoutAction.scan
          ? _isScanning = false
          : _isValidating = false;
      _visitor = res.first;
    });

    if (_visitor == null) {
      PaysmosmoAlert.showError(
          context: context, message: 'Cannot validate Vistor');
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new VisitorCheckout(
          name: '${_visitor.user.firstName} ${_visitor.user.lastName}',
          houseAddr: 'Block 2A',
          phoneNumber: _visitor.user.phone,
          qrCode: _visitor.qrCode,
          visitorDesc: _visitor.purpose ?? '',
          visitorETA:
              '${_visitor.timeIn ?? '00:00'} - ${_visitor.timeOut ?? '00:00'}',
          visitorName: _visitor.name,
          visitorPhoneNumber: _visitor.phoneNo,
        );
      }));
    }
  }

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
                      child: QRCaptureView(controller: _captureController),
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

                    //Button
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 20.0,
                    //     vertical: 12.0,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     mainAxisSize: MainAxisSize.max,
                    //     children: <Widget>[
                    //       Flexible(
                    //                                   child: TextField(
                    //           controller: _qrTextField,
                    //           decoration: InputDecoration(
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.only(
                    //                 topLeft: Radius.circular(6.0),
                    //                 bottomLeft: Radius.circular(6.0),
                    //               ),
                    //               borderSide: BorderSide(
                    //                 style: BorderStyle.solid,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       GestureDetector(
                    //         onTap: () {
                    //           _checkoutQR(
                    //               _qrTextField.text, CheckoutAction.validate);
                    //         },
                    //         child: Container(
                    //           padding: EdgeInsets.symmetric(
                    //             horizontal: 4.0,
                    //             vertical: 4.0,
                    //           ),
                    //           decoration: BoxDecoration(
                    //             color: GateManColors.primaryColor,
                    //             borderRadius: BorderRadius.only(
                    //               topRight: Radius.circular(6.0),
                    //               bottomRight: Radius.circular(6.0),
                    //             ),
                    //           ),
                    //           child: Text(
                    //             'Validate',
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.w500,
                    //               fontSize: 19.0,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          Center(
            child: Text(_isScanning
                ? 'Scanning..'
                : _isValidating ? 'Validating..' : ''),
          ),
        ],
      ),
    );
  }
}
