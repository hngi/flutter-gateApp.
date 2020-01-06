import 'package:flutter/material.dart';
import 'package:xgateapp/pages/estate_payment/payment_methods.dart';
import 'package:xgateapp/pages/estate_payment/proof_of_payment.dart';

class BillsToPayCard extends StatelessWidget {
  final String billType;
  final String amount;

  const BillsToPayCard(
      {Key key, @required this.billType, @required this.amount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(73, 163, 71, 0.05),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  'Bill No: 190100',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF878787),
                  ),
                ),
                Text(
                  'Bill Date: 25 Oct 2019',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF878787),
                  ),
                ),
              ],
            ),
          ),

          //Security Contribution
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 13.0, vertical: 3.0),
            child: Text(
              this.billType,
              style: TextStyle(
                color: Color(0xFF878787),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Amount
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 13.0, vertical: 5.0),
            child: Text(
              'N' + this.amount,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Due Date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
            child: Text(
              'Due Date: 5 Nov 2019',
              style: TextStyle(
                color: Color(0xFF49A347),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new ProofOfPayment();
                    }));
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    alignment: Alignment.center,
                    child: Text('Already Paid',
                        style: TextStyle(
                          color: Color(0xFF49A347),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        )),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF49A347),
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                InkWell(
                  
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                      return new PaymentMethods();
                    }));
                  },
                                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    alignment: Alignment.center,
                    child: Text('Pay Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        )),
                    decoration: BoxDecoration(
                        color: Color(0xFF49A347),
                        // border: Border.all(
                        //   color: Color(0xFF49A347),
                        //   style: BorderStyle.solid,
                        //   width: 1.0,
                        // ),
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
