import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xgateapp/core/models/faq.dart';

class FaqBloc extends ChangeNotifier {
  List<Faq> _faq;
  List<Faq> get listFaq => _faq;

  set listFaq(List<Faq> val) {
    _faq = val;
    notifyListeners();
  }

  Future<List<Faq>> fetchFaq() async {
    final response = await http.get("http://gateappapi.herokuapp.com/api/v1/faq");
    Map<String, dynamic> res = jsonDecode(response.body);
    List<Faq> data = [];

    for(var i=0; i<res.length; i++){
      var faq = Faq.fromJson(res[i]);
      data.add(faq);
    }
    listFaq = data;
    return listFaq;
  }
}
