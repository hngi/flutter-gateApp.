import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceDirectoryResidentGridTile extends StatelessWidget {
  final String directoryName;
  final String directoryImg;
  final bool isOdd;
  final Map<String,dynamic> data;
  ServiceDirectoryResidentGridTile(
      {@required this.directoryName,
      @required this.directoryImg,
      @required this.isOdd,@required this.data});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    ScreenUtil.instance = ScreenUtil(width: 360, height: 780)..init(context);
    
    return GridTile(
      child: Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(30),
            left: isOdd ? ScreenUtil().setWidth(30) : ScreenUtil().setWidth(10),
            right:
                isOdd ? ScreenUtil().setWidth(10) : ScreenUtil().setWidth(30)),
        child: FlatButton(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(this.directoryImg),
                  Text(
                    this.directoryName,
                    style: TextStyle(
                        color: Color(0xff4F4F44), fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          onPressed: () {
            print(directoryName + " tapped");
            Navigator.pushNamed(context, '/service_directory_resident_detail',arguments: this.data);
          },
        ),
        decoration: myBoxDecoration(),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color.fromRGBO(151, 151, 151, 0.2)),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(17, 48, 75, 0.06),
            blurRadius: 2.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              0.0, // vertical, move down 10
            ),
          )
        ]);
  }
}
