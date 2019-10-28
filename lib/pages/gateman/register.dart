import 'package:flutter/material.dart';
import 'package:xgateapp/pages/gateman/welcome.dart';
import 'package:xgateapp/providers/gateman_user_provider.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:provider/provider.dart';

class GatemanRegister extends StatefulWidget {
  @override
  _GatemanRegisterState createState() => _GatemanRegisterState();
}

class _GatemanRegisterState extends State<GatemanRegister> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _fnameController = new TextEditingController();
  String _fullname;
  

  @override
  Widget build(BuildContext context) {
    GatemanUserProvider gateManProvider =
        Provider.of<GatemanUserProvider>(context, listen: false);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 70.0, left: 20.0),
              child: Text('Register',
                  style: TextStyle(
                      fontSize: 42.0, color: GateManColors.primaryColor))),
          Padding(
              padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: Text(
                  'Welcome to a peaceful and safe way to manage your visitors',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey))),
          Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Full name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.7,
                            color: Colors.black54),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7.0, bottom: 20.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14.0),
                              focusedBorder: GateManHelpers.textFieldBorder,
                              enabledBorder: GateManHelpers.textFieldBorder,
                              border: GateManHelpers.textFieldBorder,
                            ),
                            controller: _fnameController,
                            validator: (value) {
                              return value.isEmpty
                                  ? 'Full name is required'
                                  : null;
                            }),
                      ),
                    ],
                  ),
                  ActionButton(
                    buttonText: 'Join',
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        gateManProvider.gatemanUser.fullName = _fnameController.text;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => new GatemanWelcome(
                                  fullname: _fnameController.text,
                                )));
                      } else {
                        print('form not valid');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
