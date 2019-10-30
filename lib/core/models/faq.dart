
class Faq {
  bool status;
  String message;
  List<Faqs> faqs;

  Faq({this.status, this.message, this.faqs});

  Faq.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['faqs'] != null) {
      faqs = new List<Faqs>();
      json['faqs'].forEach((v) {
        faqs.add(new Faqs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.faqs != null) {
      data['faqs'] = this.faqs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faqs {
  int id;
  String title;
  String content;
  String createdAt;
  Null updatedAt;

  Faqs({this.id, this.title, this.content, this.createdAt, this.updatedAt});

  Faqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
