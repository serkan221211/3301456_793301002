class musteri_bil {
  String? id;
  String? companyName;
  String? name;
  String? surname;
  String? textNumber;
  String? telephone;
  String? tapdk;
  String? city;
  String? district;
  String? address;
  String? latitude;
  String? longitude;

  musteri_bil(
      {this.id,
        this.companyName,
        this.name,
        this.surname,
        this.textNumber,
        this.telephone,
        this.tapdk,
        this.city,
        this.district,
        this.address,
        this.latitude,
        this.longitude});

  musteri_bil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    name = json['name'];
    surname = json['surname'];
    textNumber = json['textNumber'];
    telephone = json['telephone'];
    tapdk = json['tapdk'];
    city = json['city'];
    district = json['district'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['textNumber'] = this.textNumber;
    data['telephone'] = this.telephone;
    data['tapdk'] = this.tapdk;
    data['city'] = this.city;
    data['district'] = this.district;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}