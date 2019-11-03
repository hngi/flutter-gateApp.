import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/estate.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';

import '../core/service/estate_service.dart';
import '../utils/GateManAlert/gateman_alert.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/errors.dart';
import '../utils/helpers.dart';
import '../widgets/ActionButton/action_button.dart';
import 'Add_Estate.dart';

class GatemanManageAddress extends StatefulWidget {
  @override
  _GatemanManageAddressState createState() => _GatemanManageAddressState();
}

class _GatemanManageAddressState extends State<GatemanManageAddress> {
  List<Estate> _filteredEstates = <Estate>[];
  final TextEditingController searchEstateController = TextEditingController(text: '');

  bool isLoading = false;
  int selectedEstateId;

  LoadingDialog dialog;

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
    );
    dialog.hide();
    print(result is String);

    if (result is ErrorType==false) {
      PaysmosmoAlert.showSuccess(
              context: context, message: 'Estate Successfully Selected')
          .then((_) {
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
          context: context, message: 'Could not select an Estate');
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
            child: Text("Update your Estate current location and estate name", 
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
                        padding: const EdgeInsets.only(left: 80),
                        child: Text('Could not find my Estate?',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: GateManColors.textColor,
                                fontWeight: FontWeight.w600)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddEstate()),
                        );
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 240),
                        child: Text('Add New',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.green,
                                fontWeight: FontWeight.w700)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddEstate()),
                        );
                      },
                    ),
                  ], 
              )
              : SizedBox(),
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