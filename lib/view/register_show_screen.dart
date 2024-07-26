import 'package:flutter/material.dart';
import 'package:laobank/view/back_to_home.dart';
import 'package:laobank/view/home_screen.dart';
import 'package:laobank/view/menu_title.dart';
import 'package:laobank/view/page_title.dart';
import 'package:laobank/view/register_screen.dart';

class RegisterShowScreen extends StatefulWidget {
  final String lastSixChars;

  const RegisterShowScreen({super.key, required this.lastSixChars});

  @override
  State<RegisterShowScreen> createState() => _RegisterShowScreenState();
}

class _RegisterShowScreenState extends State<RegisterShowScreen> {
    String get spacedLastSixChars {
    return widget.lastSixChars.split('').join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Menutitle(),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text('ກັບຄືນໜ້າລົງທະບຽນ'),
              )
            ],
          ),
          Pagetitle(
            title: " ສຳເຫຼັ້ດການລົງທະບຽນ",
          ),
          Container(
            margin: EdgeInsets.all(20),

            width: double.infinity,
            // height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  // color: Colors.red,
                  blurRadius: 2,
                  offset: Offset(1, 1), // Shadow position
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'ລະຫັດການລົງທະບຽນຂອງທ່ານ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                   spacedLastSixChars,
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.deepOrange),
                  ),
                  Text(
                    'ກະລຸນານຳລະຫັດດັ່ງກ່າວ ແຈ້ງຕໍ່ເຈົ້າໜ້າທີ່ຮັບລົງທະບຽນໜ້າງານ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
