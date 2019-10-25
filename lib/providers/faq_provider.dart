import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FAQProvider extends ChangeNotifier{
  List<FAQModel> faqModel = [];
  bool initialFAQLoaded = false;

  void setFAQModels(List<FAQModel> models) {
    this.faqModel.addAll(models);
    this.initialFAQLoaded = true;
    notifyListeners();
  }

  void setInitialStatus(bool status){
    initialFAQLoaded = status;
    notifyListeners();
  }

}

class FAQModel {
  int id;
  String title, content, created_at, updated_at;

  FAQModel({this.id, this.title, this.content, this.created_at, this.updated_at});

  factory FAQModel.fromJson(dynamic jsonModel) {
    return FAQModel(
      id: jsonModel['id'],
      title: jsonModel['title'],
      content: jsonModel['content'],
      created_at: jsonModel['created_at'],
      updated_at: jsonModel['updated_at']
    );
  }
}