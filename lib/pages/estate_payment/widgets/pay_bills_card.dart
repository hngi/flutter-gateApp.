import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xgateapp/core/models/service_provider.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayBillsCard extends StatelessWidget {
  final bool isOdd;
  final String billName;
  final String img;

  PayBillsCard({
    @required this.isOdd,
    @required this.billName,
    @required this.img,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    ScreenUtil.instance = ScreenUtil(width: 360, height: 780)..init(context);

    return GridTile(
      child: Container(
        child: FlatButton(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(this.img),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      this.billName,
                      style: TextStyle(
                        color: Color(0XFF979797),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          onPressed: () {
            //
          },
        ),
        decoration: myBoxDecoration(),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: Color.fromRGBO(151, 151, 151, 0.2)),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 4.0, // has the effect of softening the shadow
            spreadRadius: 0.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              0.0, // vertical, move down 10
            ),
          )
        ]);
  }
}
