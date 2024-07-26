import 'package:flutter/material.dart';
import 'package:laobank/view/back_to_home.dart';
import 'package:laobank/view/home_screen.dart';
import 'package:laobank/view/menu_title.dart';
import 'package:laobank/view/metting_title_screen.dart';
import 'package:laobank/view/page_title.dart';
import 'package:laobank/view/totalmetting_join_room_screen.dart';
import 'package:laobank/view/totalmetting_manage_room_screen.dart';

class TotalMettingScreen extends StatefulWidget {
  const TotalMettingScreen({super.key});

  @override
  State<TotalMettingScreen> createState() => _TotalMettingScreenState();
}

class _TotalMettingScreenState extends State<TotalMettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            children: [Menutitle(), Spacer(), BackToHome()],
          ),
          Pagetitle(
            title: "ສະຖິຕິກອງປະຊຸມ",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TotalmettingManageRoomScreen()),
                    );
                  },
                  child: SizedBox(
                    width: 130,
                    height: 130,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/mobile-chat.png',
                            width: 80,
                          ),
                          Text(
                            'ການຈັດກອງປະຊຸມ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5) // Sets the border radius to zero
                        ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TotalmettingJoinRoomScreen()),
                    );
                  },
                  child: SizedBox(
                    width: 130,
                    height: 130,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/resume.png',
                            width: 80,
                          ),
                          Text(
                            'ການເຂົ້າຮ່ວມກອງປະຊຸມ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    ));
  }
}
