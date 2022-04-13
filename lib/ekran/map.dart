import 'package:flutter/material.dart';

class map extends StatefulWidget {
  const map({Key? key}) : super(key: key);

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Harita",style: TextStyle(color: Colors.white,),textAlign: TextAlign.left),
      ),
      body:Center(

      ),
    );
  }
}
