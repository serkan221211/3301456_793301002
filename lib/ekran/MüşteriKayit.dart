import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:untitled7/ekran/HomePage.dart';
import 'package:untitled7/model/m%C3%BCsteri_model.dart';
import 'package:uuid/uuid.dart';



class Musteri_kayit extends StatefulWidget {
  const Musteri_kayit({Key? key}) : super(key: key);

  @override
  State<Musteri_kayit> createState() => _Musteri_kayitState();
}





class _Musteri_kayitState extends State<Musteri_kayit> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  String currentAddress = 'My Address';
  Position? currentposition;
  String? location = "";

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
        tfkonum.text=location.toString();
      });
    } catch (e) {
      print(e);
    }
  }


  var uuid = Uuid(); // id Generate
  String enlemm=""; // müşteri enlem
  String boylamm=""; // müşteri boylam
  musteri_bil? m1; // müşteri model object

  //TextField Controller
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


  // müşteri model post metot
  void basicPostRequest(musteri_bil m) async {
    var response = await Dio().post("https://satis-otomasyon-api.herokuapp.com/customers", data: m.toJson(),options: Options(followRedirects: false, validateStatus: (status) => true,));
     if(response.statusCode==201)
       {
         print("object:"+response.statusCode.toString());
         tfil.clear();tfadres.clear();tfilce.clear();tftapdk.clear();tfTel.clear();tfvergi.clear();tfsurname.clear();tfname.clear();tfnameI.clear();tfkonum.clear();
         Navigator.push(context, MaterialPageRoute(builder: (context) => MyDrawer()));
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content:  Text('Kayıt Başarılı.',style: TextStyle(fontSize: 900/50,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.left ,),
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
       }
     else
     {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content:  Text(response.statusMessage.toString(),style: TextStyle(fontSize: 900/50,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.left ,),
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


  @override
  Widget build(BuildContext context) {
    var Screen=MediaQuery.of(context);
    var width=Screen.size.width;
    var height=Screen.size.height;

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("Müsteri Kayıt",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: height/35),textAlign: TextAlign.center),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding:   EdgeInsets.only(left:height/70,right:height/70,bottom: height/70,top: height/35),
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
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: height/65),//12px
                    prefixIcon: Icon(Icons.add_business_outlined),
                    label:Text("İŞYERİ ÜNVANI",style: TextStyle(fontSize: height/50),),//16px
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(height/35),
                    )
                ),
              ),


            ),


            Padding(
              padding:  EdgeInsets.all(height/70),
              child: TextField
                (
                controller: tfname,
                autofocus: false,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.left,
                textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "İSİM",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize:  height/65),
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    label:Text("İSİM",style: TextStyle(fontSize: height/50),),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(height/35),
                    )
                ),
              ),
            ),


            Padding(
              padding:  EdgeInsets.all(height/70),
              child: TextField(
                controller: tfsurname,
                autofocus: false,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.left,
                textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "SOYİSİM",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: height/65),
                    prefixIcon: Icon(Icons.account_circle_outlined),
                    label:Text("SOYİSİM",style: TextStyle(fontSize: height/50),),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(height/35),
                    )
                ),
              ),
            ),


            Padding(
              padding:  EdgeInsets.all(height/70),
              child: TextField(
                controller: tfvergi,
                autofocus: false,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.left,
                //textCapitalization: TextCapitalization.characters,//büyük harf
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: "VERGİ NO",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: height/65),
                    prefixIcon: Icon(Icons.article_outlined),
                    label:Text("VERGİ NO",style: TextStyle(fontSize: height/50),),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(height/35),
                    )
                ),
              ),
            ),


            Padding(
              padding:  EdgeInsets.all(height/70),
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
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: height/65),
                    prefixIcon: Icon(Icons.phone),
                    label:Text("TELEFON NUMARASI",style: TextStyle(fontSize: height/50),),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(height/35),
                    )
                ),
              ),
            ),


            Padding(

              padding:  EdgeInsets.all(height/70),
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
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: height/65),
                    prefixIcon: Icon(Icons.article),
                    label:Text("TAPDK NO",style: TextStyle(fontSize: height/50)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(height/35),
                    )
                ),
              ),
            ),



            Padding(
              padding:  EdgeInsets.all(height/70),
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
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: height/65),
                    prefixIcon: Icon(Icons.location_city),
                    label:Text("İL",style: TextStyle(fontSize: height/50),),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(height/35),
                    )
                ),
              ),
            ),



            Padding(
              padding:  EdgeInsets.all(height/70),
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
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: height/65),
                    prefixIcon: Icon(Icons.location_city_sharp),
                    label:Text("İLÇE",style: TextStyle(fontSize: height/50)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(height/35),
                    )
                ),
              ),
            ),


            Padding(
              padding:  EdgeInsets.all(height/70),
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
                    hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: height/65),
                    prefixIcon: Icon(Icons.add_location),
                    label:Text("ADRES",style: TextStyle(fontSize: height/50)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(height/35),
                    )
                ),
              ),
            ),


            Row(

              children: [
                Padding(
                  padding:  EdgeInsets.only(top: height/65 , left: height/65,right: height/65),
                  child: SizedBox(width: 250, height: height/7.8,
                    child: TextField//Konum
                      (readOnly: true,
                      controller: tfkonum,
                      autofocus: false,
                      maxLines: null,
                      textAlign: TextAlign.left,
                      //  textCapitalization: TextCapitalization.characters,//büyük harf
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                          hintText: "Konum",
                          hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black,fontSize: height/65),
                          prefixIcon: Icon(Icons.add_location),
                          label:Text("KONUM",style: TextStyle(fontSize: height/50),),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(height/35),
                          )
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding:  EdgeInsets.only(bottom: height/30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(height/45),
                      color: Colors.blue,
                    ),
                    width: width/4,height: height/15,

                    child: TextButton(onPressed: () async {
                      tfkonum.text="";
                      print("Konum Alındı");
                      await _determinePosition();
                    final availableMaps = await MapLauncher.installedMaps;
                    if(location.toString().isNotEmpty)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(

                            elevation: 10.0,
                            margin: EdgeInsets.all(height/70),
                            content:  Container(
                                height: 20,
                                child: Text('Konum Alma Başarılı.',style: TextStyle(fontSize: height/50,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.center ,)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(height/65))),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(milliseconds: 1500),
                            backgroundColor: Colors.green,

                          ),);
                      }
                    else
                      {

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:  Container(
                                height: 20,
                                child: Text('Konum Alma Başarısız!',style: TextStyle(fontSize: height/50,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.center ,)),
                            elevation: 10.0,
                            margin: EdgeInsets.all(height/70),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(height/65))),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(milliseconds: 1500),
                            backgroundColor: Colors.red,

                          ),);

                      }
                    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                      }, child: Text("Konum Al", style: TextStyle(color: Colors.white,fontSize: 16),
                    )
                    ),
                  ),
                ),
              ],
            ),




            Padding(
              padding:  EdgeInsets.all(height/75),
              child: Text("@MEDYATOBACCO A.Ş" ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: height/60),
              ),
            ),
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
          setState(() {
            try {
              if(tfnameI.text.isNotEmpty)
                {
              m1=musteri_bil(id: uuid.v4().toString(),companyName: tfnameI.text,name: tfname.text,surname: tfsurname.text,textNumber:tfvergi.text,telephone: tfTel.text,tapdk: tftapdk.text,district: tfilce.text,address: tfadres.text,city: tfil.text,latitude:enlemm,longitude: boylamm);
              basicPostRequest(m1!);
              }

              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:  Text("İş Yeri Adı Boş Geçilemez!",style: TextStyle(fontSize: height/50,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.left ,),
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

            catch(e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:  Text(e.toString(),style: TextStyle(fontSize: height/50,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.left ,),
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
        tooltip: 'Kaydet',
        icon: const Icon(Icons.add_circle_outline),

      ),

    );
  }
}
