import 'package:flutter/material.dart';
import 'Musteri_list.dart';
import 'MüşteriKayit.dart';
import 'Satıs_ekleme.dart';


class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyDrawerState();

}

class _MyDrawerState extends State {


  @override
  Widget build(BuildContext context) {
    var Screen=MediaQuery.of(context);
    var Screen_height=Screen.size.height;
    var Screen_width=Screen.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("ANASAYFA"),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: Screen_height/4,
              child: DrawerHeader(
                child: Image.asset("resimler/logo_1.png"),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            ListTile//müşteriler
              (
              leading: Icon(Icons.account_circle, size: Screen_height/23,),
              title: Text('MÜŞTERİLER',style: TextStyle(fontSize: Screen_height/55),),
             // subtitle: Text("This is the 1st item"),
              trailing: Icon(Icons.arrow_right_outlined,size: Screen_height/23,),
              onTap:() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Musteri_list()));
              },
            ),
            ListTile//müşteri kayıt
              (
              leading: Icon(Icons.account_circle_outlined, size: 30,),
              title: Text('MÜŞTERİ KAYIT'),
              // subtitle: Text("This is the 1st item"),
              trailing: Icon(Icons.arrow_right_outlined,size: 35,),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Musteri_kayit()));
              },
            ),
            ListTile//satışlar
              (
              leading: Icon(Icons.article_outlined, size: 30,),
              title: Text('SATIŞLAR'),
              // subtitle: Text("This is the 1st item"),
              trailing: Icon(Icons.arrow_right_outlined,size: 35,),
              onTap: () {},
            ),
            ListTile//yeni satış
              (
              leading: Icon(Icons.article, size: 30,),
              title: Text('YENİ SATIŞ'),
              // subtitle: Text("This is the 1st item"),
              trailing: Icon(Icons.arrow_right_outlined,size: 35,),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Satis_ekleme()));


              },
            ),
            ListTile//harita
              (
              leading: Icon(Icons.location_on_outlined, size: 30,),
              title: Text('HARİTA'),
              // subtitle: Text("This is the 1st item"),
              trailing: Icon(Icons.arrow_right_outlined,size: 35,),
              onTap: () {

              },
            ),
            Container(height: 340,),
            Center(
              child: Text
                ("@MEDYATOBACCO A.Ş",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Image.asset("resimler/logo.png"),
        ),
      ),
    );
  }
}