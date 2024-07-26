import 'package:flutter/material.dart';
import 'package:laobank/view/home_screen.dart';



class Pagetitle extends StatelessWidget {
  final String title;
  const Pagetitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        title,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}
