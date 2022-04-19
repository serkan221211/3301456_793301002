import 'package:flutter/material.dart';
import 'package:untitled7/ekran/Satis_list.dart';
import 'package:untitled7/ekran/map.dart';
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

    //Screen Size
    var Screen=MediaQuery.of(context);
    var Screen_height=Screen.size.height;
    var Screen_width=Screen.size.width;


    return Scaffold(

      appBar: AppBar(
        centerTitle: false,
        title: Text("Anasayfa",style: TextStyle(fontSize:Screen_height/40),),
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
              title: Text('Müşteriler',style: TextStyle(fontSize: Screen_height/45),),
           //  subtitle: Text("This is the 1st item"),
              trailing: Icon(Icons.arrow_right_outlined,size: Screen_height/23,),
              onTap:() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Musteri_list()));
              },
            ),

            ListTile//müşteri kayıt
              (
              leading: Icon(Icons.account_circle_outlined, size: Screen_height/23,),
              title: Text('Müşteri Kayıt',style:TextStyle(fontSize: Screen_height/45),),
              // subtitle: Text("This is the 1st item"),
              trailing: Icon(Icons.arrow_right_outlined,size: Screen_height/23,),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Musteri_kayit()));
              },
            ),

            ListTile//satışlar
              (
              leading: Icon(Icons.article_outlined, size: Screen_height/23,),
              title: Text('Satışlar',style: TextStyle(fontSize: Screen_height/45),),
              // subtitle: Text("This is the 1st item"),
              trailing: Icon(Icons.arrow_right_outlined,size: Screen_height/23,),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Satis_list()));
              },
            ),


            ListTile//yeni satış
              (
              leading: Icon(Icons.article, size: Screen_height/23,),
              title: Text('Yeni Satış',style: TextStyle(fontSize: Screen_height/45),),
              // subtitle: Text("This is the 1st item"),
              trailing: Icon(Icons.arrow_right_outlined,size: Screen_height/23,),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => aa()));
              },
            ),

            ListTile//harita
              (
              leading: Icon(Icons.location_on_outlined, size: Screen_height/23,),
              title: Text('Harita',style: TextStyle(fontSize: Screen_height/45),),
              // subtitle: Text("This is the 1st item"),
              trailing: Icon(Icons.arrow_right_outlined,size: Screen_height/23,),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
              },
            ),


            Container(height: Screen_height/2.75,),
            Center(
              child: Text("@MEDYATOBACCO A.Ş",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize:Screen_height/55 ),
              ),
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