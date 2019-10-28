import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xgateapp/core/models/service_provider.dart';
import 'package:xgateapp/core/service/service_provider_service.dart';
import 'package:xgateapp/pages/service_directory/widgets/service_directory_list_tile.dart';
import 'package:xgateapp/utils/Loader/loader.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/helpers.dart';

class ServiceDirectoryResidentDetail extends StatefulWidget {
  static final String routeName = '/service_directory_resident_detail';
  final ServiceProviderCategory category;

  ServiceDirectoryResidentDetail({@required this.category});

  @override
  _ServiceDirectoryResidentDetailState createState() =>
      _ServiceDirectoryResidentDetailState();
}

class _ServiceDirectoryResidentDetailState
    extends State<ServiceDirectoryResidentDetail> {
  List<ServiceProvider> _serviceProviders = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    setState(() {
      isLoading = true;
    });

    Future.wait([
      ServiceProviderService.getServiceProvidersByCategoryID(
        authToken: await authToken(context),
        categoryID: widget.category.id,
      )
    ]).then((res) {
      setState(() {
        isLoading = false;
        _serviceProviders = res[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    ScreenUtil.instance = ScreenUtil(width: 360, height: 780)..init(context);
    String result = ' results';
    if (_serviceProviders == null || _serviceProviders.length <= 1) {
      result = ' result';
    }

    return Scaffold(
        appBar: GateManHelpers.appBar(
            context, widget.category.title.replaceAll(new RegExp(r'\n'), ' ')),
        body: isLoading
            ? Loader.show()
            : _serviceProviders == null || _serviceProviders.length == 0
                ? Center(
                    child: Text("No results found in your area"),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(20),
                            bottom: ScreenUtil().setHeight(3),
                            top: ScreenUtil().setHeight(20)),
                        child: Text(
                          _serviceProviders.length.toString() +
                              result +
                              ' found in your area',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: _serviceProviders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ServiceDirectoryResidentListTile(
                              distance: '0.7km',
                              openingHour: '24 Hrs',
                              title: _serviceProviders[index].name,
                              imgSrc: "assets/images/hospita-nch-logo-img.png",
                              onCallButtonTap: () {
                                _showMaterialDialog(
                                  context,
                                  _serviceProviders[index].phone,
                                );
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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                    children: <Widget>[
                      FlatButton(
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
                          launchCaller(
                            context: context,
                            phone: phoneNumber,
                          );
                        },
                        child: Text(
                          'CALL',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: GateManColors.primaryColor),
                        ),
                      )
                    ],
                  )
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
