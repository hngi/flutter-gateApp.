import 'package:flutter/material.dart';
import 'package:xgateapp/utils/GateManAlert/gateman_alert.dart';
import 'package:xgateapp/widgets/ActionButton/action_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_intent/android_intent.dart';
import 'package:location_permissions/location_permissions.dart';
// import 'package:geocoder/geocoder.dart';
class AddLocationPermission extends StatefulWidget {
  //static final String routeName = '/add_location_permisiion';

AddLocationPermission();
  @override
  _AddLocationPermissionState createState() => _AddLocationPermissionState();
}


class _AddLocationPermissionState extends State<AddLocationPermission> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: Colors.white,
    body: Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top:25.0),
            child: Container(
              height: size.height * 0.4,
              width: double.infinity,
              child: Image.asset('assets/images/addLocationBg.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top:40.0, right: 20.0, left: 20.0, bottom: 20.0),
            width: double.infinity,

            child: Column(

              children: <Widget>[
                Text(
                  'Location permission required',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Your location permission will be required for easy accessibility ',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
//                    fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),


          Container(
            padding: EdgeInsets.only(left:10.0, right: 10.0, bottom: 25.0, top: 10.0),
              child: ActionButton(
                buttonText: 'Ok, turn on permission',
                onPressed: () async{
                  try{

                 
                      final PermissionStatus permission = await _getLocationPermission(request: false

                      );
                      if(permission != PermissionStatus.granted){
                        await PaysmosmoAlert.showWarning(context: context,message: 'Location Permission Denied');
                      }
                      else{
                        print('elsing');
                        ServiceStatus locationServiceStatus= await LocationPermissions().checkServiceStatus();
                        if (locationServiceStatus != ServiceStatus.enabled){
                          await PaysmosmoAlert.showWarning(context: context,message: 'Please turn on location in settings');
                         final AndroidIntent intent = new AndroidIntent(
                      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
                      );
                      await intent.launch();
                      if (await LocationPermissions().checkServiceStatus()== ServiceStatus.enabled){
                        Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        if(position != null){
                        //   print(position);
                        // List<Placemark> placemark = await Geolocator().placemarkFromPosition(position);
                        // print(placemark.first);

                        return Navigator.pushReplacementNamed(
                    context, '/user-type');
                      }else{
                        await PaysmosmoAlert.showWarning(context: context,message: 'Location Inaccessible');
                          
                      }
                        
                      } else {
                         await PaysmosmoAlert.showWarning(context: context,message: 'Please turn on Location');
                         

                      }
                        } else{
                          Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        
                        if(position != null){
                          print(position);
                        //  List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude,position.longitude);
                        // print(placemark.first);
                        return Navigator.pushReplacementNamed(
                    context, '/user-type');
                      }else{
                        await PaysmosmoAlert.showWarning(context: context,message: 'Location Inaccessible');
                        return Navigator.pushReplacementNamed(
                    context, '/user-type');
                          
                      }
                        }
                        } } catch(error){
                          print(error);
                        }
                         },
              )
          ),
        ],
      ),
    ),
  );

  }
  Future<PermissionStatus> _getLocationPermission({@required bool request}) async {
    PermissionStatus permission;
    if (request == true){
      permission =await LocationPermissions().requestPermissions();
    } else {
      print('just checking');
      permission =await LocationPermissions().checkPermissionStatus();
    }
    
    if (permission != PermissionStatus.granted) {
      final PermissionStatus permissionStatus = await LocationPermissions()
          .requestPermissions();

      return permissionStatus;
    } else {
      return permission;
    }
  }
}
