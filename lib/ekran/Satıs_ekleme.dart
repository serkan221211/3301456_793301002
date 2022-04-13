import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();
    cards.add(createCard());
  }

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

  List<String> aa=["aa","sasa,","ssdsd","sds"];
  String dropdownValue ="aa";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Satış"),
      ),
      body: Column(
        children: <Widget>[
      Container(
        width: 200,
        child: DropdownButton<String>(
        value: dropdownValue,
          icon: const Icon(Icons.add_business_outlined),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 1,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: aa.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
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
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.done), onPressed: _onDone),
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

