import 'package:flutter/material.dart';
import 'package:gateapp/core/service/visitor_sevice.dart';
import 'package:gateapp/providers/visitor_provider.dart';
import 'package:gateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:gateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WelcomeResident extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if((getUserTypeProvider(context).firstRunStatus==true || getUserTypeProvider(context).loggingOut == false)){
      if(getProfileProvider(context).initialProfileLoaded){
          loadInitialProfile(context);
      }
      
      if(getVisitorProvider(context).initialVisitorsLoaded == false){
        loadInitialVisitors(context);
      }
      }

    // if (getUserTypeProvider(context).firstRunStatus==true && getUserTypeProvider(context).loggingOut == true){
      
    // }
      
          return Scaffold(
            body: getVisitorProvider(context).visitorModels.length == 0
                ? ListView(
                    padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
                    children: <Widget>[
                      SizedBox(height: size.height * 0.09),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(

                                getProfileProvider(context)
                                    .profileModel
                                    .name==null?'Hi, ...':'Hi, ' + getProfileProvider(context)
                                    .profileModel
                                    .name.toString(),
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
                            print('pushing');
                            Navigator.pushNamed(context, '/add_visitor');
                          },
                        ),
                      ),
                    ],
                  )
                : ListView(
                    padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
                    children: getVisitors(context, size),
                  ),
            floatingActionButton: BottomNavFAB(
              onPressed: () {
                Navigator.pushNamed(context, '/add_visitor');
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
              onLeadingClicked: () {
                print("leading clicked");
                Navigator.pushNamed(context, '/homepage');
              },
              onTrailingClicked: () {
                Navigator.pushNamed(context, '/resident-notifications');
              },
            ),
          );
        }
      
        getVisitors(BuildContext context, size) {
          List<Widget> visitors = <Widget>[
            SizedBox(height: size.height * 0.06),
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text('Hi, ' + getProfileProvider(context).profileModel.name??'...',
                  style: TextStyle(
                    color: GateManColors.primaryColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(getProfileProvider(context).profileModel.homeModel.estate.estateName??'',
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

            ActionButton(
              buttonText: 'Add Visitor',
              onPressed: () {
                Navigator.pushNamed(context, '/add_visitor');
              },
            ),
          ];
          List usedDates = [];
      
          visitors
              .addAll(getVisitorProvider(context).visitorModels.map((visitorModel) {
            List<String> arrival_date_array = visitorModel.arrival_date.split('-');
            return Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                  int.parse(arrival_date_array[0]) == DateTime.now().year &&
                        int.parse(arrival_date_array[1]) ==
                            DateTime.now().month &&
                        int.parse(arrival_date_array[2]) ==
                            DateTime.now().day &&
                        usedDates.contains('Today') == false
                    ? getTodayOrYesterday(usedDates,'Today'):int.parse(arrival_date_array[0]) == DateTime.now().year &&
                        int.parse(arrival_date_array[1]) ==
                            DateTime.now().month &&
                        int.parse(arrival_date_array[2]) ==
                            DateTime.now().day-1 &&
                        usedDates.contains('Yesterday') == false?getTodayOrYesterday(usedDates, 'Yesterday')
                        :int.parse(arrival_date_array[0]) == DateTime.now().year &&
                        int.parse(arrival_date_array[1]) ==
                            DateTime.now().month &&
                        int.parse(arrival_date_array[2]) ==
                            DateTime.now().day + 1 &&
                        usedDates.contains('Tomorrow') == false?
                        getTodayOrYesterday(usedDates, 'Tomorrow')
                                        : usedDates.contains(visitorModel.arrival_date) == false
                                            ? getHeadText(usedDates,visitorModel)
                                                                    : Container(
                                                                        width: 0,
                                                                        height: 0,
                                                                      )

                                    ],),
                                    InkWell(
                                      onTap: (){
                                        Navigator.pushNamed(context, '/visitor-profile',arguments: getVisitorProvider(context).visitorModels.indexOf(visitorModel));
                                      },
                                                                          child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: GateManColors.primaryColor,
                                              style: BorderStyle.solid,
                                              width: .7,
                                            ),
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
                                          margin: EdgeInsets.symmetric(vertical: 8.0),
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(
                                              visitorModel.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18.0,
                                                color: GateManColors.blackColor,
                                              ),
                                            ),
                                            subtitle: Text(
                                              visitorModel.purpose,
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
                                              child: Text(visitorModel.time_in==null?
                                              'morning':visitorModel.time_in,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w600)),
                                            ),
                                          )),
                                    ),
                                  ],
                                );
                              }).toList());
                          
                              return visitors;
                            }

                            void loadInitialVisitorsV(BuildContext context) async {

                            try {

                              dynamic response = await VisitorService.getAllVisitor(
                                  authToken: await authToken(context));
                                  print(response);
                              if (response is ErrorType) {

                                PaysmosmoAlert.showError(
                                    context: context,
                                    message: GateManHelpers.errorTypeMap(response));
                                  if(response == ErrorType.no_visitors_found){
                                  getVisitorProvider(context).setInitialStatus(true);
                                  PaysmosmoAlert.showSuccess(
                                    context: context,
                                    message: GateManHelpers.errorTypeMap(response));

                                }

                              } else {
                                if (response['visitor'].length == 0) {
                                  PaysmosmoAlert.showSuccess(
                                      context: context, message: 'No visitors');
                                } else {
                                  print('linking data for visitors');
                                  print(response['visitor']);
                                  dynamic jsonVisitorModels = response['visitor'];
                                  List<VisitorModel> models = [];
                                  jsonVisitorModels.forEach((jsonModel) {
                                    models.add(VisitorModel.fromJson(jsonModel));
                                  });
                                  getVisitorProvider(context).setVisitorModels(models);


                                }
                              }
                            } catch (error) {
                              throw error;
                            }

                            }
                    
                      getHeadText(List<dynamic> usedDates,VisitorModel visitorModel) {
                        usedDates.add(visitorModel.arrival_date);
                        return Text(visitorModel.arrival_date.toString(),
                        textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800,
                            ));
                      
                      }

                      Widget getTodayOrYesterday(usedDates,String dayString) {
                        // print('adddddding something');
                        usedDates.add(dayString);
                        return Text(dayString,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800,
                            ));
                      }
}
