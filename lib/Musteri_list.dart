import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Musteri_list extends StatefulWidget {
  const Musteri_list({Key? key}) : super(key: key);

  @override
  State<Musteri_list> createState() => _Musteri_listState();
}
@protected
@mustCallSuper
void initState() {

}
class _Musteri_listState extends State<Musteri_list> {

  //List<Musteri_bilgileri> Musteri_veriler = <Musteri_bilgileri>[];
  List<String> Musteri_dukkan = ["MEDYA TİCARET","ABC TİCARET","NARGİLE DÜNYASI","AD TİACARET"];
  List<String> Musteri_ad = ["MEHMET","AHMET","YAVUZ","DENİZ"];
  List<String> Musteri_soyad = ["YILDIZ","KAN","VELİ","KESİM"];
  List<String> Musteri_vergi = ["18766171872","17245210147","147852369851","70145201475"];
  List<String> Musteri_tapdk = ["14785254PT","52047856PT","14785203PT","14785201PT"];
  List<String> Musteri_tel = ["05378520211","05427856339","05315558974","05369854563"];
  List<String> Musteri_il = ["Denizli","Konya","Adana","Isparta"];
  List<String> Musteri_ilce = ["Pamukkale","Selçuklu","Yüreğir","Merkez"];
  List<String> Musteri_adres = ["adres1","adres2","adres3","adres4"];
  List<String> Musteri_borc = ["56000","10000","20000","5000"];
  List<String> Musteri_konum = ["konum1","konum2","konum3","konum4"];
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("MÜŞTERİLER"),
        ),

        body: Container(
          child: Musteri_dukkan.length != 0
              ? ListView.builder(
              itemCount: Musteri_dukkan.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    title: Text(Musteri_dukkan[index]),
                    subtitle:
                    Text(Musteri_ad[index]+" "+Musteri_soyad[index]),
                    trailing: IconButton(
                        tooltip: "Kişiyi Sil",
                        icon: Icon(Icons.delete),
                        onPressed: () async {

                        }),
                    onTap: (){
                       showDialog<void>(
                         context: context,
                         barrierDismissible: false, // user must tap button!
                         builder: (BuildContext context) {
                           return AlertDialog(
                             backgroundColor: Colors.blue,
                             title:  Text(Musteri_dukkan[index],style: TextStyle(color:Colors.white,fontSize: 25 ),),
                             content: SingleChildScrollView(
                               child: ListBody(
                                 children:  <Widget>[
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("İsim: "+Musteri_ad[index],style: TextStyle(color:Colors.white,fontSize: 16 )),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("Soyisim: "+Musteri_soyad[index],style: TextStyle(color:Colors.white,fontSize: 16 )),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("Vergi No: "+Musteri_vergi[index],style: TextStyle(color:Colors.white,fontSize: 16 )),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("TAPDK No: "+Musteri_tapdk[index],style: TextStyle(color:Colors.white,fontSize: 16 )),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("Telefon: "+Musteri_tel[index],style: TextStyle(color:Colors.white,fontSize: 16 )),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("İl: "+Musteri_il[index],style: TextStyle(color:Colors.white,fontSize: 16 )),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("İlçe: "+Musteri_ilce[index],style: TextStyle(color:Colors.white,fontSize: 16 )),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("Adres: "+Musteri_adres[index],style: TextStyle(color:Colors.white,fontSize: 16 )),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("Borç Bilgisi: "+Musteri_borc[index]+"TL",style: TextStyle(color:Colors.white,fontSize: 16 )),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text("KONUM: "+Musteri_konum[index],style: TextStyle(color:Colors.white,fontSize: 16 )),
                                   ),

                                 ],
                               ),
                             ),
                             actions: <Widget>[
                               TextButton(

                                 child:  Text("Tamam",style: TextStyle(color:Colors.white,fontSize: 18 )),
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
              : Center(
            child: Text("Kayıtlı Veri Yok."),
          ),
        ),
      ),
    );
  }
}
