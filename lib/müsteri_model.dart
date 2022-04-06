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
    id = json['Id'];
    companyName = json['CompanyName'];
    name = json['Name'];
    surname = json['Surname'];
    textNumber = json['TextNumber'];
    telephone = json['telephone'];
    tapdk = json['Tapdk'];
    city = json['City'];
    district = json['District'];
    address = json['Address'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CompanyName'] = this.companyName;
    data['Name'] = this.name;
    data['Surname'] = this.surname;
    data['TextNumber'] = this.textNumber;
    data['telephone'] = this.telephone;
    data['Tapdk'] = this.tapdk;
    data['City'] = this.city;
    data['District'] = this.district;
    data['Address'] = this.address;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    return data;
  }
}