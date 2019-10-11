import 'package:gateapp/core/models/estate_list.dart';
import 'package:gateapp/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:gateapp/providers/resident_user_provider.dart';
List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...providersForInterface
];

List<SingleChildCloneableWidget> independentServices = [
  //ChangeNotifierProvider.value(value: UserProvider()),
  ChangeNotifierProvider.value(value: AllEstateModel()),
  ChangeNotifierProvider.value(value: UserTypeProvider()),
  ChangeNotifierProvider.value(value: ResidentUserProvider()),
  
  
];

List<SingleChildCloneableWidget> dependentServices = [];

List<SingleChildCloneableWidget> providersForInterface = [];
