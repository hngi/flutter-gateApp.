import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/gateman_residents_request.dart';
import 'package:xgateapp/core/service/gateman_service.dart';
import 'package:xgateapp/pages/gateman/widgets/invitationTile.dart';
import 'package:xgateapp/utils/Loader/loader.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/constants.dart' as prefix0;
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GatemanNotifications extends StatefulWidget {
  @override
  _GatemanNotificationsState createState() => _GatemanNotificationsState();
}

class _GatemanNotificationsState extends State<GatemanNotifications> {

  List<GatemanResidentRequest> _requests = [];

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

    appIsConnected().then((isConn){
      if(isConn && !getUserTypeProvider(context).loggeOut){
        if(!getRequestProvider(context).isLoadedFromApi){
          loadInitRequests(context);
        }
      }
    });
    _requests = getRequestProvider(context).requestList;
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
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/residents');
        },
        icon: MdiIcons.accountGroup,
        title: 'Residents',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        leadingIcon: MdiIcons.home,
        leadingText: 'Home',
        traillingIcon: MdiIcons.bell,
        traillingText: 'Alerts',
        alerts: getRequestProvider(context).requestList.length.toString(),
        onLeadingClicked: () {
          Navigator.pushNamed(context, '/gateman-menu');
        },
        onTrailingClicked: () {
          // Navigator.pushReplacementNamed(context, '/gateman-notifications');
        },
      ),
      body: /*isLoading
          ? Loader.show()
          :*/ _requests == null || _requests.length == 0
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
                      requestId: _requests[index].requestId,
                      rname: _requests[index].name,
                      raddress: _requests[index].username,
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
