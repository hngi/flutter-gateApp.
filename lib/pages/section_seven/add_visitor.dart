import 'package:flutter/material.dart';
import 'package:gateapp/pages/Select_Estate.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'add_visitor_part.dart';

class AddVisitor extends StatefulWidget {
  @override
  _AddVisitorState createState() => _AddVisitorState();
}

class _AddVisitorState extends State<AddVisitor>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {

    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {

    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: GateManColors.primaryColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Visitor',
          style: TextStyle(color: GateManColors.primaryColor, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body:  AddVisitorPart(),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/homepage');
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
        onLeadingClicked: () {Navigator.pushNamed(context, '/homepage');},
        onTrailingClicked: () {},
      ),
    );
  }
}

//class RButton extends StatelessWidget {}

class NewPage extends StatelessWidget {
  String title;
  NewPage(this.title);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //appBar: new AppBar(title: new Text(title),),
        body: new Center(
      child: new Text(
        title,
        style: new TextStyle(
          fontSize: 30.0,
        ),
      ),
    ));
  }
}
