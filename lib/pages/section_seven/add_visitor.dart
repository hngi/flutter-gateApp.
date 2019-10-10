import 'package:flutter/material.dart';
import 'package:gateapp/pages/Select_Estate.dart';
import 'package:gateapp/utils/colors.dart';

import 'add_visitor_part.dart';

class AddVisitor extends StatefulWidget {
  @override
  _AddVisitorState createState() => _AddVisitorState();
}


class _AddVisitorState extends State<AddVisitor> with SingleTickerProviderStateMixin{
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController=new TabController(length: 2, vsync: this);
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
        leading: GestureDetector(child: Icon(Icons.arrow_back,color: GateManColors.primaryColor,),onTap: (){
          Navigator.pop(context);
        },),
        title: Text('Add Visitor',style: TextStyle(color: GateManColors.primaryColor,fontSize: 20),),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: new TabBarView(
        children: <Widget>[
          new AddVisitorPart(),
          new NewPage("Space 2"),

        ],

        controller: tabController,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height:100,width:100,
        child:FittedBox(
          child: FloatingActionButton(
            elevation: 10,
            tooltip: 'Visitor',
            child: Padding(
              padding: EdgeInsets.all(4),
              child:Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.person,color: Colors.white,size: 20,),
                  Text('Visitors',style: TextStyle(color: Colors.white,fontSize: 6,fontWeight: FontWeight.w600),)
                ],
              ),
            ),
            onPressed:(){
              Navigator.push(context,MaterialPageRoute(builder:(context)=>NewPage('6')));
            },
            backgroundColor: Colors.green,
          ),
        ),
      ),
      bottomNavigationBar: new Material(
        color: Colors.green,
        child: new TabBar(
            //isScrollable: true,
            controller: tabController,
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.white,
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
            tabs:<Widget>[
              Padding(
                padding: const EdgeInsets.only(right:20.0),
                child: new Tab(
                  icon: new Icon(Icons.menu,color: Colors.white,),
                  text: 'Menu',
                ),
              ),
              new Tab(
                icon: new Icon(Icons.notifications,color:Colors.white,),
                text: 'Alerts',
              ),

            ]
        ),
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
          child: new Text(title,style: new TextStyle(fontSize: 30.0,),),
        )
    );
  }
}
