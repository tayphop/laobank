import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laobank/view/back_to_home.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:laobank/view/home_screen.dart';
import 'package:laobank/view/menu_title.dart';
// import 'package:laobank/view/metting_title_screen.dart';
import 'package:laobank/view/page_title.dart';
import 'package:laobank/view/totalmetting_screen.dart';

class TotalmettingManageRoomScreen extends StatefulWidget {
  const TotalmettingManageRoomScreen({super.key});

  @override
  State<TotalmettingManageRoomScreen> createState() =>
      _TotalmettingManageRoomScreenState();
}

class _TotalmettingManageRoomScreenState
    extends State<TotalmettingManageRoomScreen> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();
  List<Map<dynamic, dynamic>> meetings = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _dateTimeController_2 = TextEditingController();

  DateTime? _selectedDate;
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    setState(() {
      _dateTimeController.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
    });
  }

  String? _validateDateTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'ກະລຸນາເລືອກວັນທີເລີມຄົ້ນຫາ';
    }
    try {
      DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (e) {
      // print(e);
      return 'Invalid date and time format';
      // return e.toString();
    }
    return null;
  }

  DateTime? _selectedDate_2;
  Future<void> _selectDateTime_2(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    setState(() {
      _dateTimeController_2.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
    });
  }

  String? _validateDateTime_2(String? value) {
    if (value == null || value.isEmpty) {
      return 'ກະລຸນາເລືອກວັນທີເລີມຄົ້ນຫາ';
    }
    try {
      DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (e) {
      // print(e);
      return 'Invalid date and time format';
      // return e.toString();
    }
    return null;
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
              Container(
                margin: EdgeInsets.only(right: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TotalMettingScreen()),
                    );
                  },
                  child: Text('ກັບຄືນ'),
                ),
              )
            ],
          ),
          Pagetitle(
            title: "ສະຖິຕິການຈັດການຫ້ອງປະຊຸມ",
          ),
          //  Padding(padding: EdgeInsets.all(10)),
          meetings.length > 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'ຄົ້ນພົບເຫັນຈຳນວນ ${meetings.length} ລາຍການ',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(' '),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              meetings = [];
                            });
                          },
                          child: Text('ຄົ້ນຫາໃໝ່'))
                    ],
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            controller: _dateTimeController,
                            decoration: InputDecoration(
                              labelText: 'ວັນທີເລີ່ມຄົ້ນຫາ',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () => _selectDateTime(context),
                              ),
                            ),
                            readOnly: true,
                            validator: _validateDateTime,
                          ),
                          TextFormField(
                            controller: _dateTimeController_2,
                            decoration: InputDecoration(
                              labelText: 'ວັນທີສຸດທ້າຍຄົ້ນຫາ',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () => _selectDateTime_2(context),
                              ),
                            ),
                            readOnly: true,
                            validator: _validateDateTime_2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _fetchFilteredMeetings();
                                }
                              },
                              child: Text('ຄົ້ນຫາ'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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

  void _fetchFilteredMeetings() {
    _databaseReference
        .child('roommtting')
        .orderByChild('dateAndTime')
        .startAt(_dateTimeController.text)
        .endAt(_dateTimeController_2.text)
        .once()
        .then((DatabaseEvent event) {
      //  print(event.snapshot.value);
      List<Map<dynamic, dynamic>> tempMeetings = [];

      // DateTime now = DateTime.now();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> values =
            event.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          // tempMeetings.add(value);
          String dateTimeStr = value['dateAndTime'] ?? '';
          // print('Raw dateAndTime value: $dateTimeStr');
          try {
            // Use DateFormat to parse the custom date format
            // DateFormat format = DateFormat("yyyy-MM-dd");
            // DateTime meetingDateTime = format.parse(dateTimeStr);
            print('Raw dateAndTime value: ' +
                value['titleMeeting'] +
                "=>" +
                dateTimeStr);
            tempMeetings.add(value);
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
}

Widget _buildMeetingCard(Map<dynamic, dynamic> meeting, BuildContext context) {
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

  return Container(
    margin: EdgeInsets.all(5),
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
    child: Expanded(
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
                      'ຊື່ກອງປະຊຸມ:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text(' : '),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (meeting['titleMeeting']),
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
                      'ວັນທີ ເວລາເປີດກອງປະຊຸມ:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
  );
}
