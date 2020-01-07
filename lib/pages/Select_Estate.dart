import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/estate.dart';
import 'package:xgateapp/core/models/estate_list.dart';
import 'package:xgateapp/core/models/old_user.dart';
import 'package:xgateapp/core/service/estate_service.dart';
import 'package:xgateapp/pages/Add_Estate.dart';
import 'package:xgateapp/providers/resident_user_provider.dart';
import 'package:xgateapp/providers/user_provider.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/utils/Loader/loader.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart' as prefix0;
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomDropdownButton/custom_dropdown_button.dart';
import 'package:xgateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:provider/provider.dart';
import 'package:xgateapp/utils/constants.dart';

class SelectAddress extends StatefulWidget {
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  String country, city, currentEstate, estateAddress;
  Model model = Model();
  bool isLoading = false;
  int selectedEstateId;

  List<String> _cities = ['Abuja'];
  List<String> _countries = ['Nigeria'];
  List<String> _allEstates = ['SunnyVille'];
  //Future<dynamic> _estates = EstateService.getAllEstates();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController searchEstateController =
      TextEditingController(text: '');

  //get list of estates
  List<Estate> _estates = [];
  List<Estate> _filteredEstates = <Estate>[];
  LoadingDialog dialog;
  bool showingHomeAdressInput = false;
  final _homeAddressController = 
  TextEditingController(text: '');

  Map<user_type, String> mapUserTypeToPage = {
    user_type.RESIDENT: '/resident-main-page',
    user_type.GATEMAN: '/gateman-menu',
  };
  user_type routeString;

  @override
  void initState() {
    super.initState();
    dialog = LoadingDialog(context, LoadingDialogType.Normal);
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
    routeString = await userType(context);
    dialog.show();

    dynamic result = await EstateService.selectEstate(
      estateId: selectedEstateId,
      authToken: await authToken(context),
      houseBlock: _homeAddressController.text
    );
    dialog.hide();

    dynamic getUserType = await userType(context);
    Map<String, String> mapUserTypeToPage = {
      'RESIDENT': '/resident-main-page',
      'GATEMAN': '/gateman-menu',
    };

    if (result is ErrorType == false) {
      PaysmosmoAlert.showSuccess(
              context: context, message: 'Estate Successfully Selected')
          .then((_) async {
            print('pushing to page');
            print(await getUserTypeProvider(context).getUserTypeRoute);
            prefix0.loadInitialProfile(context);
        Navigator.pushReplacementNamed(context, await getUserTypeProvider(context).getUserTypeRoute);
      });
    } else {
      PaysmosmoAlert.showError(
          context: context, message: 'Could not select an Estate');
      //     .then((_) {
      //   Navigator.pushReplacementNamed(context, mapUserTypeToPage[getUserType]);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    AllEstateModel allEstates =
        Provider.of<AllEstateModel>(context, listen: false);
    // filteredEstate = allEstates.estates.where((estateModel) {
    //   return estateModel.estateName
    //       .toLowerCase()
    //       .contains(currentEstate.toLowerCase());
    // }).toList();
    UserTypeProvider userType =
        Provider.of<UserTypeProvider>(context, listen: false);
    return Form(
      key: _formkey,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text('Select Your Estate',
                      style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.green,
                          fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50.0,top: 10,bottom: 30),
                  child: Text(
                    'Input your current location and estate to set you up',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                ),

                //textfield

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Text('Select your Estate',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14.0)),
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
                        : _filteredEstates != null ||
                                _filteredEstates.length > 0
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Estate est = _filteredEstates[index];
                                    return Container(
                                      color: selectedEstateId == est.estateId? GateManColors.primaryColor:Colors.white,
                                      child: InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              '${_filteredEstates[index].estateName}, ${_filteredEstates[index].city}, ${_filteredEstates[index].country}',
                                              style: TextStyle(color: selectedEstateId == est.estateId?Colors.white:GateManColors.blackColor),),
                                        ),
                                        onTap: () {
                                          
                                          //set estate id to controller
                                          setState(() {
                                            searchEstateController.text =
                                                est.estateName +
                                                    ', ' +
                                                    est.city +
                                                    ', ' +
                                                    est.country;
                                            selectedEstateId = est.estateId;
                                            showingHomeAdressInput = true;
                                            _filteredEstates.clear();
                                          });
                                        },
                                      ),
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
                    // _filteredEstates == null || _filteredEstates.length < 1?
                     Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          InkWell(
                            child: Row(
                              children: <Widget>[
                                Text('Could not find my Estate?',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: GateManColors.textColor,
                                        fontWeight: FontWeight.w600)),
                                         Text('Add Estate',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: GateManColors.primaryColor,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                               '/add-estate'
                              );
                            },
                          ),
                        ],
                      ),
                    // : SizedBox(),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: showingHomeAdressInput?
                  CustomTextFormField(labelName: 'Enter Apartment/Flat Number',
                  controller: _homeAddressController,
                  keyboardType: TextInputType.text, onSaved: (String ) {}, validator: (String ) {

                  },
                  hintText: 'Apartment Block, Apartment Number',
                  ):Container(width: 0,height: 0,),
                ),

              

                SizedBox(height: 90.0),

                //Save Button
                ActionButton(
                  buttonText: 'Continue',
                  onPressed: selectedEstateId != null && _homeAddressController.text.length > 0 ? _onSave : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
