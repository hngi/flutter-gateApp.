import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xgateapp/pages/estate_payment/widgets/bill_to_pay_card.dart';
import 'package:xgateapp/pages/estate_payment/widgets/pay_bills_grid.dart';

class EstatePayments extends StatefulWidget {
  @override
  _EstatePaymentsState createState() => _EstatePaymentsState();
}

class _EstatePaymentsState extends State<EstatePayments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payments', style: TextStyle(fontSize: 19.0)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 14.0),
        child: CustomScrollView(
          // padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 14.0),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                child: Text(
                  'Bills to Pay',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BillsToPayCard(
                billType: 'Security Contribution',
                amount: '6,000',
              ),
            ),
            SliverToBoxAdapter(
              child: BillsToPayCard(
                billType: 'Facility Maintenance',
                amount: '4,000',
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10.0)),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                child: Text(
                  'Pay Bills',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            PayBillsGrid(),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                child: Text(
                  'Payment History',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ListTile(
                leading:
                    Icon(MdiIcons.cash, color: Color(0xFF49A347), size: 24.0),
                trailing: Text(
                  '11/11',
                  style: TextStyle(
                    color: Color(0xFF878787),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                title: Text(
                  'Electricity',
                  style: TextStyle(
                    color: Color(0xFF878787),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'N4,000',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
