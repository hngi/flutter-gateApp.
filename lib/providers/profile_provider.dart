import 'package:flutter/cupertino.dart';
import 'package:gateapp/core/models/estate.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();
  bool initialProfileLoaded = false;

  void setProfileModel(ProfileModel model){
    print('printing model from provider');
    // print(model.toString());
    this.profileModel = model;
    notifyListeners();
  }

  void setInitialStatus(bool status){
    initialProfileLoaded = status;
    notifyListeners();
  }
}

class ProfileModel {
  HomeModel homeModel;
  String name, username, email, phone, image, created_at, updated_at;
  int id;
  ProfileModel(
      {this.id,
      this.name,
      this.username,
      this.phone,
      this.email,
      this.image,
      this.homeModel,
      this.created_at,
      this.updated_at});

  factory ProfileModel.fromJson(dynamic jsonModel) {
    
    return ProfileModel(
        id: jsonModel['id'],
        name: jsonModel['name'],
        username: jsonModel['username'],
        email: jsonModel['email'],
        phone: jsonModel['phone'],
        image: jsonModel['image'],
        created_at: jsonModel['created_at'],
        updated_at: jsonModel['updated_at'],
        homeModel: HomeModel.fromJson(jsonModel['home'])
        );
  }

  @override
  String toString(){
    return this.id.toString() + this.name;
    
  }

  

  updateFromMapOrJson(dynamic map) {
    this.id = !map.containsKey('id') ? this.id : map['id'];
    this.name =
        !map.containsKey('first_name') ? this.name : map['first_name'];
    this.username =
        !map.containsKey('last-name') ? this.username : map['last_name'];
    this.email = !map.containsKey('email') ? this.email : map['email'];
    this.phone = !map.containsKey('phone') ? this.phone : map['phone'];
    this.image = !map.containsKey('image') ? this.image : map['image'];
    this.created_at =
        !map.containsKey('created_at') ? this.created_at : map['created_at'];
    this.updated_at =
        !map.containsKey('updated_at') ? this.updated_at : map['updated_at'];
  }
}
