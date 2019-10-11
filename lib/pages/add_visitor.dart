import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:gateapp/widgets/VisitorExpansionTile/visitor_expansion_tile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddAVisitor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Add Visitor'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text("Kindly enter visitor's name below:",
                style: TextStyle(
                  fontSize: 17.0,
                  color: GateManColors.blackColor,
                  fontWeight: FontWeight.w700,
                )),
          ),
          CustomTextFormField(
            labelName: '',
            hintText: 'Enter full name',
            onSaved: (str) {},
            validator: (str) => null,
            prefixIcon: Icon(MdiIcons.account),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Add more details',
                    style: TextStyle(
                      color: GateManColors.primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(width: 10.0),
                Icon(Icons.expand_more, color: GateManColors.primaryColor),
              ],
            ),
          ),
          SizedBox(height: 30.0),
          ActionButton(
            buttonText: 'Add',
            onPressed: () {},
          ),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Visitors',
                style: TextStyle(
                  color: GateManColors.primaryColor,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          VisitorExpansionTile(
            fullName: 'Mr. Seun Adeniyi',
            phoneNumber: '081234567',
            category: 'Family',
          ),
          VisitorExpansionTile(
            fullName: 'Mr. Mark Essien',
            phoneNumber: '081234567',
            category: 'Family',
          ),
          VisitorExpansionTile(
            fullName: 'Mr. Idris Abdulkareem',
            phoneNumber: '081234567',
            category: 'Family',
          ),
        ],
      ),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/residents');
        },
        icon: MdiIcons.account,
        title: 'Visitors',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        leadingIcon: MdiIcons.apps,
        leadingText: 'Menu',
        traillingIcon: MdiIcons.bell,
        traillingText: 'Alerts',
        onLeadingClicked: () {},
        onTrailingClicked: () {},
      ),
    );
  }
}
