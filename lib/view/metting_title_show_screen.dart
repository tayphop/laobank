import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laobank/view/back_to_home.dart';
import 'package:laobank/view/home_screen.dart';
import 'package:laobank/view/menu_title.dart';
import 'package:laobank/view/metting_title_screen.dart';
import 'package:laobank/view/page_title.dart';
import 'package:laobank/view/register_screen.dart';

class MettingTitleShowScreen extends StatefulWidget {
  final Map<String, String> meeting;
  const MettingTitleShowScreen({Key? key, required this.meeting})
      : super(key: key);

  @override
  State<MettingTitleShowScreen> createState() => _MettingTitleShowScreenState();
}

class _MettingTitleShowScreenState extends State<MettingTitleShowScreen> {
  get id => null;

  @override
  Widget build(BuildContext context) {
    final meeting = widget.meeting;
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
                    MaterialPageRoute(
                        builder: (context) => MettingTitleScreen()),
                  );
                },
                child: Text('ກັບຄືນຫົວຂໍ້ກອງປະຊຸມ'),
              )
            ],
          ),
          Pagetitle(
            title: ' ${meeting['titleMeeting'] ?? ' '}',
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'ວັນທີ ເວລາເປີດກອງປະຊຸມ:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(' : '),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _formatDate(meeting['dateAndTime']),
                            //child: Text('Alignment',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'ເວລາເປິດກອງປະຊຸມ:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(' : '),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${meeting['timeOpen'] ?? ' '}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'ເວລາປິດກອງປະຊຸມ:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(' : '),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${meeting['timeClose'] ?? ' '}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'ມາຈາກພາກສ່ວນ:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(' : '),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${meeting['where'] ?? ' '}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'ວິທະຍາກອນ:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(' : '),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${meeting['people'] ?? ' '}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'ຫ້ອງປະຊຸມ:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(' : '),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${meeting['iDMeetingRoom'] ?? ' '}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'ເອກະສານຮັບໄຊກອງປະຊຸມ:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(' : '),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'data',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  String _formatDate(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty) {
      return ' ';
    }
    try {
      // Parse the original date string to DateTime object
      DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      DateTime dateTime = inputFormat.parse(dateTimeStr);

      // Format the DateTime object to the desired string format
      DateFormat outputFormat = DateFormat('dd-MM-yyyy');
      return outputFormat.format(dateTime);
    } catch (e) {
      print('Error parsing date: $e');
      return 'Invalid Date';
    }
  }
}
