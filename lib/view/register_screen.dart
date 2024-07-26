import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:laobank/view/back_to_home.dart';
import 'package:laobank/view/menu_title.dart';
import 'package:laobank/view/page_title.dart';
import 'package:laobank/view/register_show_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController noMeetingRoomController = TextEditingController();
  final TextEditingController nameSurnameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();
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
            title: "ລົງທະບຽນ",
          ),
          Container(
              margin: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: noMeetingRoomController,
                      decoration:
                          InputDecoration(labelText: 'ເລກລະຫັດເຂົ້າຫ້ອງປະຊຸມ'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກະລຸນາໃສ່ເລກລະຫັດເຂົ້າຫ້ອງປະຊຸມ';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: nameSurnameController,
                      decoration:
                          InputDecoration(labelText: 'ຊື່ ແລະ ນາມສະກຸນ'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກະລຸນາໃສ່ຊື່ ແລະ ນາມສະກຸນ';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: noteController,
                      decoration: InputDecoration(labelText: 'ໝາຍເຫດ'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກະລຸນາໃສ່ໝາຍເຫດ';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              )),
          SizedBox(
            width: double.infinity - 10,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  DateTime now = DateTime.now();
                  DateFormat format = DateFormat("yyyy-MM-dd h:mm a");
                  String formattedDate = format.format(now);

                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    String noMeetingRoom = noMeetingRoomController.text;
                    String nameSurname = nameSurnameController.text;
                    String note = noteController.text;

                    // Get the auto-incremented ID
                    DatabaseReference ref =
                        _databaseReference.child('registrations').push();
                    await ref.set({
                      'noMeetingRoom': noMeetingRoom,
                      'nameSurname': nameSurname,
                      'note': note,
                      'time': formattedDate
                    });

                    // Print the UUID (key) to the console
                    String uuid = ref.key!;
                    String lastSixChars = uuid.substring(uuid.length - 6);
                    print('Last six characters of UUID: $lastSixChars');

                    // Print values to console (you can replace this with your logic)
                    print('NoMeeting Room: $noMeetingRoom');
                    print('Name and Surname: $nameSurname');
                    print('Note: $note');
                    print("Formatted Date: $formattedDate");

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RegisterShowScreen(lastSixChars: lastSixChars)),
                    );
                  }
                },
                child: Text('ລົງທະບຽນເຂົ້າຫ້ອງປະຊຸມ'),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
