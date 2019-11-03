import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:xgateapp/core/models/estate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();
  bool initialProfileLoaded = false;
  bool loadedFromApi = false;
  bool loadedFromPrefs = false;
  bool loading = false;

  void setLoadingState(bool stat){
    loading = stat;
    notifyListeners();
  }

void setLoadedFromApi(bool loaded){
  loadedFromApi = loaded;
  notifyListeners();
}

void setProfileModel(ProfileModel model,{String jsonString, bool clean})async {
    print('printing model from provider');
    // print(model.toString());
    if(jsonString != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile', jsonString);
    }
    if (clean!=null && clean == true){
       loadedFromApi =false;
    } else {
      loadedFromApi =true;
    }
    this.profileModel = model;

   
    notifyListeners();
  }

  void setProfileModelFromPrefs() async {
    if (profileModel.name != null){
      return;
     
    } else {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('profile')== null){
      return;
    }
    String profileString = prefs.getString('profile');
      print('profilellllllllllllll');
      print(profileString);
    this.profileModel = ProfileModel.fromJson(json.decode(profileString));
    loadedFromPrefs = true;
    notifyListeners();
    }
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
        id: jsonModel["id"],
        name: jsonModel['name'],
        username: jsonModel['username'],
        email: jsonModel['email'],
        phone: jsonModel['phone'],
        image: jsonModel['image'],
        created_at: jsonModel['created_at'],
        updated_at: jsonModel['updated_at'],
        homeModel: jsonModel.containsKey('home') && jsonModel['home']!=null?HomeModel.fromJson(jsonModel['home']):null
        );
  }

  @override
  String toString(){
    return this.id.toString() + this.name;
    
  }

  

  updateFromMapOrJson(dynamic map) {
    this.id = !map.containsKey('id') ? this.id : map['id'];
    this.name =
        !map.containsKey('name') ? this.name : map['name'];
    this.username =
        !map.containsKey('username') ? this.username : map['username'];
    this.email = !map.containsKey('email') ? this.email : map['email'];
    this.phone = !map.containsKey('phone') ? this.phone : map['phone'];
    this.image = !map.containsKey('image') ? this.image : map['image'];
    this.created_at =
        !map.containsKey('created_at') ? this.created_at : map['created_at'];
    this.updated_at =
        !map.containsKey('updated_at') ? this.updated_at : map['updated_at'];
  }
}
