
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:untitled7/HomePage.dart';
import 'package:untitled7/m%C3%BCsteri_model.dart';


class Musteri_kayit extends StatefulWidget {
  const Musteri_kayit({Key? key}) : super(key: key);

  @override
  State<Musteri_kayit> createState() => _Musteri_kayitState();
}

class _Musteri_kayitState extends State<Musteri_kayit> {

  String currentAddress = 'My Address';
   Position? currentposition;
   String location = "";

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
        location = position.latitude.toString() + " , " + position.longitude.toString();
        enlemm=  position.latitude.toString();
        boylamm=position.longitude.toString();
      });
    } catch (e) {
      print(e);
    }
  }
  String enlemm="";
  String boylamm="";
   musteri_bil? m1;
  TextEditingController tfnameI= TextEditingController();
  TextEditingController tfname= TextEditingController();
  TextEditingController tfTel= TextEditingController();
  TextEditingController tfvergi= TextEditingController();
  TextEditingController tftapdk= TextEditingController();
  TextEditingController tfil= TextEditingController();
  TextEditingController tfilce= TextEditingController();
  TextEditingController tfadres= TextEditingController();
  TextEditingController tfsurname= TextEditingController();
  TextEditingController tfkonum= TextEditingController();
  void basicPostRequest(musteri_bil m) async {

    var response = await Dio().post("https://serkanjson.herokuapp.com/customers", data: m.toJson());
    print(response);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MÜŞTERİ KAYIT",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),textAlign: TextAlign.center),
      ),
      body:

      SingleChildScrollView(
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 30),
              child: TextField//İŞYERİ ÜNVANI
                (
                controller: tfnameI,
                autofocus: false,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.left,
                textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "İŞYERİ ÜNVANI",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: 12),
                    prefixIcon: Icon(Icons.add_business_outlined),
                    label:Text("İŞYERİ ÜNVANI"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
              ),


            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField//İSİM
                (
                controller: tfname,
                autofocus: false,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.left,
                textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "İSİM",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: 12),
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    label:Text("İSİM"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField//SOYİSİM
                (
                controller: tfsurname,
                autofocus: false,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.left,
                textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "SOYİSİM",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: 12),
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    label:Text("SOYİSİM"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: tfvergi,
                autofocus: false,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.left,
                //textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "VERGİ NO",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: 12),
                    prefixIcon: Icon(Icons.article_outlined),
                    label:Text("VERGİ NO"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField//TELEFON
                (
                controller: tfTel,
                autofocus: false,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.left,
                //  textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "TELEFON NUMARASI",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: 12),
                    prefixIcon: Icon(Icons.phone),
                    label:Text("TELEFON NUMARASI"),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
              ),
            ),

            Padding//TAPDK NO
              (

              padding: const EdgeInsets.all(10.0),
              child: TextField//TAPDK NO
                (
                controller: tftapdk,
                autofocus: false,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.left,
                //  textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "TAPDK NO",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: 12),
                    prefixIcon: Icon(Icons.article),
                    label:Text("TAPDK NO"),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
              ),
            ),

            Padding//İL
              (
              padding: const EdgeInsets.all(10.0),
              child: TextField
                (
                controller: tfil,
                autofocus: false,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.left,
                //  textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "İL",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: 12),
                    prefixIcon: Icon(Icons.location_city),
                    label:Text("İL"),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
              ),
            ),

            Padding//İLÇE
              (
              padding: const EdgeInsets.all(10.0),
              child: TextField
                (
                controller: tfilce,
                autofocus: false,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.left,
                //  textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "İLÇE",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: 12),
                    prefixIcon: Icon(Icons.location_city_sharp),
                    label:Text("İLÇE"),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
              ),
            ),
            Padding
              (
              padding: const EdgeInsets.all(10.0),
              child: TextField//adres
                (
                controller: tfadres,
                maxLines: null,
                autofocus: false,
                keyboardType: TextInputType.streetAddress,
                textAlign: TextAlign.left,
                //  textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "ADRES",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: 12),
                    prefixIcon: Icon(Icons.add_location),
                    label:Text("ADRES"),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    )
                ),
              ),
            ),
            Row(

              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0 , left: 12.0,right: 12.0),
                  child: SizedBox(width: 250, height: 100,
                    child: TextField//Konum
                      (readOnly: true,
                      controller: tfkonum,

                      autofocus: false,
                      maxLines: null,
                      textAlign: TextAlign.left,
                      //  textCapitalization: TextCapitalization.characters,//büyük harf
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                          hintText: currentposition == null ? "null" : location,
                          hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: 12),
                          prefixIcon: Icon(Icons.add_location),
                          label:Text("KONUM"),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(25.0),
                          )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(15),
                      color: Colors.blue,
                    ),
                    width: 100,height: 50,

                    child: TextButton(onPressed: () async {

                      print("Konum Alındı");
                      await _determinePosition();
                    final availableMaps = await MapLauncher.installedMaps;
                    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                    await availableMaps.first.showMarker(
                      coords: Coords(currentposition!.latitude, currentposition!.longitude),
                      title: "Müşteri Adı",
                    );
                      }, child: Text("Konum Al", style: TextStyle(color: Colors.white,fontSize: 16),
                    )
                    ),
                  ),
                ),
              ],
            ),



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text
                ("@MEDYATOBACCO A.Ş" ,style: TextStyle(
                  fontWeight: FontWeight.bold,color: Colors.blue
              ),
              ),
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){


          setState(() {
            try {
              m1=musteri_bil(id: "1",companyName: tfnameI.text,name: tfname.text,surname: tfsurname.text,textNumber:tfvergi.text,telephone: tfTel.text,tapdk: tftapdk.text,district: tfilce.text,address: tfadres.text,city: tfil.text,latitude:enlemm,longitude: boylamm);
              basicPostRequest(m1!);
              tfil.clear();tfadres.clear();tfilce.clear();tftapdk.clear();tfTel.clear();tfvergi.clear();tfsurname.clear();tfname.clear();tfnameI.clear();tfkonum.clear();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyDrawer()));
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Kayıt Başarılı.',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.left ,),
                    shape: StadiumBorder(),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(milliseconds: 4000),
                    backgroundColor: Colors.green,
                    action: SnackBarAction(
                      textColor: Colors.white,

                      label: 'Tamam',
                      onPressed: () {

                      },
                    ),
                  ),);

            }  catch(e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Başarısız",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.left ,),
                    shape: StadiumBorder(),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(milliseconds: 4000),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      textColor: Colors.white,

                      label: 'Tamam',
                      onPressed: () {

                      },
                    ),
                  ),);

            }

          }
                );


        },
        label: const Text('KAYDET'),
        tooltip: 'Increment',
        icon: const Icon(Icons.add_circle_outline),
      ),
    );
  }
}
