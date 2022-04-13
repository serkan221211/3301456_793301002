import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var name1 = <TextEditingController>[];
  var adet = <TextEditingController>[];
  var money = <TextEditingController>[];
  var sum = <TextEditingController>[];
  var cards = <Card>[];

  Card createCard() {
    var nameController = TextEditingController();
    var adetController = TextEditingController();
    var fiyatController = TextEditingController();
    var sum1 = TextEditingController();
    name1.add(nameController);
    adet.add(adetController);
    money.add(fiyatController);
    sum.add(sum1);
    adetController.text="0";
    fiyatController.text="0";
    sum1.text="0"+" "+"TL";
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[



          Padding(//ürün adı
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

                onTap: (){
                  sum1.text=dropdownValue.toString();//geçiçi
                },
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
                  )
              ),
              keyboardType:TextInputType.number,
              controller: fiyatController,


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
                  )
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
      if(response!=null)
        {
          setState(() {
            var jsona = jsonEncode(response.data);
            dataa = (json.decode(jsona) as List)
                .map((data) => musteri_bil.fromJson(data))
                .toList();
            print(dataa);

          });
          loaad=true;
          print("serkan:"+dataa.length.toString());
          dropdownValue=dataa.first.companyName.toString();
          print(dropdownValue);
        }
      else
        {
          print("object"+response.toString());
          loaad=false;
        }

    }
    catch (e) {
      print(e);
    }
    return dataa;
  }
  var _standards = <musteri_bil>[];
  List<musteri_bil> dataa = [];
  @override
  void initState() {
    getData();
    super.initState();
    cards.add(createCard());
    _standards=dataa;

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

  _onDone() {
    List<PersonEntry> entries = [];
    for (int i = 0; i < cards.length; i++) {
      var name =name1[i].text;
      var adett = adet[i].text;
      var fiyat = money[i].text;
      var sum11=sum[i].text;
      entries.add(PersonEntry(name, adett, fiyat));
    }
    Navigator.pop(context, entries);
  }

  List<String> aa=["MEDYA TİCARET","ENES TİCARET,","YILDIZ TİCARET","ABC TOBACCO","ASD TOBACCO","ADFS TOBACCO","ASASAA TOBACCO","ADSS TOBACCO"];
  String dropdownValue="";
    bool loaad=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Satış"),
      ),
      body: loaad?Center(
        child: Column(
          children: <Widget>[
        DropdownButton<String>(
          borderRadius:BorderRadius.all(Radius.circular(20)),
           value:dropdownValue,
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: const Icon(Icons.add_business_outlined),
          ),
          iconEnabledColor: Colors.blue,
          alignment: Alignment.center,
          elevation: 16,
          autofocus: false,
          isDense: false,
          menuMaxHeight: 250,
          dropdownColor: Colors.white,
          style: const TextStyle(color: Colors.blue),

          underline: DropdownButtonHideUnderline(child: Container()),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              print(dropdownValue);
            });
          },

          items: dataa
              .map<DropdownMenuItem<String>>((musteri_bil standard) {
            return DropdownMenuItem<String>(
              value: standard.companyName,
              child: Text(standard.companyName.toString()),
            );
          }).toList(),
        ),

            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (BuildContext context,  int index) {

                  return Container(
                    child: ListBody(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 155),
                          child: Row(
                            children: [

                              Text('Ürün ${index+ 1}',style: TextStyle(fontWeight: FontWeight.bold,),),
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

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                child: Text('Yeni Ürün Ekle'),
                onPressed: ()
                {
                  setState(() {
                    cards.add(createCard());

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
        child: new FloatingActionButton(
          onPressed: (){

          },
          tooltip: 'Kaydet',
          child: new Icon(Icons.done),
        ),
      ),
    );
  }
}

class PersonEntry {
  final String name;
  final String age;
  final String studyJob;

  PersonEntry(this.name, this.age, this.studyJob);
  @override
  String toString() {
    return 'Person: name= $name, age= $age, study job= $studyJob';
  }
  }

