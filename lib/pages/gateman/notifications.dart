import 'package:flutter/material.dart';
import 'package:gateapp/core/models/gateman_residents_request.dart';
import 'package:gateapp/core/service/gateman_service.dart';
import 'package:gateapp/pages/gateman/widgets/bottomAppbar.dart';
import 'package:gateapp/pages/gateman/widgets/customFab.dart';
import 'package:gateapp/pages/gateman/widgets/invitationTile.dart';
import 'package:gateapp/pages/residents.dart';
import 'package:gateapp/utils/Loader/loader.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GatemanNotifications extends StatefulWidget {
  @override
  _GatemanNotificationsState createState() => _GatemanNotificationsState();
}

class _GatemanNotificationsState extends State<GatemanNotifications> {
  String imageLocation = 'assets/images/gateman/menu.png';
  bool badge = true;
  int _counter = 1;
  bool isLoading = false;

  List<ResidentUser> _requests = [];
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
        _requests = res[0];

        isLoading = false;
      });
    });
  }

  var _notifications = [
    {
      "name": "Janet Thompson",
      "address": "Block 3A, Dele Adebayo GatemanResidentRequest",
      "phone": 08038000000,
    },
    {
      "name": "Mark Evans",
      "address": "UB junction, Molyko GatemanResidentRequest",
      "phone": 07865412876,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final wv = MediaQuery.of(context).size.width / 100;
    final hv = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: <Widget>[
          IconButton(
            icon: Icon(MdiIcons.dotsVertical),
            onPressed: () {},
          )
        ],
      ),
    /*  bottomNavigationBar: CustomBottomAppBar(
        alertText: '${_notifications.length}',
        onTapLocation: '/menu',
        nameOfLocation: 'Menu',
        imageLocation: imageLocation,
      ),
      floatingActionButton: CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
      bottomNavigationBar: CustomBottomNavBar(
        leadingIcon: MdiIcons.home,
        leadingText: 'Home',
        traillingIcon: MdiIcons.bell,
        traillingText: 'Alerts',
        onLeadingClicked: () {
          Navigator.pushNamed(context, '/gateman-menu');
        },
        onTrailingClicked: () {
          // Navigator.pushReplacementNamed(context, '/gateman-notifications');
        },
      ),
      body: isLoading
          ? Loader.show()
          : _requests == null || _requests.length == 0
          ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.hourglass_empty, size: 50.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('You have no Notifications'),
              )
            ],
          ))
          : ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (BuildContext context, int index) {
          return InvitationTile(
            parentContext: context,
            requestId: index,
            rname: _requests[index].name,
            raddress: _requests[index].address,
            rphone: _requests[index].phone,
            func: () {
              Navigator.pushNamed(context, '/residents-gate');
            },
          );
        },
      ),
    );
  }
}
