import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class map extends StatefulWidget {
  const map({Key? key}) : super(key: key);

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,height: 200,
      color: Colors.red,
    );
  }
}
