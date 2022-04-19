import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled7/model/satis.dart';


class Satis_list extends StatefulWidget {
  const Satis_list({Key? key}) : super(key: key);

  @override
  State<Satis_list> createState() => _Satis_listState();
}


class _Satis_listState extends State<Satis_list> {

  List<satis> data_product = [];
  List<Product> data=[];
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }
  void getData() async {
    try {
      var response = await Dio().get("https://satis-otomasyon-api.herokuapp.com/satis");
      setState(() {
        var jsona = jsonEncode(response.data);
        data_product = (json.decode(jsona) as List).map((data) => satis.fromJson(data)).toList();
        data=(json.decode(jsona) as List).map((data) => Product.fromJson(data)).toList();
        print(data.toString()+"sdds:"+data_product.length.toString());
        print(data_product[0].product!.length);

      });
    }
    catch (e) {
      print(e);
    }
  }

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
                color: Colors.lightBlue.withOpacity(0.7),
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
                    child: new Text("Satış Listesi Yükleniyor...", style: new TextStyle(color: Colors.white
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
    //Screen Size
    var Screen=MediaQuery.of(context);
    var height=Screen.size.height;
    var width=Screen.size.width;
    int index1;
    return Scaffold(

      appBar: AppBar(
        title: Text("Satışlar",style: TextStyle(fontSize: height/40),),
      ),

      body:Container(
        child: data_product.isNotEmpty
            ? ListView.builder(
            itemCount: data_product.length,
            itemBuilder: (context, index1) {
              return Container(
                margin: EdgeInsets.all(height/70),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(height/50),
                ),

                child: ListTile(
                  title: Padding(padding:  EdgeInsets.only(bottom: height/80),
                    child: Text(data_product[index1].companyName.toString(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: height/45),),
                  ),
                  subtitle: Text(data_product[index1].date.toString(),style: TextStyle(fontSize: height/60),),
                  trailing: IconButton(
                      tooltip: "Satış Sil",
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: Text(data_product[index1].companyName.toString(),style:TextStyle(fontSize: height/40,color: Colors.blue,fontWeight: FontWeight.bold) ,textAlign:TextAlign.center,),
                                content: Text("İsimli Satışı Silmek İstediğinizden Eminmisiniz?",style: TextStyle(fontSize: height/50,color: Colors.blue,fontWeight: FontWeight.w700),),
                                actions: <Widget>[
                                  new TextButton(
                                    child: new Text('Evet',style: TextStyle(fontSize: height/50,fontWeight: FontWeight.w500)),
                                    onPressed: () {
                                      setState(() {

                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content:Text('Silme İşlemi Başarılı.',style: TextStyle(fontSize: height/45,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.center ,),
                                            shape: StadiumBorder(),
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(milliseconds: 2500),
                                            backgroundColor: Colors.green,

                                          ),);
                                      });
                                    },
                                  ),
                                  new TextButton(
                                    child: new Text('Hayır',style: TextStyle(fontSize: height/50,fontWeight: FontWeight.w500),),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content:  Text('Silme İşlemi İptal Edildi.',style: TextStyle(fontSize: height/45,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.center ,),
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
                    showDialog<void>(context: context, barrierDismissible: false, builder: (BuildContext context) {
                        return SizedBox(
                              width: width*0.7,
                              child: AlertDialog(
                              title: Column(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.all(height/65),
                                    child: Text(data_product[index1].companyName.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: height/35),),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.all(height/65),
                                    child: Text("Genel Toplam : "+data_product[index1].total.toString()+" TL",style: TextStyle(fontSize: height/40),),
                                  ),

                                ],
                              ),
                                content: Container(
                                  width: width*0.7,
                                  child: ListView.builder(
                                    itemCount: data_product[index1].product!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext context, int index)
                                      {
                                      return Padding(
                                        padding:  EdgeInsets.all(height/65),
                                        child: Container(
                                          height: 50,
                                          color: Colors.blue.withOpacity(0.3),
                                          child: ListTile(

                                          title: Column(
                                            children: [
                                              Text(data_product[index1].product![index].name.toString()+" --> "+data_product[index1].product![index].piece.toString()+" X "+data_product[index1].product![index].money.toString()+" TL"+" Toplam: "+data_product[index1].product![index].sum.toString()+" TL",style: TextStyle(fontSize: height/55),),
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
