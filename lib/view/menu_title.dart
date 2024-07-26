
import 'package:flutter/material.dart';
import 'package:laobank/view/home_screen.dart';
class Menutitle extends StatefulWidget {
  const Menutitle({super.key});

  @override
  State<Menutitle> createState() => _MenutitleState();
}

class _MenutitleState extends State<Menutitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/LOGO.png',
          width: 80,
        ),
        Column(
          children: [
            Text(
              'ທະນາຄານແຫ່ງ ສ ປ ປ ລາວ',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'ກົມເຕັກໂນໂລຊີ່ ຂໍ້ມູນຂ່າວສານ',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
