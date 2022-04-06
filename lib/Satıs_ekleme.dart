
import 'package:flutter/material.dart';

class Satis_ekleme extends StatefulWidget {
  @override
  _Satis_eklemeState createState() => _Satis_eklemeState();
}

class _Satis_eklemeState extends State<Satis_ekleme> {
  List<DynamicWidget> listDynamic = [];
  List<String> data = [];

  Icon floatingIcon = new Icon(Icons.add);

  addDynamic() {
    if (data.length != 0) {
      floatingIcon = new Icon(Icons.add);

      data = [];
      listDynamic = [];

    }
    setState(() {});

    listDynamic.add(new DynamicWidget());
  }

  submitData() {
    floatingIcon = new Icon(Icons.arrow_back);
    data = [];
    listDynamic.forEach((widget) => data.add(""));
    setState(() {});
    print(data.length);
  }

  @override
  Widget build(BuildContext context) {
    Widget result = new Flexible(
        flex: 1,
        child: new Card(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return new Padding(
                padding: new EdgeInsets.all(5.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      child: new Text("${index + 1} : ${data[index]}"),
                    ),
                    new Divider()
                  ],
                ),
              );
            },
          ),
        ));

    Widget dynamicTextField = new Flexible(
      flex: 2,
      child: new ListView.builder(
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    );

    Widget submitButton = new Container(
      child: new ElevatedButton(
        onPressed: submitData,
        child: new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Text('Submit Data'),
        ),
      ),
    );

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(

        appBar: new AppBar(
          title: new Text('Satış'),
          centerTitle: true,
        ),
        body: new Container(
          margin: new EdgeInsets.all(5.0),
          child: new Column(
            children: <Widget>[
              data.length == 0 ? dynamicTextField : result,
              data.length == 0 ? submitButton : new Container(),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: addDynamic,
          child: floatingIcon,
        ),
      ),
    );
  }
}

class DynamicWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(


      margin: new EdgeInsets.all(5.0),
      child:  Row(
       children: [
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: SizedBox(
             width: 150,
             child: TextField//ürün adı
               (
               autofocus: false,
               keyboardType: TextInputType.text,
               textAlign: TextAlign.left,
               textCapitalization: TextCapitalization.characters,//büyük harf
               style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
               decoration: InputDecoration(
                   hintText: "Ürün adı",
                   hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: 12),


                   border: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.blue),
                     borderRadius: BorderRadius.circular(10.0),
                   )
               ),
             ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: SizedBox(
             width: 55,
             child: TextField//ürün adedi
               (
               autofocus: false,
               keyboardType: TextInputType.number,
               textAlign: TextAlign.left,
               textCapitalization: TextCapitalization.characters,//büyük harf
               style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
               decoration: InputDecoration(
                   hintText: "Adet",
                   hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: 12),
                   border: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.black),
                     borderRadius: BorderRadius.circular(10.0),
                   )
               ),
             ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: SizedBox(
             width: 50,
             child: TextField//ürün fiyatı
               (
               autofocus: false,
               keyboardType: TextInputType.number,
               textAlign: TextAlign.left,
               textCapitalization: TextCapitalization.characters,//büyük harf
               style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
               decoration: InputDecoration(
                   hintText: "Fiyat",
                   hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38,fontSize: 12),

                   border: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.black),
                     borderRadius: BorderRadius.circular(10.0),
                   )
               ),
             ),
           ),
         ),
        Container(
          height: 55,
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),

          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Text
                ("fiyat",style: TextStyle(fontSize: 12),),
            ),
          ),
        ),
         SizedBox(
           width: 40,

           child: IconButton(
               onPressed:()
               {

               },
               icon: Icon(Icons.delete)),
         )
       ],
      ),
    );
  }
}