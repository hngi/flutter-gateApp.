import 'package:flutter/material.dart';
import 'package:xgateapp/pages/Select_Estate.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'add_visitor_part.dart';

class AddVisitor extends StatefulWidget {
  bool editMode = false;
  String initName,initArrivalDate,initArrivalPeriod,initCarPlateNumber,initPurpose,initVisitorsPhoneNo,initVisitorsImageLink,initialGroup;

  int visitorId;

  AddVisitor({this.editMode,this.initName,this.initArrivalDate,this.initArrivalPeriod,this.initCarPlateNumber,
  this.initPurpose,this.initVisitorsPhoneNo,this.initVisitorsImageLink,this.initialGroup,this.visitorId});

  @override
  _AddVisitorState createState() => _AddVisitorState();
}

class _AddVisitorState extends State<AddVisitor>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
          '${this.widget.editMode==true?"Edit":"Add"} Visitor',
          style: TextStyle(color: GateManColors.primaryColor, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body:  AddVisitorPart(
        visitorId: this.widget.visitorId,
        editMode: this.widget.editMode??false,
        initName: this.widget.initName,
        initArrivalDate:this.widget.initArrivalDate,
        initArrivalPeriod: this.widget.initArrivalPeriod,
        initCarPlateNumber: this.widget.initCarPlateNumber,
        initPurpose: this.widget.initPurpose,
        initVisitorsPhoneNo: this.widget.initVisitorsPhoneNo,
        initVisitorsImageLink: this.widget.initVisitorsImageLink,
        initialGroup: this.widget.initialGroup,
      ),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pop(context);
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
        onLeadingClicked: () {Navigator.pushReplacementNamed(context, '/homepage');},
        onTrailingClicked: () {Navigator.pushReplacementNamed(context, '/resident-notifications');},
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
