import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xgateapp/core/models/bill.dart';
import 'package:xgateapp/core/models/service_provider.dart';
import 'package:xgateapp/core/service/bill_service.dart';
import 'package:xgateapp/pages/estate_payment/widgets/bill_to_pay_card.dart';
import 'package:xgateapp/pages/estate_payment/widgets/pay_bills_grid.dart';
import 'package:xgateapp/pages/estate_payment/payment_method.dart';
import 'package:xgateapp/utils/Loader/loader.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/helpers.dart';

class EstatePayments extends StatefulWidget {
  @override
  _EstatePaymentsState createState() => _EstatePaymentsState();
}

class _EstatePaymentsState extends State<EstatePayments> {
  List<Bill> _pendingBills = [];
  List<Bill> _paidBills = [];
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
      //get pending bills
      BillService.getAllBills(authToken: await authToken(context)),
      // //get subscribed bills
      //   BillService.getResidentBill(
      //     authToken: await authToken(context)),

      //get paid bills
      BillService.getAllPaidBills(authToken: await authToken(context))
    ]).then((res) {
      print(res);
      setState(() {
        isLoading = false;
        _pendingBills = res[0];
        _paidBills = res[0];
      });
    });
  }

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
              child: _pendingBills.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 8.0),
                      child: Text(
                        'Bills to Pay',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SizedBox(),
            ),

            //sliver list
            _pendingBills.length > 0
                ? SliverList(
                    delegate: SliverChildListDelegate(_pendingBills
                        .map((bill) => BillsToPayCard(
                              billType: bill.billInfo.item,
                              amount: bill.billInfo.baseAmount,
                              billDate: bill.createdAt,
                              billId: bill.estateBillsId,
                              billNo: bill.id,
                              dueDate: '25 Oct, 2019',
                            ))
                        .toList()),
                  )
                : SliverToBoxAdapter(child: SizedBox()),

            SliverToBoxAdapter(child: RaisedButton(onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute<Null>(builder: (BuildContext context) {
                return new PaymentMethod(
                  billId: '1',
                  amount: '4000',
                );
              }));
            })),

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

            //sliver list
            _paidBills.length > 0
                ? SliverList(
                    delegate: SliverChildListDelegate(_paidBills
                        .map((bill) => SliverToBoxAdapter(
                              child: ListTile(
                                leading: Icon(MdiIcons.cash,
                                    color: Color(0xFF49A347), size: 30.0),
                                trailing: Text(
                                  bill.createdAt,
                                  style: TextStyle(
                                    color: Color(0xFF878787),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                title: Text(
                                  bill.billInfo.item,
                                  style: TextStyle(
                                    color: Color(0xFF878787),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'N ${bill.amount}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ))
                        .toList()),
                  )
                : SliverToBoxAdapter(
                    child: Center(child: Text('No Payment History'))),

            // SliverToBoxAdapter(
            //   child: ListTile(
            //     leading:
            //         Icon(MdiIcons.cash, color: Color(0xFF49A347), size: 30.0),
            //     trailing: Text(
            //       '11/11',
            //       style: TextStyle(
            //         color: Color(0xFF878787),
            //         fontSize: 14.0,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     title: Text(
            //       'Electricity',
            //       style: TextStyle(
            //         color: Color(0xFF878787),
            //         fontSize: 14.0,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     subtitle: Text(
            //       'N4,000',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 28.0,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
