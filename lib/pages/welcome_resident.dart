import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xgateapp/providers/visitor_provider.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



class WelcomeResident extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

     appIsConnected().then((isConnected)async{
       if (isConnected == true && getUserTypeProvider(context).loggeOut==false){
         print('Appppppppppppppp is connected');
         if(getFCMTokenProvider(context).fcmToken != null && getFCMTokenProvider(context).loadedToServer == false && getFCMTokenProvider(context).loading == false){
           print('setting fcm token');
           setFCMTokenInServer(context);
           
         }
         if(getProfileProvider(context).loadedFromApi == false && getProfileProvider(context).loading != true){
           print('loadinf initial profile');
               loadInitialProfile(context);
           }
           if(getVisitorProvider(context).loadedFromApi == false && getVisitorProvider(context).loading != true){
             print('loading initial visitors list');
             loadInitialVisitors(context);
           }
           if(getResidentNotificationProvider(context).loadedFromApi == false && getResidentNotificationProvider(context).loading != true){
             print('loading resident notification');
                  loadResidentNotificationFromApi(context);
           }
           if(getResidentsGateManProvider(context).loadedFromApi==false && getResidentsGateManProvider(context).loadingAccepted !=true){
            print('loading accepted gateman');
      loadGateManThatAccepted(context);
     }
     if(getResidentsGateManProvider(context).pendingloadedFromApi == false && getResidentsGateManProvider(context).loadingPending != true){
       print('loading pending gateman');
       loadGateManThatArePending(context);
     }
     if(getVisitorProvider(context).scheduledVisitorsLoadedFromApi == false && getVisitorProvider(context).scheduledVisitorsLoading == false){
       loadScheduledVisitors(context);
     }
     if(getVisitorProvider(context).historyVisitorsLoadedFromApi == false && getVisitorProvider(context).historyVisitorsLoading == false){
      loadResidentsVisitorHistory(context);
     }
       }
       
     });
     List<VisitorModel> pageModel = getVisitorProvider(context).scheduledVisitorModels;
               return Scaffold(
                 body: pageModel.length == 0
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
                         children: getVisitors(context, size, pageModel),
                       ),
                
               );
             }
           
             getVisitors(BuildContext context, size,List<VisitorModel> pageModel) {
               List<Widget> visitors = <Widget>[
                 SizedBox(height: size.height * 0.06),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 6.0),
                   child: Text('Hi, ${getProfileProvider(context).profileModel.name==null?'...':getProfileProvider(context).profileModel.name}',
                       style: TextStyle(
                         color: GateManColors.primaryColor,
                         fontSize: 24.0,
                         fontWeight: FontWeight.w700,
                       )),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 16.0),
                   child: Text(getProfileProvider(context).profileModel.homeModel==null?'':getProfileProvider(context).profileModel.homeModel.estate.estateName,
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
                 // Text('Today',
                 //     style: TextStyle(
                 //       color: Colors.grey,
                 //       fontSize: 16.0,
                 //       fontWeight: FontWeight.w800,
                 //     )),
                 // Container(
                 //     decoration: BoxDecoration(
                 //       border: Border.all(
                 //         color: GateManColors.primaryColor,
                 //         style: BorderStyle.solid,
                 //         width: .7,
                 //       ),
                 //       borderRadius: BorderRadius.circular(6.0),
                 //     ),
                 //     padding:
                 //         EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
                 //     margin: EdgeInsets.symmetric(vertical: 8.0),
                 //     child: ListTile(
                 //       contentPadding: EdgeInsets.zero,
                 //       title: Text(
                 //         "Mr. Seun Adeniyi",
                 //         style: TextStyle(
                 //           fontWeight: FontWeight.w700,
                 //           fontSize: 18.0,
                 //           color: GateManColors.blackColor,
                 //         ),
                 //       ),
                 //       subtitle: Text(
                 //         "Designation - Cook",
                 //         style: TextStyle(
                 //           fontWeight: FontWeight.w500,
                 //           fontSize: 15.0,
                 //           color: Colors.grey,
                 //         ),
                 //       ),
                 //       trailing: //Add Button
                 //           Container(
                 //         alignment: Alignment.center,
                 //         padding: EdgeInsets.all(3.0),
                 //         decoration: BoxDecoration(
                 //           borderRadius: BorderRadius.circular(4.0),
                 //           color: GateManColors.yellowColor,
                 //         ),
                 //         height: 32.0,
                 //         width: 70.0,
                 //         child: Text('Morning',
                 //             style: TextStyle(
                 //                 color: Colors.black,
                 //                 fontSize: 14.0,
                 //                 fontWeight: FontWeight.w600)),
                 //       ),
                 //     )),
                 // SizedBox(height: 10.0),
                 // Text('Yesterday',
                 //     style: TextStyle(
                 //       color: Colors.grey,
                 //       fontSize: 16.0,
                 //       fontWeight: FontWeight.w800,
                 //     )),
                 // Container(
                 //     decoration: BoxDecoration(
                 //       border: Border.all(
                 //         color: GateManColors.primaryColor,
                 //         style: BorderStyle.solid,
                 //         width: .7,
                 //       ),
                 //       borderRadius: BorderRadius.circular(6.0),
                 //     ),
                 //     padding:
                 //         EdgeInsets.symmetric(vertical: 0.0, horizontal: 14.0),
                 //     margin: EdgeInsets.symmetric(vertical: 8.0),
                 //     child: ListTile(
                 //       contentPadding: EdgeInsets.zero,
                 //       title: Text(
                 //         "Mr. Seun Adeniyi",
                 //         style: TextStyle(
                 //           fontWeight: FontWeight.w700,
                 //           fontSize: 18.0,
                 //           color: GateManColors.blackColor,
                 //         ),
                 //       ),
                 //       subtitle: Text(
                 //         "Designation - Cook",
                 //         style: TextStyle(
                 //           fontWeight: FontWeight.w500,
                 //           fontSize: 15.0,
                 //           color: Colors.grey,
                 //         ),
                 //       ),
                 //       trailing: //Add Button
                 //           Container(
                 //         alignment: Alignment.center,
                 //         padding: EdgeInsets.all(3.0),
                 //         decoration: BoxDecoration(
                 //           borderRadius: BorderRadius.circular(4.0),
                 //           color: GateManColors.blueColor,
                 //         ),
                 //         height: 32.0,
                 //         width: 70.0,
                 //         child: Text('Evening',
                 //             style: TextStyle(
                 //                 color: Colors.black,
                 //                 fontSize: 14.0,
                 //                 fontWeight: FontWeight.w600)),
                 //       ),
                 //     )),
                 // SizedBox(height: 30.0),
                 ActionButton(
                   buttonText: 'Add Visitor',
                   onPressed: () {
                     Navigator.pushNamed(context, '/add_visitor');
                   },
                 ),
               ];
               List usedDates = [];
           
               visitors
                   .addAll(pageModel.reversed.map((visitorModel) {
                    
                 List<String> arrival_date_array = visitorModel.arrival_date==null?"00-00-00".split('-'):visitorModel.arrival_date.split('-');
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
                                             : usedDates.contains(int.parse(arrival_date_array[0]) == DateTime.now().year &&
                             int.parse(arrival_date_array[1]) ==
                                 DateTime.now().month && int.parse(arrival_date_array[2]) ==
                                 DateTime.now().day?'Today':int.parse(arrival_date_array[0]) == DateTime.now().year &&
                             int.parse(arrival_date_array[1]) ==
                                 DateTime.now().month && int.parse(arrival_date_array[2]) ==
                                 DateTime.now().day + 1?'Tomorrow':int.parse(arrival_date_array[0]) == DateTime.now().year &&
                             int.parse(arrival_date_array[1]) ==
                                 DateTime.now().month && int.parse(arrival_date_array[2]) ==
                                 DateTime.now().day -1?'Yesterday': 
                                               visitorModel.arrival_date
                                               ) == false
                                            ? getHeadText(usedDates,visitorModel)
                                                                         : Container(
                                                                             width: 0,
                                                                             height: 0,
                                                                           )
                         
                                         ],),
                                         Container(
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
                                               child: InkWell(
                                                 onTap: (){
                                             Navigator.pushNamed(context, '/visitor-profile',arguments: visitorModel);
                                           },
                                                                                                child: ListTile(
                                                   contentPadding: EdgeInsets.zero,
                                                   title: Text(
                                                     visitorModel.name??'',
                                                     style: TextStyle(
                                                       fontWeight: FontWeight.w700,
                                                       fontSize: 18.0,
                                                       color: GateManColors.blackColor,
                                                     ),
                                                   ),
                                                   subtitle: Row(
                                                     children: <Widget>[
                                                       Text("Visitor's Group: ",
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.bold,
                                                           fontSize: 15.0,
                                                           color: GateManColors.blackColor

                                                         ),
                                                       ),
                                                        Text(
                                                         visitorModel.visitor_group??'',
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.w500,
                                                           fontSize: 15.0,
                                                           color: Colors.grey,
                                                         ),
                                                       ),

                                                     ],
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
                                                     child: Text(visitorModel.visiting_period==null?
                                                     '...':visitorModel.visiting_period,
                                                         style: TextStyle(
                                                             color: Colors.black,
                                                             fontSize: 14.0,
                                                             fontWeight: FontWeight.w600)),
                                                   ),
                                                 ),
                                               )),
                                       ],
                                     );
                                   }).toList());
                               
                                   return visitors;
                                 }
                               
                                 // void loadInitialVisitorsV(BuildContext context) async {
                         
                                 // try {
                                 
                                 //   dynamic response = await VisitorService.getAllVisitor(
                                 //       authToken: await authToken(context));
                                 //       print(response);
                                 //   if (response is ErrorType) {
                                     
                                 //     PaysmosmoAlert.showError(
                                 //         context: context,
                                 //         message: GateManHelpers.errorTypeMap(response));
                                 //       if(response == ErrorType.no_visitors_found){
                                 //       getVisitorProvider(context).setInitialStatus(true);
                                 //       PaysmosmoAlert.showSuccess(
                                 //         context: context,
                                 //         message: GateManHelpers.errorTypeMap(response));
                                 //         getVisitorProvider(context).setVisitorModels([]);
                                     
                                 //     }   
                                         
                                 //   } else {
                                 //     if (response['visitor'].length == 0) {
                                 //       PaysmosmoAlert.showSuccess(
                                 //           context: context, message: 'No visitors');
                                 //     } else {
                                 //       print('linking data for visitors');
                                 //       print(response['visitor']);
                                 //       dynamic jsonVisitorModels = response['visitor'];
                                 //       List<VisitorModel> models = [];
                                 //       jsonVisitorModels.forEach((jsonModel) {
                                 //         models.add(VisitorModel.fromJson(jsonModel));
                                 //       });
                                 //       getVisitorProvider(context).setVisitorModels(models);
     
                                     
                                 //     }
                                 //   }
                                 // } catch (error) {
                                 //   throw error;
                                 // }
                             
                                 // }
                         
                           getHeadText(List<dynamic> usedDates,VisitorModel visitorModel) {
                             usedDates.add(visitorModel.arrival_date);
                             return Text(prettifyDate(visitorModel.arrival_date.toString()),
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