import 'package:flutter/material.dart';
import 'package:gateapp/core/models/old_user.dart';
import 'package:gateapp/core/service/auth_service.dart';
import 'package:gateapp/providers/gateman_user_provider.dart';
import 'package:gateapp/providers/resident_user_provider.dart';
import 'package:gateapp/providers/user_provider.dart';
import 'package:gateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:provider/provider.dart';
import 'package:gateapp/utils/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _fullName = 'Mr. B';
  TextEditingController _fullNameController;

  String _email;
  TextEditingController _emailController;
  TextEditingController _phoneController;

  String _phone;
  @override
  void initState(){
    _emailController = TextEditingController(text:'');
    _fullNameController = TextEditingController(text:'');
    _phoneController = TextEditingController(text:'');
  }

  @override
  Widget build(BuildContext context) {
    ResidentUserProvider residentUserModelProvider =
        Provider.of<ResidentUserProvider>(context, listen: false);
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
                'Welcome to a peaceful a safe way to manage your visitors',
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

          CustomTextFormField(
            controller: _emailController,
            labelName: 'Email',
            onSaved: (str) => _email = str,
            onChanged: (str) {
              this._email = str;
            },
            validator: (str) =>
                str.isEmpty ? 'Email cannot be empty' : null,
            //initialValue: _email,
          ),
          CustomTextFormField(
            controller: _phoneController,
            labelName: 'Phone Number',
            onSaved: (str) => _phone = str,
            onChanged: (str) {
              this._phone = str;
            },
            validator: (str) =>
                str.isEmpty ? 'Phone number cannot be empty' : null,
            initialValue: _phone,
          ),

          SizedBox(height: 40.0),

          ActionButton(
            buttonText: 'Join',
            onPressed: () async {
              if(!validateInputs()){
                PaysmosmoAlert.showError(context: context,message: 'Inuput fields cannot be empty');
              


              } else{
                            LoadingDialog dialog = LoadingDialog(context,LoadingDialogType.Normal);
                            dialog.show();
                            
                            try{
                              dynamic response = await AuthService.registerUser(userType: userTypeProvider.type, email: _emailController.text, phone: _phoneController.text, name: _fullNameController.text,)
                              ;
                              
                                print(response);
                                Navigator.pop(context);
                                if (response is ErrorType){
                                    print(response);
                                } else {
                                PaysmosmoAlert.showSuccess(context: context,message: response['message'],);
                                }
                                    
                                Navigator.pushNamed(context, '/token-conirmation');
                              }catch(error){
                                    print(error);
                                    Navigator.pop(context);
                                    PaysmosmoAlert.showError(context: context,message: error.toString(),
                                    );
                                    
              
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
                    if(_fullNameController.text == ''||_phoneController.text == ''||_emailController.text==''){
                      return false;

                    } else {
                      return true;
                    }
                }
}
