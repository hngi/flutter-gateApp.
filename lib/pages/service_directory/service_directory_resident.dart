import 'package:flutter/material.dart';
import 'package:gateapp/pages/service_directory/widgets/service-directory_grid_tile.dart';
import 'package:gateapp/utils/helpers.dart';
class ServiceDirectoryResident extends StatelessWidget{
  final List<Map<String,dynamic>> data = [
    {"name":"Clinic","image":'assets/images/clinic-img.png',
    "items":[{"phone_number":"+234 703 600 8893","distance":"0.7km","title":"NCH Health Care Clinic","openingHour":"Always open, 24 Hrs Service","imgSrc":"assets/images/hospita-nch-logo-img.png"},
    {"phone_number":"+234 703 600 8893","distance":"0.7km","title":"NCH Health Care Clinic","openingHour":"Always open, 24 Hrs Service","imgSrc":"assets/images/hospita-nch-logo-img.png"},
    {"phone_number":"+234 703 600 8893","distance":"0.7km","title":"NCH Health Care Clinic","openingHour":"Always open, 24 Hrs Service","imgSrc":"assets/images/hospita-nch-logo-img.png"},
    {"phone_number":"+234 703 600 8893","distance":"0.7km","title":"NCH Health Care Clinic","openingHour":"Always open, 24 Hrs Service","imgSrc":"assets/images/hospita-nch-logo-img.png"}
    ]},
    {"name":"Carpentar","image":'assets/images/carpentar-img.png'},{"name":"Cook","image":'assets/images/cook-img.png'},
    {"name":"Cable\nPayment","image":'assets/images/cable-payment-img.png'},{"name":"Plumber","image":'assets/images/plumber-img.png'},
    {"name":"Electrician","image":'assets/images/electrician-img.png'},
    {"name":"Fire Service","image":'assets/images/fire-service-img.png'}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:GateManHelpers.appBar(context, "Service Directory"),
    body:Container(child: 
    GridView.builder(itemBuilder: (BuildContext context, int index) {

      return ServiceDirectoryResidentGridTile(directoryName: data[index]['name'], directoryImg: data[index]['image'],
      isOdd:index<1?true:index%2==0,data: data[index],);

    

    }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemCount: this.data.length,)));
  }



}