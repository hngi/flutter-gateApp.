import 'package:flutter/material.dart';
import 'package:xgateapp/pages/estate_payment/widgets/pay_bills_card.dart';

class PayBillsGrid extends StatelessWidget {
  final List<String> _bills1 = [
    'Electricity',
    'Water',
    'Internet',
    'Cable',
    'Waste',
    'Apartment'
  ];

  final List<Map<String, dynamic>> _bills = [
    {'billName': 'Electricity', 'image': 'assets/images/electricity.png'},
    {'billName': 'Water', 'image': 'assets/images/water.png'},
    {'billName': 'Internet', 'image': 'assets/images/internet.png'},
    {'billName': 'Cable', 'image': 'assets/images/cable.png'},
    {'billName': 'Waste', 'image': 'assets/images/waste.png'},
    {'billName': 'Apartment', 'image': 'assets/images/apartment.png'},
  ];

  //'assets/images/clinic-img.png'

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        // childAspectRatio: 1.2,
        childAspectRatio: 1.1,
        children: _bills.map((bill) {
          return PayBillsCard(
            img: bill['image'],
            billName: bill['billName'],
            isOdd: true,
          );
        }).toList(),
      ),
    );
  }
}
