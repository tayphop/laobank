import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laobank/view/create_meeting_screen.dart';
import 'package:laobank/view/home_screen.dart';
import 'package:laobank/view/menu_title.dart';
import 'package:laobank/view/metting_title_screen.dart';
import 'package:laobank/view/page_title.dart';
import 'package:laobank/view/register_screen.dart';
import 'package:laobank/view/totalmetting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Menutitle(),
          Pagetitle(
            title: "ລະບົບຈັດການກອງປະຊຸມ",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5), 
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MettingTitleScreen()),
                    );
                  },
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/communicate.png',
                            width: 80,
                          ),
                          Text(
                            'ເຂົ້າຮ່ວມກອງປະຊຸມ',
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
                      MaterialPageRoute(builder: (context) => CreateMeetingScreen()),
                    );
                  },
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/workspace.png',
                            width: 80,
                          ),
                          Text(
                            'ສ້າງຫ້ອງປະຊຸມ',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/video-call.png',
                            width: 80,
                          ),
                          Text(
                            'ລົງທະບຽນ',
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
                          5), // Sets the border radius to zero
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TotalMettingScreen()),
                    );
                  },
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/list.png',
                            width: 80,
                          ),
                          Text(
                            'ສະຖິຕິ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}
