class FAQ{
  int id;
  String title, content, created_at, updated_at;

  FAQ({this.id, this.title, this.content, this.created_at, this.updated_at});

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        created_at: json['created_at'],
        updated_at: json['updated_at']
    );
  }

}