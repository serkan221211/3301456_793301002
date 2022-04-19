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
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }


  //Delete User Metot.
  Future<void> deleteUser({required String id}) async {
    try {
      var res = await Dio().delete("https://satis-otomasyon-api.herokuapp.com/satis"+'/$id');
      if(res.statusCode==200)
      {
        setState(() {
          getData();
          Navigator.pop(context);
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
  void getData() async {
    try {
      var response = await Dio().get("https://satis-otomasyon-api.herokuapp.com/satis");
      setState(() {
        var jsona = jsonEncode(response.data);
        data_product = (json.decode(jsona) as List).map((data) => satis.fromJson(data)).toList();
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
                                        deleteUser(id: data_product[index1].id.toString());
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
                                          decoration: BoxDecoration(
                                              color: Colors.blue.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(height/75)
                                          ),
                                          height: 60,

                                          child: ListTile(

                                          title: Column(
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.all(height/75),
                                                child: Text(data_product[index1].product![index].name.toString()+" --> "+data_product[index1].product![index].piece.toString()+" X "+data_product[index1].product![index].money.toString()+" TL"+" Toplam: "+data_product[index1].product![index].sum.toString()+" TL",style: TextStyle(fontSize: height/55),),
                                              ),
                                            ],
                                          ),
                                          ),
                                        ),
                                      );
                                      },
                                  ),

                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child:  Text("Tamam",style: TextStyle(color:Colors.black,fontSize: height/40 )),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
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
