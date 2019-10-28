import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceDirectoryResidentListTile extends StatefulWidget {
  final String title;
  final String openingHour;
  final String distance;
  final String imgSrc;
  final Function onCallButtonTap;
  ServiceDirectoryResidentListTile(
      {@required this.title,
      @required this.openingHour,
      @required this.distance,
      this.imgSrc,@required
      this.onCallButtonTap});

  @override
  _ServiceDirectoryResidentListTileState createState() =>
      _ServiceDirectoryResidentListTileState();
}

class _ServiceDirectoryResidentListTileState
    extends State<ServiceDirectoryResidentListTile> {
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

  // void setCallModal(){
  //   setState(() {
  //   callModal = true;
  // });
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    ScreenUtil.instance = ScreenUtil(width: 360, height: 780)..init(context);
    return Container(
      decoration: myBoxDecoration(),
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(10), bottom: ScreenUtil().setHeight(10)),
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20),
          top: ScreenUtil().setHeight(20)),
      child: ListTile(
        title: Text(
          this.widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                MyBullet(),
                Expanded(
                  child: Text(
                    this.widget.openingHour,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Container(
              width: ScreenUtil().setWidth(85),
              height: ScreenUtil().setHeight(40),
              margin: EdgeInsets.only(top: 8),
              //padding: EdgeInsets.only(left: 4,right: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: GateManColors.primaryColor),
                  borderRadius: BorderRadius.circular(6)),
              child: FlatButton(
                onPressed: this.widget.onCallButtonTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ImageIcon(
                        AssetImage('assets/images/call-icon.png'),
                        color: GateManColors.primaryColor,
                      ),
                      Text(
                        "Call",
                        style: TextStyle(
                            color: GateManColors.primaryColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
              ),
            )
          ],
        ),
        leading: Container(
          child: Image.asset(widget.imgSrc),
          width: ScreenUtil().setWidth(40),
          height: ScreenUtil().setHeight(40),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xffE74424)),
        ),
        trailing: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 3.0, right: 3.0),
            child: Text(
              this.widget.distance,
              style: TextStyle(color: GateManColors.primaryColor, fontSize: 10),
            ),
          ),
          decoration: BoxDecoration(
              color: GateManColors.primarySwatchColor.shade200,
              borderRadius: BorderRadius.circular(3)),
        ),
      ),
    );
  }
  
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(right: 4),
      width: 5,
      height: 5,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
