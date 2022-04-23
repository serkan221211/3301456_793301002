import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled7/model/satis.dart';
import 'package:uuid/uuid.dart';
import '../model/müsteri_model.dart';

class aa extends StatelessWidget {
  const aa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SOF(),
    );
  }
}

class SOF extends StatefulWidget {
  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<SOF> {
  TextEditingController tfNakit= TextEditingController();
  TextEditingController tfKart= TextEditingController();
  TextEditingController tfToplam= TextEditingController();
  TextEditingController tfKalan= TextEditingController();



  var name1 = <TextEditingController>[]; //ürün adı
  var adet = <TextEditingController>[];  //ürün adet
  var money = <TextEditingController>[]; //ürün adet fiyatı
  var sum = <TextEditingController>[];  // ürün toplam fiyatı
  var cards = <Card>[];

  Card createCard() {
    var nameController = TextEditingController(); // product name controller
    var adetController = TextEditingController(); // piece  controller
    var fiyatController = TextEditingController(); //money controller
    var sum1 = TextEditingController(); // sum controller

    name1.add(nameController); // name controller add list
    adet.add(adetController); // piece controller add list
    money.add(fiyatController); //money controller add list
    sum.add(sum1);  // sum controller add list

    adetController.text="0.0";
    fiyatController.text="0.0";
    sum1.text="0.0";

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(//ürün adı
                autofocus: false,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.article_outlined),
                    labelText: "Ürün Adı",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                ),
                keyboardType:TextInputType.name,
                controller: nameController,

            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(//ürün adedi
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.article_outlined),
                  labelText: "Ürün Adet",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  )
              ),
              keyboardType:TextInputType.number,
              controller: adetController,
              onTap: (){

                if(adetController.text.isEmpty)
                {
                  adetController.text="0.0";
                }
                if(fiyatController.text.isEmpty)
                {
                  fiyatController.text="0.0";

                }
              },
              onChanged: (value_adet)
              {
                if(fiyatController.text.isEmpty)
                  {
                    fiyatController.text="0.0";
                  }
                if(value_adet.isEmpty)
                  {
                    value_adet="0";
                    sum1.text="0.0";
                  }
                else
                  {
                    value_adet=value_adet;
                    sum1.text=(double.parse(value_adet)*double.parse(fiyatController.text)).toString();
                    print("total_company.toString()");
                    double total_company=0.0;
                    for(int i=0;i<sum.length;i++)
                    {
                      total_company=double.parse(sum[i].text.toString())+total_company;
                    }

                    tfToplam.text=total_company.toString();
                  }


              },


            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(//ürün fiyat
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.article_outlined),
                  labelText: "Ürün Fiyat",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
              ),
              keyboardType:TextInputType.number,
              controller: fiyatController,
              onTap: ()
              {
                if(adetController.text.isEmpty)
                {
                  adetController.text="0.0";
                }
                if(fiyatController.text.isEmpty)
                {
                  fiyatController.text="0.0";

                }
              },
              onChanged: (value_fiyat)
              {

                if(adetController.text.isEmpty)
                {
                  adetController.text="0.0";
                }
                if(value_fiyat.isEmpty)
                {
                  value_fiyat="0.0";
                  sum1.text="0.0";
                }
                else
                {
                  value_fiyat=value_fiyat;
                  sum1.text=(double.parse(value_fiyat)*double.parse(adetController.text)).toString();


                  double total_company=0.0;
                  for(int i=0;i<sum.length;i++)
                  {
                    total_company=double.parse(sum[i].text.toString())+total_company;
                  }
                  print(total_company.toString());
                  tfToplam.text=total_company.toString();
                }

              },

            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(//toplam fiyat
              readOnly: true,
              autofocus: false,

              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.article_outlined),
                  labelText: "Ürün Toplam Fiyat",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
              ),
              keyboardType:TextInputType.number,
              controller: sum1,


            ),
          ),
        ],
      ),

    );
  }


  Future<List<musteri_bil>> getData() async {
    try {
      var response = await Dio().get("https://satis-otomasyon-api.herokuapp.com/customers");
      print("staus:"+response.statusCode.toString());
      if(response.statusCode==200)
        {
          setState(() {
            var jsona = jsonEncode(response.data);
            dataa = (json.decode(jsona) as List).map((data) => musteri_bil.fromJson(data)).toList();
            print(dataa);

          });
          loaad=true;
          print("serkan:"+dataa.length.toString());
          dropdownValue=dataa.first.companyName.toString();
          print(dropdownValue);
        }

      else
        {
          print("object"+response.statusCode.toString());
          loaad=false;
        }

    }

    catch (e) {
      print(e);
    }
    return dataa;
  }


  List<musteri_bil> dataa = [];


  @override
  void initState() {
    getData();
    super.initState();
    cards.add(createCard());
    product1=[];
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
                    child: new Text("Veriler  Yükleniyor...", style: new TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold
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



  satis? s;
  List<Product> product1=[];

  void PostData(satis s) async {
    Dio dio = new Dio();
  var    response1 = await dio.post("https://satis-otomasyon-api.herokuapp.com/satis", data: s.toJson(),options: Options(followRedirects: true,
      // will not throw errors
      validateStatus: (status) => true,
    ));
  if(response1.statusCode==201)
    {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:  Text('Satış Başarılı',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.center ,),
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 2000),
          backgroundColor: Colors.green,
        ),);
    }
  else
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:  Text(response1.statusMessage.toString(),style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.center ,),
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 2000),
          backgroundColor: Colors.red,
        ),);
    }
    print("Code:"+response1.statusCode.toString());
    print("\nMessage"+response1.statusMessage.toString());

  }


  var uuid = Uuid();//uniqe id Product
  var uuid1 = Uuid(); // uniqe id Urun
  String dropdownValue=""; // combobox select item
    bool loaad=false;// load data field

  @override
  Widget build(BuildContext context) {
    var screen=MediaQuery.of(context);
    var height=screen.size.height;
    var width=screen.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Satış",style:TextStyle(fontSize: height/40),),
      ),

      body: loaad?Center(
        child: Column(
          children: <Widget>[
        Center(
          child: Padding(
            padding:  EdgeInsets.only(top: height/75,bottom: height/55),
            child: SizedBox(
              child: DropdownButton<String>(
                borderRadius:BorderRadius.all(Radius.circular(height/50)),
                 value:dropdownValue,
                icon: Padding(
                  padding:  EdgeInsets.all(height/75),
                  child: const Icon(Icons.arrow_drop_down),
                ),
                iconEnabledColor: Colors.blue,
                alignment: Alignment.center,
                elevation: 16,
                autofocus: false,
                iconSize: height/23,
                isDense: false,
                isExpanded: false,
                menuMaxHeight: height/3,
                dropdownColor: Colors.white,
                style:  TextStyle(color: Colors.blue,),
                underline: Container(width: 1,),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    print(dropdownValue);
                  });
                },
                items: dataa.map<DropdownMenuItem<String>>((musteri_bil standard) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: standard.companyName,
                    child: Text(standard.companyName.toString(),style: TextStyle(fontSize: height/40),textAlign: TextAlign.center,),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (BuildContext context,  int index) {
                  return Container(
                    child: ListBody(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: width/2.6),
                          child: Row(
                            children: [
                              Text('Ürün ${index+ 1}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/55),),
                              IconButton(onPressed:(){
                                setState(() {
                                  cards.removeAt(index);
                                });
                              },  icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                        cards[index],

                      ],
                    ),
                  );
                },
              ),
            ),
            Row(

              children: [
                Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: SizedBox(
                    height: 60,
                    width: width/4.1,
                    child: TextField
                      (
                      controller: tfNakit,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                          hintText: "Nakit",
                          hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: height/65),
                          label:Text("Nakit",style: TextStyle(fontSize: height/50),),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(height/60),
                          )
                      ),
                      onChanged: (value)
                      {
                        tfKalan.text=(double.parse(tfToplam.text.isEmpty?"0":tfToplam.text)-(double.parse(tfKart.text.isEmpty?"0":tfKart.text)+double.parse(value.isEmpty?"0":value))).toString();

                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.5),
                  child: SizedBox(
                    height: 60,
                    width: width/4.1,
                    child: TextField(
                      controller: tfKart,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                          hintText: "K.Kartı",
                          hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: height/65),
                          label:Text("K.Kartı",style: TextStyle(fontSize: height/50),),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(height/70),
                          )
                      ),
                      onChanged: (value)
                      {
                        tfKalan.text=(double.parse(tfToplam.text.isEmpty?"0":tfToplam.text)-(double.parse(tfNakit.text.isEmpty?"0":tfNakit.text)+double.parse(value.isEmpty?"0":value))).toString();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: width/4.1,
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: TextField(
                      controller: tfToplam,
                      autofocus: false,
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                          hintText: "G.Toplam",
                          hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: height/65),

                          label:Text("G.Toplam",style: TextStyle(fontSize: height/60),textAlign: TextAlign.center,),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(height/60),
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: width/4.1,
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: TextField(
                      controller: tfKalan,
                      autofocus: false,
                      readOnly: true,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                          hintText: "Kalan",
                          hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: height/65),
                          label:Text("Kalan",style: TextStyle(fontSize: height/50),textAlign: TextAlign.center,),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(height/60),
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),



            Padding(
              padding:  EdgeInsets.all(height/45),
              child: TextButton(
                child: Text('Yeni Ürün Ekle'),
                onPressed: ()
                {
                  setState(() {
                    if(name1[name1.length-1].text.isNotEmpty&&adet[adet.length-1].text.isNotEmpty&&money[money.length-1].text.isNotEmpty) {
                      cards.add(createCard());
                    }
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:  Text('Lütfen Boş Kolonları Doldurun!',style: TextStyle(fontSize: height/45,fontWeight:FontWeight.bold ,color: Colors.white),textAlign:TextAlign.center ,),
                          shape: StadiumBorder(),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(milliseconds: 2000),
                          backgroundColor: Colors.blue[200],
                        ),);
                    }
                  }
                  );
                },
              ),
            )
          ],
        ),
      ):bodyProgress,
      floatingActionButton: new Visibility(
        visible: loaad,
        //Send Data
        child: new FloatingActionButton(
          onPressed: (){
           double total_company=0.0;
            for(int i=0;i<sum.length;i++)
            {
                total_company=double.parse(sum[i].text.toString())+total_company;
                product1.add(new Product(id: uuid1.v4().toString(), money:money[i].text.toString() ,name: name1[i].text.toString(), piece: adet[i].text.toString(),sum: sum[i].text.toString()));
            }


            s=satis(id: uuid.v4().toString(),cash: tfNakit.text.toString(),card: tfKart.text.toString(),remainder: tfKalan.text.toString(),companyName: dropdownValue,date: DateTime.now().toString(),total: total_company.toString(),product: product1);
            print(product1.length.toString());
            PostData(s!);

          },
          tooltip: 'Kaydet',
          child: new Icon(Icons.done),
        ),
      ),
    );
  }
}



