import 'package:flutter/material.dart';
import 'package:gateapp/providers/gateman_user_provider.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:gateapp/widgets/ResidentExpansionTile/resident_expansion_tile.dart';
import 'package:gateapp/widgets/ResidentInfoCard/resident_info_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class Residents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    GatemanUserProvider gateManProvider =
        Provider.of<GatemanUserProvider>(context, listen: false);

    //Residents dummy Data
    List<Map<String, dynamic>> _residents = [
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

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          SizedBox(height: size.height * 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Text('Welcome ${gateManProvider.gatemanUser.fullName}',
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
          ResidentExpansionTile(
            fullName: 'Janet Thompson',
            address: 'Block 3A, Dele Adebayo Estate',
            phoneNumber: '0812345678',
            visitText: 'Scheduled Visit',
            numberCount: '1',
            visitorApprovalStatus: 'Approved',
            visitorDescription: 'Bald, Tall and ..',
            visitorETA: '00:00 - 00:00',
            visitorName: 'John Doe',
            visitorPhoneNumber: '0812345678',
            visitorVerifyNo: 'LA7739JA',
          ),
          ResidentExpansionTile(
            fullName: 'Mr. Seun Adeniyi',
            address: 'Block 3A, Dele Adebayo Estate',
            phoneNumber: '0812345678',
            visitText: 'Scheduled Visit',
            numberCount: '2',
            visitorApprovalStatus: 'Approved',
            visitorDescription: 'Bald, Tall and ..',
            visitorETA: '00:00 - 00:00',
            visitorName: 'John Doe',
            visitorPhoneNumber: '0812345678',
            visitorVerifyNo: 'LA7739JA',
          ),
        ],
      ),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/residents');
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
          Navigator.pushNamed(context, '/homepage');
        },
        onTrailingClicked: () {
          Navigator.pushReplacementNamed(context, '/gateman-notifications');
        },
      ),
    );
  }
}
