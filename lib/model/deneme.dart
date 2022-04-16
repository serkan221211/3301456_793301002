class satis_1 {
  String? id;
  String? company;

  satis_1({this.id, this.company});

  satis_1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company'] = this.company;
    return data;
  }
}