import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gateapp/pages/service_directory/widgets/service_directory_list_tile.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';

class ServiceDirectoryResidentDetail extends StatelessWidget {
  static final String routeName = '/service_directory_resident_detail';
  final Map<String, dynamic> detailData;

  ServiceDirectoryResidentDetail({@required this.detailData});

  @override
  Widget build(BuildContext context) {
    print(this.detailData);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    ScreenUtil.instance = ScreenUtil(width: 360, height: 780)..init(context);
    String result = ' results';
    if (this.detailData['items'] == null ||
        this.detailData['items'].length <= 1) {
      result = ' result';
    }

    return Scaffold(
        appBar: GateManHelpers.appBar(context, this.detailData["name"].replaceAll(new RegExp(r'\n'), ' ')),
        body: this.detailData['items']==null||this.detailData['items'].length==0?Center(
          child: Text("No results found in your area"),
        ):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  bottom: ScreenUtil().setHeight(3),
                  top: ScreenUtil().setHeight(20)),
              child: Text(
                this.detailData['items'].length.toString() +
                    result +
                    ' found in your area',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: this.detailData['items'].length,
              itemBuilder: (BuildContext context, int index) {
                return ServiceDirectoryResidentListTile(
                    distance: this.detailData['items'][index]['distance'],
                    openingHour: this.detailData['items'][index]['openingHour'],
                    title: this.detailData['items'][index]['title'],
                    imgSrc: this.detailData['items'][index]['imgSrc'],
                    onCallButtonTap: () {
                      _showMaterialDialog(context,
                          this.detailData['items'][index]['phone_number']);
                    });
              },
            )),
          ],
        ));
  }

  void _showMaterialDialog(context, phoneNumber) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    phoneNumber,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[ FlatButton(
                    onPressed: () {
                      _dismissDialog(context);
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                FlatButton(
                  
                  onPressed: () {
                    _dismissDialog(context);
                  },
                  child: Text(
                    'CALL',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontWeight: FontWeight.bold,color: GateManColors.primaryColor),
                  ),
                )
              ],)
              
                ],
              ),
            ),
           
          );
        });
  }

  _dismissDialog(context) {
    Navigator.pop(context);
  }
}
