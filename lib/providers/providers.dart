import 'package:xgateapp/core/models/estate_list.dart';
import 'package:xgateapp/providers/profile_provider.dart';
import 'package:xgateapp/providers/requestProvider.dart';
import 'package:xgateapp/providers/resident_gateman_provider.dart';
import 'package:xgateapp/providers/token_provider.dart';
import 'package:xgateapp/providers/user_provider.dart';
import 'package:xgateapp/providers/visitor_provider.dart';
import 'package:provider/provider.dart';
import 'package:xgateapp/providers/resident_user_provider.dart';
import 'package:xgateapp/providers/gateman_user_provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...providersForInterface
];

List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider.value(
      value: TokenProvider()), //for persisting Authentication Token
  ChangeNotifierProvider.value(value: AllEstateModel()),
  ChangeNotifierProvider.value(value: UserTypeProvider()),
  ChangeNotifierProvider.value(value: ResidentUserProvider()),
  ChangeNotifierProvider.value(value: GatemanUserProvider()),
  ChangeNotifierProvider.value(value: ProfileProvider()),
  ChangeNotifierProvider.value(value: VisitorProvider()),
  ChangeNotifierProvider.value(value: ResidentsGateManProvider()),
  ChangeNotifierProvider.value(value: RequestProvider())
];

List<SingleChildCloneableWidget> dependentServices = [];

List<SingleChildCloneableWidget> providersForInterface = [];
