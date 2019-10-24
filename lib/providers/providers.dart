import 'package:gateapp/core/models/estate_list.dart';
import 'package:gateapp/providers/faq_provider.dart';
import 'package:gateapp/providers/profile_provider.dart';
import 'package:gateapp/providers/resident_gateman_provider.dart';
import 'package:gateapp/providers/token_provider.dart';
import 'package:gateapp/providers/user_provider.dart';
import 'package:gateapp/providers/visitor_provider.dart';
import 'package:provider/provider.dart';
import 'package:gateapp/providers/resident_user_provider.dart';
import 'package:gateapp/providers/gateman_user_provider.dart';

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
  ChangeNotifierProvider.value(value: FAQProvider()),
  ChangeNotifierProvider.value(value: ResidentUserProvider()),
  ChangeNotifierProvider.value(value: GatemanUserProvider()),
  ChangeNotifierProvider.value(value: ProfileProvider()),
  ChangeNotifierProvider.value(value: VisitorProvider()),
  ChangeNotifierProvider.value(value: ResidentsGateManProvider(),)
];

List<SingleChildCloneableWidget> dependentServices = [];

List<SingleChildCloneableWidget> providersForInterface = [];
