import 'package:flutter/material.dart';
import 'package:gateapp/core/models/estate_list.dart';
import 'package:gateapp/core/models/old_user.dart';
import 'package:gateapp/pages/Add_Estate.dart';
import 'package:gateapp/providers/resident_user_provider.dart';
import 'package:gateapp/providers/user_provider.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/ActionButton/action_button.dart';
import 'package:gateapp/widgets/CustomDropdownButton/custom_dropdown_button.dart';
import 'package:gateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:provider/provider.dart';
import 'package:gateapp/utils/constants.dart';

class SelectAddress extends StatefulWidget {
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  String country, city, estate='', estateAddress;
  Model model = Model();

  List<String> _cities = ['Lagos', 'Abuja', 'Imo'];
  List<String> _countries = ['Nigeria', 'South Africa', 'China'];
  List<String> _estates = ['CBS Esate', 'Lux Eco', '1000 Units'];
  final _formkey = GlobalKey<FormState>();
  final TextEditingController searchEstateController = TextEditingController(text: '');
  List<EstateModel> filteredEstate;
  
 
      //event listeners
      _onCountriesChanged(String value) {
        setState(() => country = value);
      }
    
      _onCitiesChanged(String value) {
        setState(() => city = value);
      }
    
      _onEstatesChanged(String value) {
        print(value);
        setState(() => estate = value);
      }
      @override
      Widget build(BuildContext context) {
        ResidentUserProvider residentUserModel =
        Provider.of<ResidentUserProvider>(context, listen:false);
        AllEstateModel allEstates =
        Provider.of<AllEstateModel>(context, listen:false);
        filteredEstate = allEstates.estates.where((estateModel){
          return estateModel.estateName.toLowerCase().contains(estate.toLowerCase());
        }).toList();
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
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Text(
                        'Input your current location and estate to set you up',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
    
                    //Select Country
                    CustomDropdownButton(
                      label: 'Select Country',
                      hintText: _countries.first,
                      value: country ?? _countries.first,
                      onChanged: _onCountriesChanged,
                      items: _countries.map(
                        (String country) {
                          return DropdownMenuItem(
                            child: Text(country),
                            value: country,
                          );
                        },
                      ).toList(),
                    ),
    
                    //Select City
                    CustomDropdownButton(
                      label: 'Select City',
                      hintText: _cities.first,
                      value: city ?? _cities.first,
                      onChanged: _onCitiesChanged,
                      items: _cities.map(
                        (String city) {
                          return DropdownMenuItem(
                            child: Text(city),
                            value: city,
                          );
                        },
                      ).toList(),
                    ),
    
                    CustomTextFormField(
                      controller: searchEstateController,
                      labelName: ' Select your Estate',
                      hintText: 'Enter Estate Name',
                      suffixIcon: Icon(Icons.keyboard_arrow_up),
                      prefixIcon: Icon(Icons.search),
                      onSaved: (str) => estateAddress = str,
                      onChanged:  _onEstatesChanged,
                      validator: (str) =>
                          str.isEmpty ? 'Estate Address is Required' : null,
                    ),
                    filteredEstate!=null && filteredEstate.length>0?Container(
                      margin: EdgeInsets.only(top:4),
                      height: filteredEstate.length>4?200:filteredEstate.length*38.0,
                      decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: GateManColors.primaryColor)
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                            return InkWell(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(filteredEstate[index].estateName),
                            ),
                            onTap: (){
                              residentUserModel.setResidentEstate(residentEstate:filteredEstate[index]);
                            },);
                          },
                          itemCount: filteredEstate.length,
                            
                          ),
                        ):Container(
                          margin: EdgeInsets.only(top:4,bottom: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: GateManColors.primaryColor)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Estate Not Found",textAlign: TextAlign.center,),
                          ),
                        ),
                        filteredEstate==null || filteredEstate.length<1?
                        Stack(
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
                    ):Container(height: 0,width: 0,),

                        
                    SizedBox(height: 90.0),
    
                    //Save Button
                    ActionButton(
                      buttonText: 'Continue',
                      onPressed: () => {
                        (userType.type == user_type.RESIDENT)
                            ? Navigator.pushNamed(context, '/register')
                            : Navigator.pushNamed(context, '/gateman-register')
                        /*if (userType.type == user_type.RESIDENT){
                      Navigator.pushNamed(context, '/register')
                      } else {
                         Navigator.pushNamed(context, '/gateman-register')
                      }*/
                        //Navigator.pushNamed(context, '/settings')
                        //used line 162 to fix the toggle buttons on settings page as
                        // I couldn't navigate traditionally for some unclear reason
                        //for some reason only this tenary implementation of if else
                        //is accepted by my IDE.
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    
     
}
