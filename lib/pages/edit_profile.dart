import 'package:flutter/material.dart';
import 'package:gateapp/core/service/profile_service.dart';
import 'package:gateapp/providers/profile_provider.dart';
import 'package:gateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:gateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/errors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _name, _phoneNumber, _email;
  TextEditingController _nameController,
      _phoneNumberController,
      _emailController;

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
    if (!getProfileProvider(context).initialProfileLoaded) {
      loadInitialProfile(context);
    }

    setInitBuildControllers(context);
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Edit Profile'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 23.0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Opacity(
                  opacity: .8,
                  child: ClipOval(
                    child: getProfileProvider(context).profileModel.image ==
                                null ||
                            getProfileProvider(context).profileModel.image ==
                                "no_image.jpg"
                        ? Image.asset(
                            'assets/images/woman-cooking.png',
                          )
                        : Image.network(
                            getProfileProvider(context).profileModel.image),
                  ),
                ),
                Center(
                  child:
                      Icon(Icons.add_a_photo, color: Colors.white, size: 23.0),
                ),
              ],
            ),
          ),

          SizedBox(height: 23.0),

          //Name
          CustomTextFormField(
            labelName: 'Name',
            onChanged: (str) => _nameController.text = str,
            onSaved: (str) => _name = str,
            validator: (str) => str.isEmpty ? 'Name cannot be empty' : null,
            controller: _nameController,
          ),

          //Phone
          CustomTextFormField(
            labelName: 'Phone',
            onChanged: (str) => _phoneNumberController.text = str,
            onSaved: (str) => _phoneNumber = str,
            validator: (str) => str.isEmpty ? 'Phone cannot be empty' : null,
            controller: _phoneNumberController,
          ),

          //Email
          CustomTextFormField(
              labelName: 'Email',
              onChanged: (str) => _emailController.text = str,
              onSaved: (str) => _email = str,
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
              try {
                dynamic response = await ProfileService.setCurrentUserProfile(
                    phone: _phoneNumberController.text,
                    email: _emailController.text,
                    name: _nameController.text,
                    authToken: await authToken(context));
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
                      .setProfileModel(ProfileModel.fromJson(response['user']));
                  dialog.hide();
                }
              } catch (error) {
                ;
                print(error);
                await PaysmosmoAlert.showError(
                    context: context,
                    message: GateManHelpers.errorTypeMap(ErrorType.generic));
                dialog.hide();
              }
            },
          ),
        ],
      ),
    );
  }

  void setInitBuildControllers(BuildContext context) {
    ProfileModel model = getProfileProvider(context).profileModel;
    _nameController.text = model.name;
    _phoneNumberController.text = model.phone;
    _emailController.text = model.email;
  }

  Future loadInitialProfile(BuildContext context) async {
    try {
      dynamic response = await ProfileService.getCurrentUserProfile(
          authToken: await authToken(context));
      if (response is ErrorType) {
        await PaysmosmoAlert.showError(
            context: context, message: GateManHelpers.errorTypeMap(response));
      } else {
        await PaysmosmoAlert.showSuccess(
            context: context, message: 'Profile Updated');
        print('fffffffffffffffffff');
        print(ProfileModel.fromJson(response));
        getProfileProvider(context)
            .setProfileModel(ProfileModel.fromJson(response));
        getProfileProvider(context).setInitialStatus(true);
      }
    } catch (error) {
      print(error);
      await PaysmosmoAlert.showError(
          context: context,
          message: GateManHelpers.errorTypeMap(ErrorType.generic));
    }
  }
}
