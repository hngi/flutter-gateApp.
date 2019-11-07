import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/gateman_resident_visitors.dart';
import 'package:xgateapp/pages/gateman/visitor_check.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/core/service/gateman_service.dart';
import 'package:qrcode/qrcode.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart' as prefix0;
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/DashSeperator/dash_seperator.dart';
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
  String response = '';

  @override
  void initState() {
    super.initState();

    _captureController.onCapture((data) {
      //pause camera
      print('onCapture----$data');
      admitVisitor(data, CheckoutAction.scan);
      _captureController.pause();
    });

    // _checkoutQR('49nost', CheckoutAction.scan);
  }

  // _onValidate()

  admitVisitor(String qrCode, CheckoutAction action) async {
    setState(() {
      action == CheckoutAction.scan ? _isScanning = true : _isValidating = true;
    });

    var res = await GatemanService.admitVisitor(
      authToken: await authToken(context),
      qrCode: qrCode,
    );

    setState(() {
      action == CheckoutAction.scan
          ? _isScanning = false
          : _isValidating = false;

      if (res is ErrorType) {
        response = GateManHelpers.errorTypeMap(res);
      } else {
        _visitor = res;
      }
    });

    if (res is ErrorType) {
      PaysmosmoAlert.showError(context: context, message: response);
      _captureController.resume();
    } else if (_visitor == null) {
      PaysmosmoAlert.showError(
          context: context, message: 'Cannot validate Vistor');
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new VisitorCheckout(
          name: _visitor.user.name,
          houseAddr: _visitor.user.home.houseBlock??'',
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
                child: Row(
                  children: <Widget>[
                    Icon(Icons.keyboard_arrow_left,color:GateManColors.primaryColor),
                    Text("Back",
                    style: TextStyle(
                      color: GateManColors.primaryColor,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    )),

                  ],
                )
                //  Text("< Back",
                //     style: TextStyle(
                //       color: GateManColors.primaryColor,
                //       fontSize: 21.0,
                //       fontWeight: FontWeight.bold,
                //     )),
              ),
            ),
          ),
          // SizedBox(height: size.height * 0.06),
          Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Text('Scan QR Code',
            textAlign: TextAlign.center,
                style: TextStyle(
                  color: GateManColors.blackColor,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7.0,left: 20,right: 20,bottom: 4),
            child: Text('Align the QR code within the frame to scan',
            textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.only(left:15.0,right:15.0,top:5 ),
            child: Card(
              child: Container(
                alignment: Alignment.center,
                width: size.width * 0.75,
                height: size.height * 0.55,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.55 * (3/4),
                      // decoration: ShapeDecoration(
                      //   shape: ScannerOverlayShape(
                      //     borderColor: GateManColors.primaryColor,
                      //     borderWidth: 3.0,
                      //   ),
                      // ),
                      child: Stack(children: [
                        QRCaptureView(controller: _captureController),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 2,height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ), Container(
                                width: 10,height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                              )
                                ],
                              ),

                              Row(crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    width: 10,height: 2,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ), Container(
                                width: 2,height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                              )
                                ],
                              ),
                             
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    width: 2,height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ), Container(
                                width: 10,height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                              )
                                ],
                              ),

                              Row(crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    width: 10,height: 2,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ), Container(
                                width: 2,height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                              )
                                ],
                              ),
                             
                            ],
                          ),
                         
                        ],),
                      )
                      ]),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 13.0,right: 13.0,top: 10.0),
                      child: Text(
                        "Or enter the visitor's code below.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                          color: GateManColors.blackColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right:10),
                      height: 40,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(blurRadius: 0.4,color: Colors.grey)
                        ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                                                    child: Center(
                                                                                                          child: TextField(
                                                                                                            controller: _qrTextField,
                                                      
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: 'Enter Code',
                                
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.transparent)
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.transparent)
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.transparent)
                                )
                              ),
                            ),
                                                    ),
                          ),
                          FlatButton(
                            
                            color: _isScanning || _isValidating?Colors.grey:GateManColors.primaryColor,
                            child:Text('Validate',style:TextStyle(color: Colors.white),),
                            onPressed: (){
                              if (_isScanning || _isValidating){
                                return;
                              }
                              if(_qrTextField.text.length != 6){
                                PaysmosmoAlert.showError(context: context,message: 'Code must be Six characters');
                              } else{
                               admitVisitor(_qrTextField.text, CheckoutAction.validate); 
                              }
                              
                            },
                          ),
                        ],
                      ),
                    )

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
