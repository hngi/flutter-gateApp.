import 'package:flutter/material.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String leadingText;
  final String traillingText;
  final IconData leadingIcon;
  final IconData traillingIcon;
  final String alerts;
  final Function onLeadingClicked;
  final Function onTrailingClicked;

  const CustomBottomNavBar({
    Key key,
    @required this.leadingText,
    @required this.traillingText,
    @required this.leadingIcon,
    @required this.traillingIcon,
    @required this.onLeadingClicked,
    @required this.onTrailingClicked,
    this.alerts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: BottomAppBar(
        color: GateManColors.primaryColor,
        // shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 0,
        elevation: 4.0,
        child: BottomNavigationBar(
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          backgroundColor: GateManColors.primaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap:(int index){
            switch (index) {
              case 0:
                onLeadingClicked();
                break;
              case 2:
                onTrailingClicked();
                break;

                
                break;
              default:
              break;
            }
          },
          items: [
            BottomNavigationBarItem(
              
              icon: Icon(leadingIcon, color: Colors.white, size: 35.0),
              title: Text(leadingText,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                  )),

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white, size: 28.0),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Stack(
                  children: <Widget>[
                    Icon(traillingIcon, color: Colors.white, size: 35.0),
                    Positioned(
                      right: 1.0,
                      top: 1.0,
                      child: Container(
                        height: 16.0,
                        width: 16.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: alerts==null||alerts.isEmpty?Text(alerts??' ',
                            style:
                TextStyle(fontSize: 13.0, color: Colors.white)):Container(width: 0,height: 0,),
                      ),
                    ),
                  ],
                ),
              title: Text(traillingText,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
