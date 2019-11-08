import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/old_user.dart';
import 'package:xgateapp/core/service/auth_service.dart';
import 'package:xgateapp/providers/gateman_user_provider.dart';
import 'package:xgateapp/providers/resident_user_provider.dart';
import 'package:xgateapp/providers/user_provider.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:provider/provider.dart';
import 'package:xgateapp/utils/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _fullName = 'Mr. B';
  TextEditingController _fullNameController;

  String _email;
  // TextEditingController _emailController;
  TextEditingController _phoneController;

  String _phone;

  String countryCode = '+234';

  var validateMessage = 'Input Fields Cannot be Empty';
  @override
  void initState(){
    // _emailController = TextEditingController(text:'');
    _fullNameController = TextEditingController(text:'');
    _phoneController = TextEditingController(text:'');
  }

  @override
  Widget build(BuildContext context) {
    UserTypeProvider userTypeProvider =
        Provider.of<UserTypeProvider>(context, listen: false);

    GatemanUserProvider gateManProvider =
        Provider.of<GatemanUserProvider>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          SizedBox(height: size.height * 0.13),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: GateManHelpers.bigText('Register'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 26.0),
            child: Text(
                'Welcome to a peaceful and safe way to manage your visitors',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: GateManColors.grayColor)),
          ),

          //Full Name
          CustomTextFormField(
            controller: _fullNameController,
            labelName: 'Full Name',
            onSaved: (str) => _fullName = str,
            onChanged: (str) {
              this._fullName = str;
            },
            validator: (str) =>
                str.isEmpty ? 'Full Name cannot be empty' : null,
            //initialValue: _fullName,
          ),

          // CustomTextFormField(
          //   controller: _emailController,
          //   labelName: 'Email',
          //   onSaved: (str) => _email = str,
          //   onChanged: (str) {
          //     this._email = str;
          //   },
          //   validator: (str) =>
          //       str.isEmpty ? 'Email cannot be empty' : null,
          //   //initialValue: _email,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Text('Phone Number',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0)),
          ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Container(
                      width: 80,
                      height: 38,
                      decoration: BoxDecoration(
                        border: Border.all(color: GateManColors.primaryColor),
                        borderRadius: BorderRadius.circular(6)
                      )
,                child:
                    Center(
                                    child: DropdownButton<String>(
                                      underline: Container(width: 0,height: 0,),
                        iconEnabledColor: GateManColors.primaryColor,
                        items:<String>['+234','+233','+232','+235',
                                      '+247','+236','+237'].map<DropdownMenuItem<String>>((String str){
                        return DropdownMenuItem<String>(
                          value: str,
                          child: Text(str)
                        );
                      }).toList(),
                      value: countryCode,
                      onChanged: (String newValue){
                        setState(() {
                           countryCode = newValue;
                        });
                       
                      },
                      ),
                    )),
                  ),
                  Expanded(
                                  child: CustomTextFormField(
                      controller: _phoneController,
                      onSaved: (str) => _phone = str,
                      onChanged: (str) {
                        this._phone = str;
                      },
                      validator: (str) =>
                          str.isEmpty ? 'Phone number cannot be empty' : null,
                      initialValue: _phone,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 40.0),

          ActionButton(
            buttonText: 'Join',
            onPressed: () async {
              if(!validateInputs()){
                PaysmosmoAlert.showError(context: context,message: validateMessage);
              


              } else{
                            LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
                            dialog.show();
                            
                            try{
                              print(countryCode.replaceFirst('+', '')+_phoneController.text);
                              dynamic response = await AuthService.registerUser(userType: userTypeProvider.type, /*email: _emailController.text,*/ phone: countryCode.replaceFirst('+', '')+_phoneController.text, name: _fullNameController.text,)
                              ;
                              
                              print('printing eesponse');
                              print(response);
                                
                                if (response is ErrorType){
                                    print(GateManHelpers.errorTypeMap(response));
                                   
                                  await PaysmosmoAlert.showError(context: context,message: GateManHelpers.errorTypeMap(response),);
                                dialog.hide();
                                } else {

                                await PaysmosmoAlert.showSuccess(context: context,message: response['message'],);
                                dialog.hide();
                                
                                Navigator.pushReplacementNamed(context, '/token-conirmation',arguments: {
                                  'phone':countryCode+_phoneController.text,
                                  // 'email':_emailController.text,
                                  'skip_estate':response['app-hint']!=null && response['app-hint'].toString().toLowerCase() == 'This is an existing user!'.toLowerCase()?true:false
                                });

                                }
                                    
                                
                              }catch(error){
                                    print(error);
                                    
                                    
                                    PaysmosmoAlert.showError(context: context,message: error.toString());
                                    dialog.hide();
                              }
                              
              }
                            // if (userTypeProvider.type == user_type.RESIDENT) {
                            //   print("jjjjjjjjjj" + _fullName);
                            //   residentUserModelProvider.setResidentFullName(
                            //       residentFullName: _fullName);
                            //   Navigator.pushNamed(context, '/welcome-resident');
                            // } else {
                            //   gateManProvider.setFullName(fullName: _fullName);
                            //   Navigator.pushNamed(context, '/residents');
                            // }
                          },
                        ),
                      ],
                    ),
                  );
                }
              
                bool validateInputs() {
                    if(_fullNameController.text == ''||_phoneController.text == '' || validateRegExpPattern(_phoneController.text,r'^[0-9]{10}$')==false){
                                          return false;
                                        } else {
                                          return true;
                                        }
                                    }
                    
                      validateRegExpPattern(String text,String pattern) {
                            RegExp regExp = RegExp(pattern);
                            if (regExp.hasMatch(text)){
                              return true;
                            } else{
                              setState(() {
                               validateMessage = 'Invalid Phone Number, Please enter a 10 digit code and select your country code'; 
                              });
                              return false;
                            }

                      }
}
