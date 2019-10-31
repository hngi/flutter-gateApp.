import 'dart:io';
import 'package:flutter/material.dart';
import 'package:xgateapp/core/service/profile_service.dart';
import 'package:xgateapp/providers/profile_provider.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/core/endpoints/endpoints.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _image;

  String _name, _phoneNumber, _email;
  TextEditingController _nameController,
      _phoneNumberController,
      _emailController;
  bool controllerLoaded = false;

  bool showingImagePickerDialog;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    LoadingDialog dialog = LoadingDialog(context, LoadingDialogType.Normal);
    // if (!getProfileProvider(context).initialProfileLoaded){
    //    loadInitialProfile(context);
    // }
    if (controllerLoaded == false) {
      print('runnig controller in edit proile');
      setInitBuildControllers(context);
    }

    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Edit Profile'),
      body: WillPopScope(
              child: Stack(
                children: <Widget>[ListView(
            padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 23.0),
                child: InkWell(
                  onTap: (){
                        print('object');
                          setState((){
                            showingImagePickerDialog = true;
                          });
                      },
                              child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ClipOval(
                        child: CircleAvatar(
                          radius: 60,
                          child: _image!=null?Image.file(_image,width: 200,height:250):getProfileProvider(context).profileModel.image ==
                                    null ||
                                getProfileProvider(context).profileModel.image ==
                                    "no_image.jpg" ||
                                getProfileProvider(context).profileModel.image ==
                                    'file://noimage.jpg'
                            ? Image.asset(
                                'assets/images/gateman_white.png',
                              )
                            : Image.network(Endpoint.imageBaseUrl+
                                getProfileProvider(context).profileModel.image
                          ),
                      ),
                        ),
                      Center(
                        child:
                            Icon(Icons.add_a_photo, color: Colors.white, size: 23.0),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 23.0),

              //Name
              CustomTextFormField(
                labelName: 'Name',
                //onChanged: (str) => _nameController.text = str,
                onSaved: (str) {
                  setState(() {
                    _name = str;
                  });
                },
                validator: (str) => str.isEmpty ? 'Name cannot be empty' : null,
                controller: _nameController,
              ),

              //Phone
              CustomTextFormField(
                labelName: 'Phone',
                //onChanged: (str) => _phoneNumberController.text = str,
                onSaved: (str) {
                  setState(() {
                    _phoneNumber = str;
                  });
                },
                validator: (str) => str.isEmpty ? 'Phone cannot be empty' : null,
                controller: _phoneNumberController,
              ),

              //Email
              CustomTextFormField(
                  labelName: 'Email',
                  //onChanged: (str) => _emailController.text = str,
                  onSaved: (str) {
                    setState(() {
                      _email = str;
                    });
                  },
                  validator: (str) => str.isEmpty ? 'Email cannot be empty' : null,
                  controller: _emailController),

              SizedBox(height: 40.0),

              ActionButton(
                buttonText: 'Save',
                onPressed: () async {
                  dialog.show();
                  print(_phoneNumberController.text +
                      _emailController.text +
                      _nameController.text);
                  // try {
                    dynamic response = await ProfileService.setCurrentUserProfile(
                        phone: _phoneNumberController.text,
                        email: _emailController.text,
                        name: _nameController.text,
                        image: _image,
                        authToken: await authToken(context));
                    print(response.toString());
                    if (response is ErrorType) {
                      await PaysmosmoAlert.showError(
                          context: context,
                          message: GateManHelpers.errorTypeMap(response));

                      dialog.hide();
                    } else {
                      await PaysmosmoAlert.showSuccess(
                          context: context, message: 'Proile Updated');
                      print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
                      getProfileProvider(context)
                          .profileModel.updateFromMapOrJson(response['user']);
                      getProfileProvider(context).notifyListeners();
                      dialog.hide();
                    }
                  // } catch (error) {
                  //   throw error;
                  //   await PaysmosmoAlert.showError(
                  //       context: context,
                  //       message: GateManHelpers.errorTypeMap(ErrorType.generic));
                  //   dialog.hide();
                  // }
                },
              ),
            ],
          ),
          showingImagePickerDialog==true?
          Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
                        child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        getImage((img){
                          setState(() {
                           _image = img; 
                           showingImagePickerDialog = false;
                          });

                        },ImageSource.camera);
                      },
                                        child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width-10,
                        decoration: BoxDecoration(color: Colors.white),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right:8.0),
                                              child: Icon(Icons.camera_alt),
                                            ),
                                            Text('Take a Picture',textAlign: TextAlign.center,style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        getImage((img){
                          setState(() {
                           _image = img; 
                           showingImagePickerDialog = false;
                          });

                        },ImageSource.gallery);
                      },
                                        child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width-10,
                        decoration: BoxDecoration(color: Colors.white),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right:8.0),
                                              child: Icon(Icons.photo),
                                            ),
                                            Text('Select From Gallery',textAlign: TextAlign.center,style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                      ),
                    ),
                   ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade600.withOpacity(0.5),
            
            ),
          ):Container(width: 0,height: 0),]
        ), onWillPop: ()async{
          if(showingImagePickerDialog==true){
            setState(() {
              showingImagePickerDialog = false;
            });
            return false;
            
          } else{
            return true;
          }
        },
      ),
    );
  }

  void setInitBuildControllers(BuildContext context) {
    ProfileModel model = getProfileProvider(context).profileModel;
    _nameController.text = model.name;
    _phoneNumberController.text = model.phone;
    _emailController.text = model.email;
    this.setState(() {
      controllerLoaded = true;
    });
  }

  // Future loadInitialProfile(BuildContext context) async {
  //   try {
  //     dynamic response = await ProfileService.getCurrentUserProfile(
  //         authToken: await authToken(context));
  //     if (response is ErrorType) {
  //       print('Error Getting Proile');
  //       await PaysmosmoAlert.showError(
  //           context: context, message: GateManHelpers.errorTypeMap(response));
  //     } else {
  //       await PaysmosmoAlert.showSuccess(
  //           context: context, message: 'Profile Updated');
  //           print('was able to get profile');
  //       print(ProfileModel.fromJson(response).image);
  //       getProfileProvider(context)
  //           .setProfileModel(ProfileModel.fromJson(response),jsonString: response);
  //       getProfileProvider(context).setInitialStatus(true);
  //     }
  //   } catch (error) {
  //     print(error);
  //     await PaysmosmoAlert.showError(
  //         context: context,
  //         message: GateManHelpers.errorTypeMap(ErrorType.generic));
  //   }
  // }

 
              
  }
