import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xgateapp/core/models/screen_models.dart';
import 'package:xgateapp/providers/visitor_provider.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomCheckBox/custom_checkbox.dart';
import 'package:xgateapp/widgets/CustomDatePicker/custom_date_picker.dart';
import 'package:xgateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:xgateapp/widgets/GateManBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:xgateapp/widgets/GateManBottomNavFAB/bottom_nav_fab.dart';
import 'package:xgateapp/widgets/VisitorsTiles/visitorsTile.dart';

class MyVisitors extends StatefulWidget {
  @override
  _MyVisitorsState createState() => _MyVisitorsState();
}

List _visitors = [
  {
    "name": "James Cameron",
    "relation": "Friend",
    "phone": "0812567898",
    "date": "2nd Nov 2019",
    "avatarLink": "assets/images/avatar2.jpg"
  },
  {
    "name": "Mr. Seun Adeyini",
    "relation": "Father",
    "phone": "0486332555",
    "date": "1st Dec 2019",
    "avatarLink": "assets/images/avatar2.jpg"
  },
  {
    "name": "Mrs. Angelina Taffo",
    "relation": "Wife",
    "phone": "6987533255",
    "date": "3th august 2020",
    "avatarLink": "assets/images/avatar2.jpg"
  },
];

class _MyVisitorsState extends State<MyVisitors> {
  final Map<int, Widget> children = <int, Widget>{
    0: Padding(
      child: Text(
        'Scheduled',
        style: TextStyle(color: scheduledColor),
      ),
      padding: EdgeInsets.all(10.0),
    ),
    1: Padding(
      child: Text('Saved', style: TextStyle(color: savedColor)),
      padding: EdgeInsets.all(10.0),
    ),
    2: Padding(
      child: Text('History', style: TextStyle(color: historyColor)),
      padding: EdgeInsets.all(10.0),
    ),
  };

  static Color scheduledColor = Colors.grey;
  static Color savedColor = Colors.grey;
  static Color historyColor = Colors.grey;

   Map<int, Widget> icons(BuildContext context) => <int, Widget>{
    0: Center(
      child: scheduledTab(context),
    ),
    1: Center(
      child: savedTab(context),
    ),
    2: Center(
      child: historyTab(context),
    ),
  };

  int sharedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Visitors'),
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
      body: RefreshIndicator(
        onRefresh: ()async{
          await loadScheduledVisitors(context);
          return loadResidentsVisitorHistory(context);
          ;
        },
              child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: CupertinoPageScaffold(
            child: DefaultTextStyle(
              style: CupertinoTheme.of(context).textTheme.textStyle,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 500.0,
                      child: CupertinoSegmentedControl<int>(
                        children: children,
                        onValueChanged: (int newValue) {
                          setState(() {
                            sharedValue = newValue;
                            /*if(newValue == 0){
                          setState(() {
                           scheduledColor = Colors.green; 
                           savedColor = Colors.grey; 
                           historyColor = Colors.grey; 
                          });
                        }else if(newValue == 1){
                          setState(() {
                           scheduledColor = Colors.grey; 
                           savedColor = Colors.green; 
                           historyColor = Colors.grey; 
                          });
                        } else {
                          setState(() {
                           scheduledColor = Colors.grey; 
                           savedColor = Colors.grey; 
                           historyColor = Colors.green; 
                          });
                        }*/
                          });

                          print('$newValue');
                        },
                        groupValue: sharedValue,
                        borderColor: Colors.grey.withOpacity(0.2),
                        selectedColor: Colors.grey.withOpacity(0.2),
                        padding: const EdgeInsets.all(10.0),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                        ),
                        child: Container(
                          child: icons(context)[sharedValue],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget scheduledTab(BuildContext context) {
List<VisitorModel> _visitors = getVisitorProvider(context).scheduledVisitorModels;
return ListView.builder(
  itemCount:_visitors.length,
  itemBuilder: (BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: VisitorTile(
        name: _visitors[index].name,
        phone: _visitors[index].phone_no,
        group: _visitors[index].visitor_group,
        date: _visitors[index].arrival_date,
        timeline: "Expected Arrival",
        buttonText1: "Edit",
        buttonText2: "Remove",
        buttonFunc1: () {
          print(_visitors[index].visitor_group);
          print('${_visitors[index].id}::::::::::::::::::::::::::::::::::::;\n::::::::::::::::');          
          AddEditVisitorScreenModel screenModel = AddEditVisitorScreenModel.fromVisitorModel(_visitors[index]);
          Navigator.pushNamed(context, '/add_visitor',arguments: screenModel);
        },
        avatarLink: _visitors[index].image=='noimage.jpg'?null:_visitors[index].image,
        buttonFunc2: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Are you sure you want to remove visitor ?'),
                  content: Text(
                      'Visitor will no longer be in your scheduled liste.'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')),
                    FlatButton(
                      onPressed: () async{
                        print(':::::u wanna remove from schedule:::::${ _visitors[index].id}');
                        await deleteVisitors(context, _visitors[index].id, from: 'scheduled', index: index);
                        Navigator.pop(context);
                      },
                      child: Text('Remove'),
                    )
                  ],
                );
              });
        },
      ),
    );
  },
);

}

Widget savedTab(BuildContext context){
  List<VisitorModel> _visitors = getVisitorProvider(context).savedVisitorModels;

return ListView.builder(
  itemCount: _visitors.length,
  itemBuilder: (BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: VisitorTile(
        name: _visitors[index].name??'',
        phone: _visitors[index]?.phone_no??'',
        group: _visitors[index]?.visitor_group??'',
        date: _visitors[index].arrival_date??'',
        timeline: "Last Visit",
        buttonText1: "Remove",
        buttonText2: "Schedule Visit",
        buttonFunc2: (){

          showDialog(context: context,
          builder: (context){
            DateTime now = DateTime.now();
            TextEditingController _arrivalDateController = TextEditingController(text: '${now.day}/${now.month}/${now.year}');
            bool morningChecked=true;
                              bool afternoonChecked=false;
                              bool eveningChecked=false;
            return StatefulBuilder(
              
                          builder:(context,setState) {
                              
                            return AlertDialog(actions: <Widget>[
              FlatButton(child: Text('Schedule Visit'), 
                onPressed: () async {
                  scheduleVisit(context, morningChecked?'morning':afternoonChecked?'afternoon':'Evening', _visitors[index].id, _arrivalDateController.text.split('/').reversed.join('-'));
                 
              },),
              FlatButton(child: Text('Cancel'),onPressed: (){
                Navigator.pop(context);
              },)
            ],
            contentPadding: EdgeInsets.zero,
            content: Column(
                children:<Widget> [
                  Container(
                    padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
                    child: Text('Schedule A Visit For ${_visitors[index].name}',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),),
                  decoration: BoxDecoration(
                    color: GateManColors.primaryColor
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                 
                    CustomDatePicker(onChanged: (String value) {
                        _arrivalDateController.text = value;
                    }, onSaved: (String value) {
                      _arrivalDateController.text = value;

                    },
                    selectedDate: _arrivalDateController.text.split('/').map((f)=>int.parse(f)).toList(),
                    includeInput: true, dateController: _arrivalDateController,
                    showingDetail: true,
                    minimumAllowedDate: DateTime.now(),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
              InkWell(child: CustomCheckBox(text: 'Morning',checked: morningChecked,),
              onTap: (){setState(() {
               morningChecked = true;
               afternoonChecked = false;
               eveningChecked = false ;
              });},),
              InkWell(child: CustomCheckBox(text: 'Afternoon',checked: afternoonChecked,),
              onTap: (){
                setState(() {
                  morningChecked = false;
                 afternoonChecked = true;
                  eveningChecked = false;
                });
              },),
              InkWell(child: CustomCheckBox(text: 'Evening',checked: eveningChecked,),
              onTap: (){
                setState(() {
                 morningChecked = false;
                afternoonChecked = false;
                 eveningChecked = true; 
                });
              },),
          ]))
           ]
        ),),
                ]),
                  
              );}
            );
          });
          },

        buttonFunc1: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Are you sure you want to remove visitor ?'),
                  content: Text(
                      'Visitor will no longer be in your scheduled liste.'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')),
                    FlatButton(
                      onPressed: ()async{
                        String name  = _visitors[index].name??'';
                        getVisitorProvider(context).removeVisitorModelFromSaved(_visitors[index],index);
                        await PaysmosmoAlert.showSuccess(context: context,message: 'You deleted $name from your Visitors List');
                        Navigator.pop(context);


                      },
                      child: Text('Remove'),
                    )
                  ],
                );
              });
        },
        avatarLink: _visitors[index].image??null,
      ),
      );
  }
      );
  }


Widget historyTab(BuildContext context){
  List<VisitorModel> _visitorsHistory = getVisitorProvider(context).historyVisitorModels;
  return ListView.builder(
    itemCount: _visitorsHistory.length,
     itemBuilder: (BuildContext context, int index) {
       VisitorModel visitor = _visitorsHistory[index];
       return VisitorTile(
      avatarLink: visitor.image=='noimage.jpg' || visitor.image == null?null:visitor.image,
      name: visitor.name??'',
      group: visitor.visitor_group??'',
      timeline: visitor.arrival_date??'',
      phone: visitor.phone_no??'',
      date: visitor.arrival_date??'',
      buttonText1: '',
      buttonText2: 'Remove',
      buttonFunc1: () {},
      buttonFunc2: ()async{
        print(':::::u wanna remove:::::${ _visitorsHistory[index].id}');
        deleteVisitors(context, _visitorsHistory[index].id, from: 'history', index: index);

      },
    );
     },
);

}
