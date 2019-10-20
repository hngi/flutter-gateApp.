import 'package:flutter/material.dart';
import 'package:gateapp/core/service/gateman_service.dart';
import 'package:gateapp/utils/colors.dart';

import '../../core/service/profile_service.dart';
import '../../providers/profile_provider.dart';
import '../../utils/GateManAlert/gateman_alert.dart';
import '../../utils/constants.dart';
import '../../utils/errors.dart';
import '../../utils/helpers.dart';

class GatemanWelcome extends StatefulWidget {
  String fullname;
  GatemanWelcome({this.fullname});
  @override
  _GatemanWelcomeState createState() => _GatemanWelcomeState();
}

class _GatemanWelcomeState extends State<GatemanWelcome> {
  int invitations = 2;
  TextEditingController _nameController;
  bool controllerLoaded = false;
  @override
  void initState(){
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose(){
    //widget.fullname = _nameController.text;
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //LoadingDialog dialog = LoadingDialog(context, LoadingDialogType.Normal);
     if (!getProfileProvider(context).initialProfileLoaded){
        loadInitialProfile(context);
     }
    if(controllerLoaded==false){
      setInitBuildControllers(context);
    }

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
                    padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
                    child: Text('Welcome ${widget.fullname}',style: TextStyle(fontSize: 23.0, color: GateManColors.primaryColor, fontWeight: FontWeight.bold))),
          Column(
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(top: 121.0, bottom: 47.0),
                child: Image.asset('assets/images/gateman/welcome.png'),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('You have', style: TextStyle(color: Colors.black54, fontSize: 17.0, fontWeight: FontWeight.bold )),
                  InkWell(onTap: (){Navigator.pushReplacementNamed(context, '/gateman-notifications');},
                    child: Text(' $invitations invitations ', style: TextStyle(color: GateManColors.primaryColor, fontSize: 17.0, fontWeight: FontWeight.bold),)
                    ),
                  
                ],
                
              ),
              Text('from residents', style: TextStyle(color: Colors.black54, fontSize: 17.0, fontWeight: FontWeight.bold))
            ],
          ),
        ],
      ),
    );
  }
    void setInitBuildControllers(BuildContext context) {
      ProfileModel model = getProfileProvider(context).profileModel;
      widget.fullname = model.name;
      _nameController.text = model.name;

      this.setState((){
        controllerLoaded = true;
      });
    }

    Future loadInitialProfile(BuildContext context) async {
      try{
        dynamic response  = await ProfileService.getCurrentUserProfile(
            authToken: await authToken(context)
        );
        if(response is ErrorType){
          print('Error Getting Profile');
          await PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));

        }else{
          await PaysmosmoAlert.showSuccess(context: context, message: 'Profile Updated');
          //print('fffffffffffffffffff');
          print(ProfileModel.fromJson(response));
          getProfileProvider(context).setProfileModel(
              ProfileModel.fromJson(response));
          getProfileProvider(context).setInitialStatus(true);
        }
      } catch (error){
        //print(error);
        await PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(ErrorType.generic));

      }

    }

  Future loadRequests(BuildContext context) async {
    try{
      dynamic response  = await GatemanService.getAllRequests(
          authToken: await authToken(context)
      );
      if(response is ErrorType){
        print('Error Getting Profile');
        await PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(response));

      }else{
        await PaysmosmoAlert.showSuccess(context: context, message: 'Profile Updated');
        //print('fffffffffffffffffff');
        print(ProfileModel.fromJson(response));
        getProfileProvider(context).setProfileModel(
            ProfileModel.fromJson(response));
        getProfileProvider(context).setInitialStatus(true);
      }
    } catch (error){
      //print(error);
      await PaysmosmoAlert.showError(context: context, message: GateManHelpers.errorTypeMap(ErrorType.generic));

    }

  }
}
