import 'package:flutter/material.dart';
import 'ekran/HomePage.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MEDYA TOBACCO',
      theme: ThemeData(

        backgroundColor: Colors.red,
      ),
      home: MyDrawer(),
      //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MÜŞTERİ KAYIT",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),textAlign: TextAlign.center),
      ),
      body:Center(

      ),
    );
  }
}
