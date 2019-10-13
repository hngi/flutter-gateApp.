import 'package:flutter/material.dart';
import 'package:gateapp/providers/resident_user_provider.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class WelcomeResident extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ResidentUserProvider residentUserProvider =
        Provider.of<ResidentUserProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: residentUserProvider.residentUserModel.visitors.length == 0
          ? ListView(
              padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
              children: <Widget>[
                SizedBox(height: size.height * 0.09),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                      'Hi, ' +
                          residentUserProvider
                              .residentUserModel.residentFullName
                              .toString(),
                      style: TextStyle(
                          fontSize: 43.0,
                          fontWeight: FontWeight.bold,
                          color: GateManColors.blackColor)),
                ),
                Image.asset('assets/images/file-card.png'),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text("You are not expecting any guests currently",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: GateManColors.blackColor)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ActionButton(
                    buttonText: 'Add Visitor',
                    onPressed: () {
                      Navigator.pushNamed(context, '/add_visitor');
                    },
                  ),
                ),
              ],
            )
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
              children: <Widget>[
                SizedBox(height: size.height * 0.06),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                      'Hi, ' +
                          residentUserProvider
                              .residentUserModel.residentFullName,
                      style: TextStyle(
                        color: GateManColors.primaryColor,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text('Peace Estate',
                      style: TextStyle(
                        color: GateManColors.primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Text('Incoming Visitors',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w800,
                      )),
                ),
                Text('Today',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                    )),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: GateManColors.primaryColor,
                        style: BorderStyle.solid,
                        width: .7,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Mr. Seun Adeniyi",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                          color: GateManColors.blackColor,
                        ),
                      ),
                      subtitle: Text(
                        "Designation - Cook",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: //Add Button
                          Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: GateManColors.yellowColor,
                        ),
                        height: 32.0,
                        width: 70.0,
                        child: Text('Morning',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600)),
                      ),
                    )),
                SizedBox(height: 10.0),
                Text('Yesterday',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                    )),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: GateManColors.primaryColor,
                        style: BorderStyle.solid,
                        width: .7,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Mr. Seun Adeniyi",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                          color: GateManColors.blackColor,
                        ),
                      ),
                      subtitle: Text(
                        "Designation - Cook",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: //Add Button
                          Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: GateManColors.blueColor,
                        ),
                        height: 32.0,
                        width: 70.0,
                        child: Text('Evening',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600)),
                      ),
                    )),
                SizedBox(height: 30.0),
                ActionButton(
                  buttonText: 'Add Visitor',
                  onPressed: () {},
                ),
              ],
            ),
      floatingActionButton: BottomNavFAB(
        onPressed: () {
          // Navigator.pushReplacementNamed(context, '/homepage');
        },
        icon: MdiIcons.account,
        title: 'Visitors',
      ),
      // floatingActionButton: Container(
      //   height: 90.0,
      //   width: 150.0,
      //   child: FloatingActionButton(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       mainAxisSize: MainAxisSize.min,
      //       children: <Widget>[
      //         Icon(MdiIcons.account, size: 30.0),
      //         Text('Visitors',
      //             style: TextStyle(
      //                 fontWeight: FontWeight.w800,
      //                 color: Colors.white,
      //                 fontSize: 13.0))
      //       ],
      //     ),
      //     backgroundColor: GateManColors.primaryColor,
      //     elevation: 17.0,
      //     onPressed: () {},
      //   ),
      // ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        leadingIcon: MdiIcons.apps,
        leadingText: 'Menu',
        traillingIcon: MdiIcons.bell,
        traillingText: 'Alerts',
        onLeadingClicked: () {
          print("leading clicked");
          Navigator.pushReplacementNamed(context, '/homepage');
        },
        onTrailingClicked: () {
          Navigator.pushReplacementNamed(context, '/resident-notifications');
        },
      ),
      // bottomNavigationBar: Container(
      //   height: 70.0,
      //   child: BottomAppBar(
      //     color: GateManColors.primaryColor,
      //     // shape: CircularNotchedRectangle(),
      //     clipBehavior: Clip.antiAlias,
      //     notchMargin: 0,
      //     elevation: 4.0,
      //     child: BottomNavigationBar(
      //       currentIndex: 0,
      //       type: BottomNavigationBarType.fixed,
      //       selectedItemColor: Colors.white,
      //       backgroundColor: GateManColors.primaryColor,
      //       showSelectedLabels: true,
      //       showUnselectedLabels: true,
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: Icon(MdiIcons.apps, color: Colors.white, size: 35.0),
      //           title: Text('Menu',
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.w700,
      //                 fontSize: 15.0,
      //               )),
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.home, color: Colors.white, size: 28.0),
      //           title: Text(''),
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Stack(
      //             children: <Widget>[
      //               Icon(MdiIcons.bell, color: Colors.white, size: 35.0),
      //               Positioned(
      //                 right: 1.0,
      //                 top: 1.0,
      //                 child: Container(
      //                   height: 16.0,
      //                   width: 16.0,
      //                   alignment: Alignment.center,
      //                   decoration: BoxDecoration(
      //                     color: Colors.red,
      //                     shape: BoxShape.circle,
      //                   ),
      //                   child: Text('1',
      //                       style:
      //                           TextStyle(fontSize: 13.0, color: Colors.white)),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           title: Text('Alerts',
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.w700,
      //                 fontSize: 15.0,
      //               )),
      //         )
      //       ],
      //       onTap: (index) {},
      //     ),
      //   ),
      // ),
    );
  }
}
