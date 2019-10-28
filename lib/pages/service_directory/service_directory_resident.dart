import 'package:flutter/material.dart';
import 'package:xgateapp/core/models/service_provider.dart';
import 'package:xgateapp/core/service/service_provider_service.dart';
import 'package:xgateapp/pages/service_directory/widgets/service-directory_grid_tile.dart';
import 'package:xgateapp/utils/Loader/loader.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/helpers.dart';

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
        isLoading = false;
        _categories = res[0];
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
          "openingHour": "Always open, 24 Hrs Service",
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
                    directoryImg: 'assets/images/cook-img.png',
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
