import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/widgets/CustomTextFormField/custom_textform_field.dart';
import 'package:xgateapp/widgets/DashedRectangle/dashed_rectangle.dart';

class ProofOfPayment extends StatefulWidget {
  @override
  _ProofOfPaymentState createState() => _ProofOfPaymentState();
}

class _ProofOfPaymentState extends State<ProofOfPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Proof of Payment', style: TextStyle(fontSize: 19.0)),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 14.0),
        children: <Widget>[
          SizedBox(height: 12.0),
          CustomTextFormField(
            labelName: '',
            hintText: 'Name',
            onSaved: (str) {},
            validator: (str) => null,
            // prefixIcon: Icon(MdiIcons.account),
          ),

          CustomTextFormField(
            labelName: '',
            hintText: 'Receipt / Teller Number',
            onSaved: (str) {},
            validator: (str) => null,
            // prefixIcon: Icon(MdiIcons.account),
          ),

          //Upload Proof
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 16),
            child: Text(
              'Upload Proof of Payment',
              style: TextStyle(
                  color: GateManColors.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: 125,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                // getImage((img){
                //   setState(() {
                //    image = img;
                //   });

                // },ImageSource.gallery);
              },
              child: DashedRectangle(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/ei-image.png'),
                    Visibility(
                      visible: true,
                      child: Text(
                        'Upload Receipt / Teller',
                        style: TextStyle(
                            color: Color(0xFF878787),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 13.0),
          ActionButton(
            buttonText: 'Submit',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
