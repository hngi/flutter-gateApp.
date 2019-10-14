import 'package:flutter/material.dart';
import 'package:gateapp/providers/token_provider.dart';
import 'package:provider/provider.dart';

const CONNECT_TIMEOUT = 30000;
const RECEIVE_TIMEOUT = 30000;

String authToken(BuildContext context) {
  return Provider.of<TokenProvider>(context).authToken;
}

//UserType enum
enum UserType { ADMIN, GATEMAN, RESIDENT }
