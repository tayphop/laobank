import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:laobank/view/back_to_home.dart';
// import 'package:laobank/view/home_screen.dart';
import 'package:laobank/view/menu_title.dart';
import 'package:laobank/view/metting_title_show_screen.dart';
// import 'package:laobank/view/metting_title_show_screen.dart';
import 'package:laobank/view/page_title.dart';

class MettingTitleScreen extends StatefulWidget {
  const MettingTitleScreen({super.key});

  @override
  State<MettingTitleScreen> createState() => _MettingTitleScreenState();
}

class _MettingTitleScreenState extends State<MettingTitleScreen> {
  //var id = 'ກອງປະຊຸມຕີບຸ່ນ 90090';

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();
  List<Map<dynamic, dynamic>> meetings = [];
  @override
  void initState() {
    super.initState();
    _fetchFilteredMeetings();
  }

void _fetchFilteredMeetings() {
  _databaseReference
      .child('roommtting')
      .orderByChild('dateAndTime')
      .once()
      .then((DatabaseEvent event) {
    List<Map<dynamic, dynamic>> tempMeetings = [];
    DateTime now = DateTime.now();
    if (event.snapshot.value != null) {
      Map<dynamic, dynamic> values =
          event.snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        String dateTimeStr = value['dateAndTime'] ?? '';
        try {
          DateTime meetingDateTime;
          // Check if the date string contains time
          if (dateTimeStr.contains(' ')) {
            // Use DateFormat to parse the date and time
            DateFormat format = DateFormat("yyyy-MM-dd h:mm a");
            meetingDateTime = format.parse(dateTimeStr);
          } else {
            // Use DateFormat to parse only the date and set the time to end of the day
            DateFormat format = DateFormat("yyyy-MM-dd");
            meetingDateTime = format.parse(dateTimeStr);
            meetingDateTime = meetingDateTime.add(Duration(hours: 23, minutes: 59, seconds: 59));
         
          }

          // print('Parsed meetingDateTime: $meetingDateTime');
          // print('Current time: $now');

          if (meetingDateTime.isAfter(now)) {
            tempMeetings.add(value);
          } else {
            print('${value['titleMeeting']} is before or equal to now');
          }
        } catch (e) {
          print('Error parsing date: $dateTimeStr');
          print('Exception: $e');
        }
      });
    }
    setState(() {
      meetings = tempMeetings;
    });
    print(tempMeetings);
  }).catchError((error) {
    print('55 Error: $error');
  });
}



  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            children: [Menutitle(), Spacer(), BackToHome()],
          ),
          Pagetitle(
            title: "ຫົວຂໍ້ກອງປະຊຸມ",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: meetings.length,
              itemBuilder: (context, index) {
                return _buildMeetingCard(meetings[index], context);
              },
            ),
          ),
        ],
      ),
    ));
  }
}

Widget _buildMeetingCard(Map<dynamic, dynamic> meeting, BuildContext context) {
  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          blurRadius: 2,
          offset: Offset(1, 1),
        ),
      ],
    ),
    child: Row(
      children: [
        Image.asset(
          'assets/images/icon_title_met.png',
          width: 80,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meeting['titleMeeting'] ?? '',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "ຫ້ອງປະຊຸມ:" + meeting['iDMeetingRoom'] ?? '',
                  //   textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 6),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              print(meeting);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MettingTitleShowScreen(
                      meeting: Map<String, String>.from(meeting)),
                ),
              );
            },
            child: Text('>'),
          ),
        ),
      ],
    ),
  );
}

