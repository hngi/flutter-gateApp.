import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:rave_flutter/src/ui/fields/card_number_field.dart';
import 'package:xgateapp/core/service/payment_service.dart';
import 'package:xgateapp/pages/estate_payment/card_pin.dart';
import 'package:xgateapp/pages/estate_payment/widgets/rave_logo.dart';
import 'package:xgateapp/utils/FlushAlert/flush_alert.dart';
import 'package:xgateapp/utils/LoadingDialog/loading_dialog.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/constants.dart';
import 'package:xgateapp/utils/errors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:rave_flutter/src/ui/common/card_utils.dart';

class PaymentMethod extends StatefulWidget {
  String billId;
  int amount;

  PaymentMethod({@required this.billId, @required amount});

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

enum PaymentOptionSelect { none, card, account }

class _PaymentMethodState extends State<PaymentMethod>
    with TickerProviderStateMixin {
  String _cardNumber;
  String _cvvNumber;
  String _expiry;
  StreamController<String> _cardNumberController;
  PaymentOptionSelect selected = PaymentOptionSelect.none;
  GlobalKey<FormState> _cardPaymentFormKey = GlobalKey<FormState>();

  String _country = 'NG', _currency = 'NGN';

  String _bank;

  _onPay() async {
    var form = _cardPaymentFormKey.currentState;
    if (form.validate()) {
      form.save();

      LoadingDialog dialog = LoadingDialog(context, LoadingDialogType.Normal);
      dialog.show();

      var res = await PaymentService.payBillWithCard(
        authToken: await authToken(context),
        amount: widget.amount,
        billId: widget.billId,
        cardNo: _cardNumber.replaceAll(' ', ''),
        country: _country,
        currency: _currency,
        cvv: _cvvNumber,
        email: getProfileProvider(context).profileModel.email,
        expirymonth: _expiry.split('/')[0],
        expiryyear: _expiry.split('/')[1],
      );

      dialog.hide();

      if (res is ErrorType) {
        FlushAlert.show(
          context: context,
          message: GateManHelpers.errorTypeMap(res),
          isError: true,
        );
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return new CardPin(
            amount: widget.amount,
            cardNo: _cardNumber,
            country: _country,
            currency: _currency,
            cvv: _cvvNumber,
            email: getProfileProvider(context).profileModel.email,
            expiryMonth: _expiry.split('/')[0],
            expiryYear: _expiry.split('/')[1],
          );
        }));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cardNumberController = StreamController<String>.broadcast();
    FlutterStatusbarManager.setColor(GateManColors.primaryColor,
        animated: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlutterStatusbarManager.setColor(Colors.transparent, animated: true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              selected == PaymentOptionSelect.none
                  ? Expanded(
                      child: Container(
                          height: MediaQuery.of(context).size.height -
                              (100 + MediaQuery.of(context).padding.top),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, top: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.lock,
                                      size: 13,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text('SECURED FLUTTERWAVE',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(24.0),
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('How would you like to pay?',
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 5,
                                        color: GateManColors.primaryColor,
                                      ),
                                    ],
                                  )),
                                ),
                              )
                            ],
                          )),
                    )
                  : SizedBox(
                      width: 0,
                      height: 0,
                    ),
              AnimatedSize(
                vsync: this,
                child: Container(
                  height: selected != PaymentOptionSelect.card
                      ? null
                      : MediaQuery.of(context).size.height -
                          (50 +
                              MediaQuery.of(context).padding.top +
                              MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: <Widget>[
                      payWithTile(
                          title: 'Pay With Card',
                          isCollapsed: !(selected == PaymentOptionSelect.card),
                          onTapped: () {
                            setState(() {
                              selected = selected == PaymentOptionSelect.card
                                  ? PaymentOptionSelect.none
                                  : PaymentOptionSelect.card;
                            });
                          }),
                      selected == PaymentOptionSelect.card
                          ? Expanded(
                              child: Form(
                                key: _cardPaymentFormKey,
                                child: ListView(
                                  padding: EdgeInsets.only(top: 20),
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, right: 16.0),
                                      child: CustomTextFormField(
                                        labelName: 'Card Number',
                                        onChanged: (String nS) {
                                          _cardNumberController.sink.add(nS);
                                          _cardNumber = nS;
                                        },
                                        onSaved: (String numb) {
                                          setState(() {
                                            _cardNumber = numb;
                                          });
                                        },
                                        validator: (String numb) {
                                          if (numb.length > 22) {
                                            return "Card number should be 16 digits";
                                          }
                                          return null;
                                        },
                                        autovalidate: true,
                                        inputFormatters: [
                                          CardNumberInputFormatterGateApp(),
                                          LengthLimitingTextInputFormatter(22),
                                        ],
                                        keyboardType: TextInputType.number,
                                        suffixIcon: StreamBuilder<String>(
                                            stream:
                                                _cardNumberController.stream,
                                            builder: (context, snapshot) {
                                              getCardImage(
                                                  CardUtils.getTypeForIIN(
                                                      snapshot.data));
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  snapshot == null ||
                                                          snapshot.data ==
                                                              null ||
                                                          snapshot.data
                                                                  .length ==
                                                              0
                                                      ? 'assets/images/card-unknown.png'
                                                      : getCardImage(CardUtils
                                                          .getTypeForIIN(
                                                              snapshot.data)),
                                                  scale: 4,
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: CustomTextFormField(
                                              labelName: 'Valid till MM/YY',
                                              onChanged: (String numb) {
                                                setState(() {
                                                  _expiry = numb;
                                                });
                                              },
                                              onSaved: (String numb) {
                                                setState(() {
                                                  _expiry = numb;
                                                });
                                              },
                                              validator: (String str) => null,
                                              inputFormatters: [
                                                CardMonthInputFormatterGateApp(),
                                                LengthLimitingTextInputFormatter(
                                                    5)
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            child: CustomTextFormField(
                                              labelName: 'CVV/CVV2',
                                              onChanged: (String numb) {
                                                setState(() {
                                                  _cvvNumber = numb;
                                                });
                                              },
                                              onSaved: (String numb) {
                                                setState(() {
                                                  _cvvNumber = numb;
                                                });
                                              },
                                              validator: (String str) => null,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    3)
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('Save Card'),
                                          Switch(
                                            onChanged: (bool value) {},
                                            value: false,
                                          ),
                                        ],
                                      ),
                                    ),

                                    ActionButton(
                                      buttonText: 'Pay',
                                      onPressed: _onPay,
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(16.0),
                                    //   child: GestureDetector(
                                    //     onTap: () async {
                                    //       LoadingDialog dialog = LoadingDialog(
                                    //           context, LoadingDialogType.Normal);
                                    //       dialog.show();
                                    //       await payWithCard();
                                    //       Navigator.pop(context);
                                    //     },
                                    //     child: Container(
                                    //         decoration: BoxDecoration(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(5),
                                    //             color: GateManColors
                                    //                 .primarySwatchColor),
                                    //         height: 50,
                                    //         child: Center(
                                    //             child: Text('Pay',
                                    //                 textAlign: TextAlign.center,
                                    //                 style: TextStyle(
                                    //                     fontSize: 10,
                                    //                     color: Colors.white)))),
                                    //   ),
                                    // ),
                                    raveLogo
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              width: 0,
                              height: 0,
                            ),
                    ],
                  ),
                ),
                duration: Duration(milliseconds: 300),
              ),
              AnimatedSize(
                child: Container(
                    height: selected != PaymentOptionSelect.account
                        ? null
                        : MediaQuery.of(context).size.height -
                            (50 +
                                MediaQuery.of(context).padding.top +
                                MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: <Widget>[
                        payWithTile(
                            title: 'Pay from Account',
                            isCollapsed:
                                !(selected == PaymentOptionSelect.account),
                            onTapped: () {
                              setState(() {
                                selected =
                                    selected == PaymentOptionSelect.account
                                        ? PaymentOptionSelect.none
                                        : PaymentOptionSelect.account;
                              });
                            }),
                        selected == PaymentOptionSelect.account
                            ? Expanded(
                                child: ListView(
                                  padding: EdgeInsets.only(top: 20),
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, right: 16.0),
                                      child: CustomTextFormField(
                                        onSaved: (String s) {},
                                        validator: (String s) => null,
                                        labelName: 'Phone Number',
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, right: 16.0),
                                      child: CustomTextFormField(
                                        onSaved: (String s) {},
                                        validator: (String s) => null,
                                        labelName: 'Account Number',
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 16.0,
                                          top: 10.0,
                                          right: 16.0,
                                          bottom: 8),
                                      child: Text('Bank'),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 16, right: 16),
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        width: 80,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    GateManColors.primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            hint: Text(
                                              'Select Your Bank',
                                            ),
                                            iconEnabledColor:
                                                GateManColors.primaryColor,
                                            items: <String>[
                                              'GTB',
                                              'ACCESS',
                                              'FIRSTBANK'
                                            ].map<DropdownMenuItem<String>>(
                                                (String str) {
                                              return DropdownMenuItem<String>(
                                                  value: str,
                                                  child: Text(
                                                    str,
                                                    style: TextStyle(
                                                        color: GateManColors
                                                            .blackColor),
                                                  ));
                                            }).toList(),
                                            value: _bank,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                _bank = newValue;
                                              });
                                            },
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 24.0,
                                          left: 16,
                                          bottom: 16,
                                          right: 16),
                                      child: GestureDetector(
                                        onTap: () {
                                          print('tapped');
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: GateManColors
                                                    .primarySwatchColor),
                                            height: 50,
                                            child: Center(
                                                child: Text('Pay',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white)))),
                                      ),
                                    ),
                                    raveLogo
                                  ],
                                ),
                              )
                            : Container(
                                width: 0,
                                height: 0,
                              )
                      ],
                    )),
                duration: Duration(milliseconds: 300),
                vsync: this,
              )
            ],
          ),
        ),
      ),
    );
  }

  String getCardImage(CardType typeForIIN) {
    switch (typeForIIN) {
      case CardType.visa:
        return 'assets/images/card-visa.png';
      case CardType.master:
        return 'assets/images/card-mastercard.png';

      case CardType.verve:
        return 'assets/images/card-verve.png';
      case CardType.unknown:
        return 'assets/images/card-unknown.png';

        break;
      default:
        return 'assets/images/card-unknown.png';
    }
  }

  // payWithCard() async {
  //   dynamic response = await PaymentService.payBillWithCard(
  //       amount: "1000",
  //       authToken: await authToken(context),
  //       billId: "3",
  //       cardNo: _cardNumber.replaceAll(' ', ''),
  //       country: 'NG',
  //       currency: 'NGN',
  //       cvv: _cvvNumber,
  //       email: getProfileProvider(context).profileModel.email,
  //       expirymonth: _expiry.split('/')[0],
  //       expiryyear: _expiry.split('/')[1]);
  //   print(response);
  // }
}

class CardNumberInputFormatterGateApp extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < 4 ||
        oldValue.text.length > newValue.text.length) {
      return newValue;
    }
    String acting = newValue.text.replaceAll('  ', '');
    String newS = '';
    int count = 0;
    for (int i = 0; i < acting.length; i++) {
      count += 1;
      newS = newS + acting[i];
      if (count == 4) {
        newS = newS + '  ';
        count = 0;
      }
    }
    return newValue.copyWith(
        text: newS, selection: TextSelection.collapsed(offset: newS.length));
  }
}

class CardMonthInputFormatterGateApp extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length > newValue.text.length) {
      return newValue;
    }

    if (newValue.text.length < 2 ||
        oldValue.text.length > newValue.text.length) {
      return newValue;
    }

    if (newValue.text.length == 1 &&
        (newValue.text != '0' || newValue.text != '1')) {
      newValue = newValue.copyWith(
          text: '0' + newValue.text,
          selection: TextSelection.collapsed(offset: 2));
    }

    String acting = newValue.text.replaceAll('/', '');
    String newS = '';
    int count = 0;
    for (int i = 0; i < acting.length; i++) {
      count += 1;
      newS = newS + acting[i];
      if (count == 2) {
        newS = newS + '/';
        count = 0;
      }
    }
    return newValue.copyWith(
        text: newS, selection: TextSelection.collapsed(offset: newS.length));
  }
}

Widget payWithTile({bool isCollapsed = true, String title, Function onTapped}) {
  return Column(
    children: <Widget>[
      Container(
        height: 0.5,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: onTapped ?? () {},
        child: Container(
          height: 49,
          color: GateManColors.primaryColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('$title',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
              ),
              Icon(
                isCollapsed
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
