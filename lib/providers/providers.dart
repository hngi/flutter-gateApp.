import 'package:gateapp/providers/user_provider.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...providersForInterface
];

List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider.value(value: UserProvider()),
];

List<SingleChildCloneableWidget> dependentServices = [];

List<SingleChildCloneableWidget> providersForInterface = [];
