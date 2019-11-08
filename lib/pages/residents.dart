import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/gateman_resident_visitors.dart';
import 'package:xgateapp/core/models/user.dart';
import 'package:xgateapp/core/service/gateman_service.dart';
import 'package:xgateapp/pages/gateman_menu.dart';
import 'package:xgateapp/providers/gateman_user_provider.dart';
import 'package:xgateapp/providers/profile_provider.dart';
import 'package:xgateapp/utils/Loader/loader.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/constants.dart' as prefix0;
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:xgateapp/widgets/ResidentExpansionTile/resident_expansion_tile.dart';
import 'package:xgateapp/widgets/ResidentInfoCard/resident_info_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'gateman/menu.dart';

class Residents extends StatefulWidget {
  @override
  _ResidentsState createState() => _ResidentsState();
}

class _ResidentsState extends State<Residents> {
  bool isLoading = false;

  List<GatemanResidentVisitors> _residents = [];
  LoadingDialog dialog;
  int _alerts = 0;

  @override
  void initState() {
    super.initState();
    dialog = LoadingDialog(context, LoadingDialogType.Normal);
    initApp();
  }

  initApp() async {
    setState(() {
      isLoading = true;
    });
    Future.wait([
      GatemanService.allResidentVisitors(
        authToken: await authToken(context),
      ),
      GatemanService.allRequests(authToken: await authToken(context))
    ]).then((res) {
      print(res);
      setState(() {
        _residents = res[0];
        _alerts = res[1].length;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    GatemanUserProvider gateManProvider =
        Provider.of<GatemanUserProvider>(context, listen: false);

    // appIsConnected().then((bool isConn){
    //   if (isConn && !getUserTypeProvider(context).loggeOut){
    //     if(!getProfileProvider(context).loadedFromApi){
    //             loadInitialProfile(context);
    //           }
              
    //     if(!getRequestProvider(context).isLoadedFromApi){
    //       loadInitRequests(context);
    //     }
    //   }
    // });
      
      return Scaffold(
      body: isLoading
          ? Loader.show()
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
              children: <Widget>[
                SizedBox(height: size.height * 0.06),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text('Welcome ${getProfileProvider(context).profileModel?.name??'Loading. . .'}',
                      style: TextStyle(
                        color: GateManColors.blackColor,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Text('Peace Estate',
                      style: TextStyle(
                        color: GateManColors.primaryColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                CustomTextFormField(
                  labelName: '',
                  hintText: 'Search by Name, Phone, Address, Visitor Info',
                  onSaved: (str) {},
                  validator: (str) => null,
                  prefixIcon: Icon(Icons.search),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Residents',
                      style: TextStyle(
                        color: GateManColors.primaryColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                _residents == null || _residents.length == 0
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Icon(Icons.hourglass_empty, size: 50.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('No Residents'),
                          )
                        ],
                      ))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            _residents.map((GatemanResidentVisitors visitor) {
                          User resident = visitor.user;

                          return ResidentExpansionTile(
                            fullName: '${resident.name}',
                            address: resident.home != null && resident.home.houseBlock != null && resident.home.estate != null?
                            '${resident.home.houseBlock}, ${resident.home.estate}':'',
                            phoneNumber: resident.phone,
                            visitText: 'Scheduled Visit',
                            numberCount: '1',
                            visitorApprovalStatus: visitor.status == 0
                                ? 'Not Approved'
                                : 'Approved',
                            visitorDescription: visitor.description,
                            visitorETA:
                                '${visitor.timeIn} - ${visitor.timeOut}',
                            visitorName: visitor.name,
                            visitorPhoneNumber: visitor.phoneNo,
                            visitorVerifyNo: visitor.qrCode,
                          );
                        }).toList(),
                      ),
              ],
            ),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => GateManMenu()));
        },
        icon: MdiIcons.accountGroup,
        title: 'Residents',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        leadingIcon: MdiIcons.apps,
        leadingText: 'Menu',
        traillingIcon: MdiIcons.bell,
        traillingText: 'Alerts',
        alerts: _alerts.toString(),
        onLeadingClicked: () {
          Navigator.pushNamed(context, '/gateman-menu');
        },
        onTrailingClicked: () {
          Navigator.pushReplacementNamed(context, '/gateman-notifications');
        },
      ),
    );
  }
}
