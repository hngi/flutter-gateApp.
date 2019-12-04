import 'package:flutter/material.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/providers/visitor_provider.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';

class VisitorProfile extends StatefulWidget {
  final VisitorModel model;
  VisitorProfile({@required this.model});

  @override
  _VisitorProfileState createState() => _VisitorProfileState();
}

class _VisitorProfileState extends State<VisitorProfile> with SingleTickerProviderStateMixin {
  // final _User visitor = _User(
  //   name: 'Mr. Ryan Brain',
  //   phone: '080995653333',
  //   vehicleNo: 'KJA-657AA',
  //   purpose: 'Plumbing work',
  //   eta: '10:40am',
  // );
  // final _User toSee = _User(
  //   name: 'Mr. Frank Dan',
  //   address: 'Plot 4, HNG Street',
  // );
  
  

  @override
  Widget build(BuildContext context) {
    VisitorModel model = this.widget.model;
    DateTime now = DateTime.now();
    List<String> modelArrivalDateArray = model.arrival_date.split('-');
    DateTime visitorsArrivalDateTime = DateTime(int.parse(modelArrivalDateArray[0]),
    int.parse(modelArrivalDateArray[1]), int.parse(modelArrivalDateArray[2]));
    Duration diff = visitorsArrivalDateTime.difference(now);
    print(model.image);
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
          'Visitor Profile',
          style: TextStyle(color: GateManColors.primaryColor, fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 100,
                    maxWidth: 100,
                    minHeight: 100,
                    minWidth: 100,
                  ),
                  child: Container(
                    // padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: model.image==null||model.image=='noimage.jpg'?Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.black54,
                        size: 60,
                      ),
                    ):CircleAvatar(
                      radius: 80,
                      child: FadeInImage.assetNetwork(image: Endpoint.imageBaseUrl+ model.image,
                                            placeholder:'assets/images/gateman_white.png',),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  child: Center(
                    child: Text(
                      model.name,
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.green),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  color: Colors.teal.withOpacity(0.1),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Whom to see',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.contacts,
                              size: 14,
                            ),
                            SizedBox(width: 10),
                            Text(getProfileProvider(context).profileModel.name??'',
                              style: Theme.of(context).textTheme.headline,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.home,
                              size: 14,
                            ),
                            SizedBox(width: 10),
                            Text(
                              getProfileProvider(context).profileModel.homeModel !=null && 
                              getProfileProvider(context).profileModel.homeModel.houseBlock!=null?
                              getProfileProvider(context).profileModel.homeModel.houseBlock:'',// toSee.address,
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                model.phone_no != null && model.phone_no.length > 0?
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          size: 14,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Phone',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: Colors.green),
                          ),
                        ),
                        InkWell(
                          onTap: (){launchCaller(context: context, phone: model.phone_no??'',);},
                                                  child: Text(
                            model.phone_no??'',// visitor.phone,dummy no phone number from backend
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ):Container(width: 0,height: 0,),
                model.car_plate_no != null && model.car_plate_no.length > 0?
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.directions_car,
                          size: 14,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Vehicle Reg. No.',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: Colors.green),
                          ),
                        ),
                        Text(
                          model.car_plate_no??'Nil',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                ):Container(width: 0,height: 0,),
                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.textsms,
                          size: 14,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Purpose',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: Colors.green),
                          ),
                        ),
                        Text(
                          model.purpose != null? model.purpose.toLowerCase() == 'none'?'Not Specified':model.purpose:'Not Specified',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                ),
                model.description !=null && model.description.length>0?
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.description,
                          size: 14,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Description',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: Colors.green),
                          ),
                        ),
                        Text(
                          model.description??'Nil',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                ):Container(width: 0,height: 0,),
                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.directions_run,
                          size: 14,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'ETA',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle
                                .copyWith(color: Colors.green),
                          ),
                        ),
                        Text(
                          diff.inDays<1?diff.inHours<11?diff.inMinutes<1?diff.inSeconds<1?diff.inSeconds<0?'Should have Arrived':'Arriving today':'${diff.inSeconds} sec':'${diff.inMinutes} min':'${diff.inHours} hours':'${diff.inDays} days',
                          // DateTime.now().year == int.parse(model.arrival_date.split('-')[0]) &&
                          // DateTime.now().month == int.parse(model.arrival_date.split('-')[1])&&
                          // DateTime.now().day < int.parse(model.arrival_date.split('-')[2])?'1day+':
                          // DateTime.now().year == int.parse(model.arrival_date.split('-')[0]) &&
                          // DateTime.now().month == int.parse(model.arrival_date.split('-')[1])&&
                          // DateTime.now().day > int.parse(model.arrival_date.split('-')[2])?
                          // 'Should have arrived':'12hour+',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                ),
               ],
            ),
          ],
        ),
      ),
    );
  }
}

class _User {
  final String name;
  final String phone;
  final String vehicleNo;
  final String purpose;
  final String eta;
  final String address;

  _User({
    this.name,
    this.phone,
    this.vehicleNo,
    this.purpose,
    this.eta,
    this.address,
  });
}
