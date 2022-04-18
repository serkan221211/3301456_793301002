import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:untitled7/model/m%C3%BCsteri_model.dart';


class Musteri_list extends StatefulWidget {
  const Musteri_list({Key? key}) : super(key: key);

  @override
  State<Musteri_list> createState() => _Musteri_listState();
}

class _Musteri_listState extends State<Musteri_list> {
  //Location
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
      });
    } catch (e) {
      print(e);
    }
  }


  List<musteri_bil> data_user = [];//Get Data users.

@override
  void initState() {
    // TODO: implement initState
    getData();//Init State Get Users.
    super.initState();
  }

  //Delete User Metot.
  Future<void> deleteUser({required String id}) async {
    try {
      var res = await Dio().delete("https://satis-otomasyon-api.herokuapp.com/customers"+'/$id');
      if(res.statusCode==200)
        {
          setState(() {
            getData();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:  Text('Silme İşlemi Başarılı.',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.center ,),
                shape: StadiumBorder(),
                behavior: SnackBarBehavior.floating,
                duration: Duration(milliseconds: 2500),
                backgroundColor: Colors.green,

              ),);
          });

        }
      else
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:  Text(res.statusMessage.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.center ,),
              shape: StadiumBorder(),
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 2500),
              backgroundColor: Colors.red,

            ),);
        }
      print('User deleted!'+res.statusCode.toString());
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  //Get Data Users Metot.
  void getData() async {
    try {
      var response = await Dio().get("https://satis-otomasyon-api.herokuapp.com/customers");
      setState(() {
        var jsona = jsonEncode(response.data);
        data_user = (json.decode(jsona) as List).map((data) => musteri_bil.fromJson(data)).toList();
      });
    }
    catch (e) {
      print(e);
    }
  }

  //Progress Bar.
  var bodyProgress = new Container(
    child: new Stack(
      children: <Widget>[
        new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.white70,
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.6),
                borderRadius: new BorderRadius.circular(10.0)
            ),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text("Müşteri Listesi Yükleniyor...", style:  TextStyle(color: Colors.white,fontSize: 16
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
var Screen=MediaQuery.of(context);
var Screen_height=Screen.size.height;
var Screen_width=Screen.size.width;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Müşteriler",style: TextStyle(fontSize:Screen_height/40 ),),
        ),

        body: Container(
          child: data_user.isNotEmpty
              ? ListView.builder(
              itemCount: data_user.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(Screen_height/100),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(Screen_height/50),
                  ),
                  child: ListTile(
                    title: Text(data_user[index].companyName.toString(),style: TextStyle(fontSize: Screen_height/45,fontWeight: FontWeight.w500),),
                    subtitle:
                    Text(data_user[index].name.toString()+" "+data_user[index].surname.toString(),style: TextStyle(fontSize: Screen_height/55),),
                    trailing: IconButton(
                        tooltip: "Kişiyi Sil",
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  title: Text(data_user[index].companyName.toString(),style:TextStyle(fontSize: Screen_height/35,color: Colors.blue,fontWeight: FontWeight.bold) ,textAlign:TextAlign.center,),
                                  content: Text("İsimli İşyerini Silmek İstediğinizden Eminmisiniz?",style: TextStyle(fontSize: Screen_height/50,color: Colors.blue),),
                                  actions: <Widget>[
                                    new TextButton(
                                      child: new Text('Evet',style: TextStyle(fontSize: Screen_height/50)),
                                      onPressed: () {
                                        setState(() {
                                        deleteUser(id: data_user[index].id.toString());
                                           });
                                      },
                                    ),
                                    new TextButton(
                                      child: new Text('Hayır',style: TextStyle(fontSize: Screen_height/50),),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content:  Text('Silme İşlemi İptal Edildi.',style: TextStyle(fontSize: Screen_height/40,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.center ,),
                                            shape: StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(milliseconds: 2500),
                                            backgroundColor: Colors.blue[200],
                                          ),);
                                      },
                                    ),
                                  ],
                                );
                              });
                        }),
                    onTap: (){
                       showDialog<void>(context: context, barrierDismissible: false, builder: (BuildContext context) {
                           return AlertDialog(
                             backgroundColor: Colors.lightBlue.withOpacity(0.6),
                             title:  Text(data_user[index].companyName.toString(),style: TextStyle(color:Colors.white,fontSize: Screen_height/35 ),textAlign: TextAlign.center,),
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.all(Radius.circular(20.0))),
                             content: SingleChildScrollView(
                               child: ListBody(
                                 children:  <Widget>[
                                   Padding(
                                     padding:  EdgeInsets.all(Screen_height/75),
                                     child: Text("İsim: "+data_user[index].name.toString(),style: TextStyle(color:Colors.white,fontSize: Screen_height/50 )),
                                   ),
                                   Padding(
                                     padding:  EdgeInsets.all(Screen_height/75),
                                     child: Text("Soyisim: "+data_user[index].surname.toString(),style: TextStyle(color:Colors.white,fontSize: Screen_height/50 )),
                                   ),
                                   Padding(
                                     padding:  EdgeInsets.all(Screen_height/75),
                                     child: Text("Vergi No: "+data_user[index].textNumber.toString(),style: TextStyle(color:Colors.white,fontSize: Screen_height/50 )),
                                   ),
                                   Padding(
                                     padding:  EdgeInsets.all(Screen_height/75),
                                     child: Text("TAPDK No: "+data_user[index].tapdk.toString(),style: TextStyle(color:Colors.white,fontSize: Screen_height/50 )),
                                   ),
                                   Padding(
                                     padding:  EdgeInsets.all(Screen_height/75),
                                     child: Text("Telefon: "+data_user[index].telephone.toString(),style: TextStyle(color:Colors.white,fontSize: Screen_height/50 )),
                                   ),
                                   Padding(
                                     padding:  EdgeInsets.all(Screen_height/75),
                                     child: Text("İl: "+data_user[index].city.toString(),style: TextStyle(color:Colors.white,fontSize: Screen_height/50 )),
                                   ),
                                   Padding(
                                     padding:  EdgeInsets.all(Screen_height/75),
                                     child: Text("İlçe: "+data_user[index].district.toString(),style: TextStyle(color:Colors.white,fontSize: Screen_height/50 )),
                                   ),
                                   Padding(
                                     padding:  EdgeInsets.all(Screen_height/75),
                                     child: Text("Adres: "+data_user[index].address.toString(),style: TextStyle(color:Colors.white,fontSize: Screen_height/50 )),
                                   ),
                                   Padding(//konum
                                     padding:  EdgeInsets.all(Screen_height/75),
                                     child: GestureDetector(
                                     onTap:() async {
                                       if(data_user[index].longitude.toString().isNotEmpty&&data_user[index].latitude.toString().isNotEmpty)
                                         {
                                           await _determinePosition();
                                           final availableMaps = await MapLauncher.installedMaps;
                                           print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]
                                           await availableMaps.first.showMarker(
                                             coords: Coords(double.parse(data_user[index].latitude.toString()),double.parse(data_user[index].longitude.toString())),
                                             title: data_user[index].companyName.toString(),
                                           );
                                           }

                                       else
                                         {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content:  Text('Kayıtlı Konum Bilgisi Bulunamadı.',style: TextStyle(fontSize: Screen_height/50,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.center ,),
                                              shape: StadiumBorder(),
                                              behavior: SnackBarBehavior.floating,
                                              duration: Duration(milliseconds: 2500),
                                              backgroundColor: Colors.blue[200],
                                            ),);
                                         }
                                         }
                                     ,child: Text("Konum : "+data_user[index].latitude.toString()+","+data_user[index].longitude.toString(),style: TextStyle(color:Colors.white,fontSize: 16,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),)),
                                   ),

                                 ],
                               ),
                             ),
                             actions: <Widget>[
                               TextButton(
                                 child:  Text("Tamam",style: TextStyle(color:Colors.white,fontSize: Screen_height/40 )),
                                 onPressed: () {
                                   Navigator.of(context).pop();
                                   },
                               ),
                              ],
                                );
                             },
                              );
                    },
                  ),
                );
              })
              : bodyProgress,
        ),
      ),
    );
  }
}
