import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gateapp/core/models/service_provider.dart';
import 'package:gateapp/core/service/service_provider_service.dart';
import 'package:gateapp/pages/service_directory/widgets/service-directory_grid_tile.dart';
import 'package:gateapp/utils/Loader/loader.dart';
import 'package:gateapp/utils/constants.dart';
import 'package:gateapp/utils/helpers.dart';

class ServiceDirectoryResident extends StatefulWidget {
  @override
  _ServiceDirectoryResidentState createState() =>
      _ServiceDirectoryResidentState();
}

class _ServiceDirectoryResidentState extends State<ServiceDirectoryResident> {
  List<ServiceProviderCategory> _categories = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    setState(() {
      isLoading = true;
    });

    Future.wait([
      ServiceProviderService.getServiceProviderCategories(
          authToken: await authToken(context))
    ]).then((res) {
      setState(() {
        _categories = res[0];
        isLoading = false;
      });
    });
  }

  final List<Map<String, dynamic>> data = [
    {
      "name": "Clinic",
      "image": 'assets/images/clinic-img.png',
      "items": [
        {
          "phone_number": "+234 703 600 8893",
          "distance": "0.7km",
          "title": "NCH Health Care Clinic",
          "openingHour": "Always open, 24 Hrs Service",
          "imgSrc": "assets/images/hospita-nch-logo-img.png"
        },
        {
          "phone_number": "+234 703 600 8893",
          "distance": "0.7km",
          "title": "NCH Health Care Clinic",
          "openingHour": ";Always open, 24 Hrs Service",
          "imgSrc": "assets/images/hospita-nch-logo-img.png"
        },
        {
          "phone_number": "+234 703 600 8893",
          "distance": "0.7km",
          "title": "NCH Health Care Clinic",
          "openingHour": "Always open, 24 Hrs Service",
          "imgSrc": "assets/images/hospita-nch-logo-img.png"
        },
        {
          "phone_number": "+234 703 600 8893",
          "distance": "0.7km",
          "title": "NCH Health Care Clinic",
          "openingHour": "Always open, 24 Hrs Service",
          "imgSrc": "assets/images/hospita-nch-logo-img.png"
        }
      ]
    },
    {"name": "Carpentar", "image": 'assets/images/carpentar-img.png'},
    {"name": "Cook", "image": 'assets/images/cook-img.png'},
    {"name": "Cable\nPayment", "image": 'assets/images/cable-payment-img.png'},
    {"name": "Plumber", "image": 'assets/images/plumber-img.png'},
    {"name": "Electrician", "image": 'assets/images/electrician-img.png'},
    {"name": "Fire Service", "image": 'assets/images/fire-service-img.png'}
  ];

  final CategoryFactory _factory = new CategoryFactory();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GateManHelpers.appBar(context, "Service Directory"),
      body: Container(
        child: isLoading
            ? Loader.show()
            : GridView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ServiceDirectoryResidentGridTile(
                    directoryName: _categories[index].title,
                    directoryImg: _factory.getFactory(_categories[index].title.toLowerCase()),
                    isOdd: index < 1 ? true : index % 2 == 0,
                    category: _categories[index],
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: _categories.length,
              ),
      ),
    );
  }
}

enum ServiceCategories{
  Cook,Carpenter,Cable,Plumber,Fire_Service,Electrician
}

class CategoryFactory{
  String getFactory(String category){
    if('cable payment' == category){
      return 'assets/images/cable-payment-img.png';
    }else if ('carpenter' == category){
      return 'assets/images/carpentar-img.png';
    }else if('cook' == category){
      return 'assets/images/cook-img.png';
    }else if('electrician' == category){
      return 'assets/images/electrician-img.png';
    }else if('fire service' == category){
      return 'assets/images/fire-service-img.png';
    }
    else if('doctor' == category || 'nurse' == category || 'clinic' == category){
      return 'assets/images/clinic-img.png';
    }
    else {
      return 'assets/images/plumber-img.png';
    }//else return null;
  }
}
