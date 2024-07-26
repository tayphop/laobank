import 'package:flutter/material.dart';
import 'package:laobank/view/home_screen.dart';

class BackToHome extends StatelessWidget {
  const BackToHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(right: 6),
      child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5), 
                      ),
                    ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Text('ກັບຄືນ'),
                ),
    );
  }
}