class deneme_1 {
  String? id;
  String? companyName;

  deneme_1(
      {this.id,
        this.companyName,
        });

  deneme_1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    return data;
  }
}