import 'package:flutter/material.dart';
import 'package:gateapp/core/service/gateman_service.dart';
import 'package:gateapp/pages/gateman/widgets/residentTile.dart';
import 'package:gateapp/pages/gateman_menu.dart';
import 'package:gateapp/providers/gateman_user_provider.dart';
import 'package:gateapp/providers/profile_provider.dart';
import 'package:gateapp/utils/Loader/loader.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:gateapp/widgets/ResidentExpansionTile/resident_expansion_tile.dart';
import 'package:gateapp/widgets/ResidentInfoCard/resident_info_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'gateman/menu.dart';

class Residents extends StatefulWidget {
  @override
  _ResidentsState createState() => _ResidentsState();
}

class _ResidentsState extends State<Residents> {

  bool isLoading = false;

  List<ResidentUser> _residents = [];
  LoadingDialog dialog;

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
      GateManService.allRequests(
        authToken: await authToken(context),
      ),
    ]).then((res) {
      print(res);
      setState(() {
        _residents = res[0];

        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    GatemanUserProvider gateManProvider =
        Provider.of<GatemanUserProvider>(context, listen: false);

    //Residents dummy Data
    /*List<Map<String, dynamic>> _residents = [
      {
        "id": 1,
        "fullName": "Mr. Seun Adeniyi",
        "address": "Block 3A, Dele Adebayo Estate",
        "phoneNumber": "0812345678",
      },
      {
        "id": 2,
        "fullName": "Janet Thompson",
        "address": "Block 3A, Dele Adebayo Estate",
        "phoneNumber": "0812345678",
      },
    ];

    //Visitors dummy Data
    List<Map<String, dynamic>> _visitors = [
      {
        "id": 1,
        "residentId": 1,
        "fullName": "Jane Doe",
        "desc": "Tall, Fair & ..",
        "phoneNumber": "0812345678",
        "eta": "00:00 - 00:00",
        "verifiedWith": "LA7739JA",
      },
      {
        "id": 2,
        "residentId": 2,
        "fullName": "John Doe",
        "desc": "Tall, Fair & ..",
        "phoneNumber": "0812345678",
        "eta": "00:00 - 00:00",
        "verifiedWith": "LA7739JA",
      },
      {
        "id": 3,
        "residentId": 2,
        "fullName": "Jane Doe",
        "desc": "Tall, Fair & ..",
        "phoneNumber": "0812345678",
        "eta": "00:00 - 00:00",
        "verifiedWith": "LA7739JA",
      }
    ];
*/
    ProfileModel profileModel = setMenuModel(context);

    return Scaffold(
      body: isLoading? Loader.show
      : ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          SizedBox(height: size.height * 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Text('Welcome ${gateManProvider.gatemanUser?.fullName?? profileModel?.name?? 'Loading. . .'}',
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
              _residents.map((ResidentUser res) {
                //User resident = res.user;

                return ResidentTile(
                 name: res.name,
                  address: res.address,
                  phone: res.phone,
                );
              }).toList(),
                ),
          ],
          ),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => GateManMenu()));
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
class ResidentUser {
  //final int index;
  final String name, address, phone;

  ResidentUser({this.name, this.address, this.phone});

  factory ResidentUser.fromJson(Map<String, dynamic> json){
    return ResidentUser(
        name: json['name'],
        address: json['address'],
        phone: json['phone']
    );
  }
}
