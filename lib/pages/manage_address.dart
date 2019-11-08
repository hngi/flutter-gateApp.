import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/estate.dart';
import 'package:xgateapp/core/service/estate_service.dart';
import 'package:xgateapp/pages/Add_Estate.dart';
import 'package:xgateapp/pages/about.dart';
import 'package:xgateapp/providers/profile_provider.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomDropdownButton/custom_dropdown_button.dart';
import 'package:xgateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';

class ManageAddress extends StatefulWidget {

  String houseBlock;
  ManageAddress({this.houseBlock});

  @override
  _ManageAddressState createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  List<Estate> _filteredEstates = <Estate>[];
  final TextEditingController searchEstateController =
      TextEditingController(text: '');
 TextEditingController houseBlockController = TextEditingController(text: '');
  bool isLoading = false;
  int selectedEstateId;

  LoadingDialog dialog;

 

  void initState() {
    super.initState();
    dialog = LoadingDialog(context, LoadingDialogType.Normal);
    print(this.widget.houseBlock);
    houseBlockController.text = this.widget.houseBlock??'';

  }

  _onTextFieldChanged(String value) async {
    if (searchEstateController.text != '') {
      setState(() => isLoading = true);

      List<Estate> res = await EstateService.searchEstates(
        query: searchEstateController.text,
        authToken: await authToken(context),
      );

      setState(() {
        _filteredEstates = res;
        isLoading = false;
      });
    }
  }

  _onSave() async {
    dialog.show();

    dynamic result = await EstateService.selectEstate(
      estateId: selectedEstateId??getProfileProvider(context).profileModel.homeModel.estateId,
      authToken: await authToken(context),
      houseBlock: houseBlockController.text??''
    );
    dialog.hide();
    print(result is String);

    if (result is ErrorType==false) {
      PaysmosmoAlert.showSuccess(
              context: context, message: 'Address Updated')
          .then((_) {
            if(getProfileProvider(context).profileModel==null) getProfileProvider(context).setProfileModel(ProfileModel());
            getProfileProvider(context).profileModel.homeModel.houseBlock = result['user_details']['house_block'];
            if(getProfileProvider(context).profileModel.homeModel.estateId != result['user_details']['estate']['id']){
                getProfileProvider(context).profileModel.homeModel.estateId = result['user_details']['estate']['id'];
                getProfileProvider(context).profileModel.homeModel.estate = Estate.fromJson(result['user_details']['estate']);

            }
            // ProfileModel model = getProfileProvider(context).profileModel;
            getProfileProvider(context).notifyListeners();
        Navigator.pop(context);
      });
    } else {
      PaysmosmoAlert.showError(
          context: context, message: 'Could not Update address, please try again');
      //     .then((_) {
      //   Navigator.pushReplacementNamed(context, mapUserTypeToPage[getUserType]);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, 'Manage Address'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
                'Update your flat number and if you have moved to another estate update the current location and Estate name',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17.0)),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Text('Select your Estate',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0)),
          ),
          TextField(
            onChanged: _onTextFieldChanged,
            controller: searchEstateController,
            style: TextStyle(
              color: GateManColors.textColor,
            ),
            decoration: InputDecoration(
              hintText: 'Search by Estate name, City or Country',
              prefixIcon: Icon(Icons.search),
              suffixIcon: GestureDetector(
                child: Icon(Icons.cancel),
                onTap: () => searchEstateController.clear(),
              ),
              // suffix: suffix ?? SizedBox(),
              contentPadding: EdgeInsets.all(10.0),
              focusedBorder: GateManHelpers.textFieldBorder,
              enabledBorder: GateManHelpers.textFieldBorder,
              border: GateManHelpers.textFieldBorder,
            ),
          ),

          searchEstateController.text != ''
              ? isLoading
                  ? Text('Loading..')
                  : _filteredEstates != null || _filteredEstates.length > 0
                      ? Container(
                          margin: EdgeInsets.only(top: 4),
                          height: _filteredEstates.length > 4
                              ? 200
                              : _filteredEstates.length * 38.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: GateManColors.primaryColor)),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      '${_filteredEstates[index].estateName}, ${_filteredEstates[index].city}, ${_filteredEstates[index].country}'),
                                ),
                                onTap: () {
                                  Estate est = _filteredEstates[index];
                                  //set estate id to controller
                                  setState(() {
                                    searchEstateController.text =
                                        est.estateName +
                                            ', ' +
                                            est.city +
                                            ', ' +
                                            est.country;
                                    selectedEstateId = est.estateId;
                                  });
                                },
                              );
                            },
                            itemCount: _filteredEstates.length,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 4, bottom: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: GateManColors.primaryColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Estate Not Found",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
              : SizedBox(),

          _filteredEstates == null || _filteredEstates.length < 1
              ? Stack(
                  children: <Widget>[
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text('Could not find my Estate?, Please contact the admin',
                        textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13.0,
                                color: GateManColors.textColor,
                                fontWeight: FontWeight.w600)),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => AddEstate()),
                        // );
                      },
                    ),
                 ],
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
            child: Text('House Address',style: TextStyle(color: Colors.black),),
          ),
          CustomInputField(hint: 'Your House Address', keyboardType: TextInputType.multiline, prefix: null,
          textEditingController: houseBlockController,),
          SizedBox(height: 22.0),

          //Save Button
          ActionButton(
            buttonText: 'Save',
            onPressed: _onSave,
          )
        ],
      ),
    );
  }
}
