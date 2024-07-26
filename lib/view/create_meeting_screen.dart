import 'package:flutter/material.dart';
import 'package:laobank/view/back_to_home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:laobank/view/menu_title.dart';
import 'package:laobank/view/page_title.dart';
import 'package:intl/intl.dart';

class CreateMeetingScreen extends StatefulWidget {
  const CreateMeetingScreen({super.key});

  @override
  State<CreateMeetingScreen> createState() => _CreateMeetingScreenState();
}

class _CreateMeetingScreenState extends State<CreateMeetingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();

  final TextEditingController _whereController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _docController = TextEditingController();
  final TextEditingController _idMeetingRoomController =
      TextEditingController();

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

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
      return 'ກະລຸນາເລືອກວັນທີເປີດກອງປະຊຸມ';
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

  String? _validateTimeEnd(String? value) {
    if (value == null || value.isEmpty) {
      return 'ກະລຸນາລະບຸເວລາປິດກອງປະຊຸມ';
    }
    return null;
  }

  String? _validateTimeStart(String? value) {
    if (value == null || value.isEmpty) {
      return 'ກະລຸນາລະບຸເວລາເປີດກອງປະຊຸມ';
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
                BackToHome(),
              ],
            ),
            Pagetitle(title: "ສ້າງຫ້ອງປະຊຸມ"),
         
         
           Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        controller: _titleController,
                        decoration:
                            InputDecoration(labelText: 'ຫົວຂໍ້ກອງປະຊຸມ'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາໃສຫົວຂໍ້ກອງປະຊຸມ';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _dateTimeController,
                        decoration: InputDecoration(
                          labelText: 'ວັນທີ ແລະ ເວລາ',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _selectDateTime(context),
                          ),
                        ),
                        readOnly: true,
                        validator: _validateDateTime,
                      ),
                      TextFormField(
                        controller: _timeStartController,
                        decoration: InputDecoration(
                          labelText: 'ເວລາເປີດກອງປະຊຸມ',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.timer_off),
                            onPressed: () async {
                              final TimeOfDay? pickedTimeEnd =
                                  await showTimePicker(
                                context: context,
                                initialTime: _selectedTime ?? TimeOfDay.now(),
                              );
                              if (pickedTimeEnd != null) {
                                setState(() {
                                  // _selectedTime = pickedTimeEnd;
                                  _timeStartController.text =
                                      pickedTimeEnd.format(context);
                                });
                              }
                            },
                          ),
                        ),
                        readOnly: true,
                        validator: _validateTimeStart,
                      ),
                      TextFormField(
                        controller: _timeEndController,
                        decoration: InputDecoration(
                          labelText: 'ເວລາປິດກອງປະຊຸມ',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.timer_off),
                            onPressed: () async {
                              final TimeOfDay? pickedTimeEnd =
                                  await showTimePicker(
                                context: context,
                                initialTime: _selectedTime ?? TimeOfDay.now(),
                              );
                              if (pickedTimeEnd != null) {
                                setState(() {
                                  // _selectedTime = pickedTimeEnd;
                                  _timeEndController.text =
                                      pickedTimeEnd.format(context);
                                });
                              }
                            },
                          ),
                        ),
                        readOnly: true,
                        validator: _validateTimeEnd,
                      ),
                      TextFormField(
                        controller: _whereController,
                        decoration: InputDecoration(labelText: 'ມາຈາກພາກສ່ວນ'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາບອກມາຈາກພາກສ່ວນໃດ';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _peopleController,
                        decoration: InputDecoration(labelText: 'ວິທະຍາກອນ'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາລະບຸວິທະຍາກອນ';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _docController,
                        decoration: InputDecoration(labelText: 'ເອກະສານປະກອບ'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາລະບຸເອກະສານປະກອບ';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _idMeetingRoomController,
                        decoration: InputDecoration(labelText: 'ຫ້ອງປະຊຸມ'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາລະບຸໝາຍເລກຫ້ອງປະຊຸມ';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Process the data

                              // Get the auto-incremented ID
                              DatabaseReference ref =
                                  _databaseReference.child('roommtting').push();
                              await ref.set({
                                'titleMeeting': _titleController.text,
                                'dateAndTime': _dateTimeController.text,
                                'people': _peopleController.text,
                                'doc': _docController.text,
                                'iDMeetingRoom': _idMeetingRoomController.text,
                                "timeClose": _timeEndController.text,
                                "timeOpen": _timeStartController.text,
                                "where": _whereController.text
                              });
                              if (ref.key != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('ສ້າງຫ້ອງປະຊຸມສຳເຫຼັ້ດ')),
                                );
                                _formKey.currentState?.reset();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('ສ້າງຫ້ອງປະຊຸມບໍ່ສຳເຫຼັ້ດ')),
                                );
                                _formKey.currentState?.reset();
                              }

                              print('Title Meeting: ${_titleController.text}');
                              print(
                                  'Date and Time: ${_dateTimeController.text}');
                              print('Where: ${_whereController.text}');
                              print('People: ${_peopleController.text}');
                              print('Doc: ${_docController.text}');
                              print(
                                  'ID Meeting Room: ${_idMeetingRoomController.text}');
                            }
                          },
                          child: Text('ສ້າງຫ້ອງປະຊຸມ'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
       
       
       
       
          ],
        ),
      ),
    );
  }
}
