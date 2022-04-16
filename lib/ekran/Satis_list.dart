
import 'dart:core';

import 'package:flutter/material.dart';

class Satis_list extends StatefulWidget {
  const Satis_list({Key? key}) : super(key: key);

  @override
  State<Satis_list> createState() => _Satis_listState();
}

class _Satis_listState extends State<Satis_list> {


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
                color: Colors.blue[200],
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
                    child: new Text(
                      "Müşteri Listesi Yükleniyor...",
                      style: new TextStyle(
                          color: Colors.white
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
  List<String> Company=["MEDYA TİCARET"];
  List<String> urun_name=["Calbor Yellow","Calbor Touch","Wintor","Wentor","Calbor 02","Calbor Green","Calbor Yellow","Calbor Touch","Wintor","Wentor","Calbor 02","Calbor Green"];
  List<String> urun_Adet=["10","5","3","2","2","2","10","5","3","2","2","2"];
  List<String> urun_fiyat=["20","30","40","50","120","12","20","30","40","50","120","12"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Satışlar",),
      ),
      body:Container(
        child: urun_name.isNotEmpty
            ? ListView.builder(
            itemCount: Company.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  title: Text(Company.first.toString()),
                  subtitle:
                  Text(DateTime.now().toString()),

                  trailing: IconButton(
                      tooltip: "Kişiyi Sil",
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(Company.first.toString(),style:TextStyle(fontSize: 18,color: Colors.blue,fontWeight: FontWeight.bold) ,textAlign:TextAlign.center,),
                                content: Text("İsimli Satışı Silmek İstediğinizden Eminmisiniz?",style: TextStyle(fontSize: 16,color: Colors.blue),),
                                actions: <Widget>[
                                  new TextButton(
                                    child: new Text('Evet',style: TextStyle(fontSize: 16)),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.of(context).pop();

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: const Text('Silme İşlemi Başarılı.',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.left ,),
                                            shape: StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(milliseconds: 2500),
                                            backgroundColor: Colors.green,

                                          ),);
                                      });
                                    },
                                  ),
                                  new TextButton(
                                    child: new Text('Hayır',style: TextStyle(fontSize: 16),),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Silme İşlemi İptal Edildi.',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.left ,),
                                          shape: StadiumBorder(),
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(milliseconds: 2500),
                                          backgroundColor: Colors.red,

                                        ),);
                                    },
                                  ),

                                ],

                              );
                            });

                      }),
                  onTap: (){
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return
                            SizedBox(
                              width: 390,
                              child: AlertDialog(
                              title: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text
                                      (Company.first.toString(),textAlign: TextAlign.center,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text
                                      ("Genel Toplam : "+(double.parse(urun_Adet[index].toString())*double.parse(urun_fiyat[index].toString())).toString()+" TL"),
                                  ),
                                ],
                              ),

                                content: Container(

                                  width: 400,
                                  child: ListView.builder(


                                    itemCount: urun_Adet.length,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext context, int index)
                                      {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container
                                          (
                                          height: 50,
                                          color: Colors.blue[200],
                                          child: ListTile(
                                          title: Column(
                                            children: [
                                              Text(urun_name[index].toString()+" --> "+urun_Adet[index].toString()+" X "+urun_fiyat[index].toString()+" TL"+" Toplam: "+(double.parse(urun_fiyat[index])*double.parse(urun_Adet[index])).toString()+" TL"),
                                            ],
                                          ),

                                          ),

                                        ),
                                      );
                                      },


                                  ),

                                ),

                          ),
                            


                        );
                      },
                    );

                  },
                ),
              );
            })
            : bodyProgress,
      ),
    );
  }
}
