import 'package:flutter/material.dart';
import 'package:gateapp/pages/add_gateman.dart';
import 'package:gateapp/pages/add_visitor.dart';
import 'package:gateapp/pages/edit_info.dart';
import 'package:gateapp/pages/edit_profile.dart';
import 'package:gateapp/pages/homepage.dart';
import 'package:gateapp/pages/manage_address.dart';
import 'package:gateapp/pages/manage_gateman.dart';
import 'package:gateapp/pages/register.dart';
import 'package:gateapp/pages/welcome_resident.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/routes/routes.dart';

import 'pages/SplashScreen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:gateapp/providers/providers.dart';

void main() => runApp(GateMan());

class GateMan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));

    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'GateMan App',
        // initialRoute: '/register',
        // onGenerateRoute: Routes.generateRoute,
        theme: ThemeData(
          primarySwatch: GateManColors.primarySwatchColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: GateManColors.textColor,
                displayColor: GateManColors.textColor,
              ),
          fontFamily: 'OpenSans',
        ),
        home: AddVisitor(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
