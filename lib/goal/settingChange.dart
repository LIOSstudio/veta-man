import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:veta/goal/prioritypage.dart';
import 'package:veta/goal/py1.dart';
import '../login/register.dart';
import '../navigationbar.dart';
import 'leadtimepage.dart';
import 'categorypage.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';


class SettingChange extends StatelessWidget {
  const SettingChange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          ),
        ),
        home: ChangeNotifierProvider(
            create: (context) {
              return selectedProvider();},
            child : _Settingpage()
        )
    );}
}


class _Settingpage extends StatefulWidget {
  _Settingpage({Key? key}) : super(key: key);

  @override
  State<_Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<_Settingpage> {
  late selectedProvider _selecteProvider;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser;

  var title = "??";

  var time = "?";

  int priority = 0;

  var category = "??";

  var title1 = "??";

  var dateTime = 0;

  String selected_value = "Study";

  var value_list = [
    "Study",
    "Exercise",
    "Reading",
    "Relations",
    "Hobby",
    "Job prepare"
  ];

  var bt1 = const Color(0xffbFF6D6D);

  var bt2 = const Color(0xffbFFB36D);

  var bt3 = const Color(0xffbFFE86D);

  var bt4 = const Color(0xffb9CFF6D);

  var bt5 = const Color(0xffb6DA8FF);

  @override
  Widget build(BuildContext context) {
    _selecteProvider = Provider.of<selectedProvider>(context, listen: false);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            elevation: 0,
            foregroundColor: const Color(0xffb936DFF),
            backgroundColor: Colors.white,
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    DocumentSnapshot data =
                    await firestore.collection('ToDo').doc('ToDoo2').get();
                    title1 = data['Title'];
                    priority = data['priority'];
                    dateTime = data["time"];
                    category = data['category'];
                    firestore.collection(user!.uid).doc().set({
                      "Title": '$title1',
                      "priority": priority,
                      "category": category,
                      "time": dateTime,
                      "Completion": false
                    });
                    firestore.collection('ToDo').doc('ToDoo2').set({
                      "selected_time" : "Expected time"
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavigationPage()),
                    );
                  },
                  child: Text('Save'),
                  style: TextButton.styleFrom(
                    primary: const Color(0xffb936DFF),
                    backgroundColor: Colors.white,
                    elevation: 1, shape: BeveledRectangleBorder(),
                    padding: EdgeInsets.all(0.0),
                    // minimumSize: Size(0,0)
                  )),
            ]),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 90.0,),
            Container(
              child: TextField(
                style: TextStyle(fontSize: 16, color: Colors.black),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color:const Color(0xffbD5D5D5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color:const Color(0xffb936DFF)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Please enter title',
                    labelStyle: TextStyle(color: const Color(0xffD5D5D5))
                ),
                onChanged: (value) {
                  title = value;
                  firestore
                      .collection('ToDo')
                      .doc('ToDoo2')
                      .update({"Title": title});
                },
              ),
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only( left: 20),
              width: 300,
              height: 100,
            ),
            Container(
                width: 355,
                height: 20,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            child: Image.asset('assets/time.png'), width: 5)),
                    Expanded(
                        flex: 4,
                        child: Text("Expect time setting"))
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            Container(
                width: 250,
                height: 50,
                child: ElevatedButton (
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          int selected_hour = 0;
                          int selected_minute = 0;
                          String selectedTime = "";
                          FirebaseFirestore firestore = FirebaseFirestore.instance;
                          return CustomHourPicker(
                            elevation: 2,
                            onPositivePressed: (context, time) {
                              selected_hour = time.hour;
                              selected_minute = time.minute;
                              selectedTime = "$selected_hour" + ":" + "$selected_minute";
                              print(selectedTime);
                              firestore.collection('ToDo').doc('ToDoo2').update({"selected_time": selectedTime,
                                "time": time.hour});
                              _selecteProvider.timeselect();
                              Navigator.pop(context);
                            },
                            onNegativePressed: (context) {
                              Navigator.pop(context);
                            },);
                        },
                      );
                    },
                    child: Text(Provider.of<selectedProvider>(context).selectedTime.toString()),
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                        minimumSize: Size(40, 50)))),
            SizedBox(
              height: 15,
            ),
            Container(
                width: 355,
                height: 20,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            child: Image.asset('assets/pri.png'), width: 5)),
                    Expanded(
                        flex: 4,
                        child: Text("Priority setting"))
                  ],
                )),
            Container(
              height: 20,
              child: Text("       "),
            ),
            Container(
                padding: EdgeInsets.only(left:20),
                width: 350,
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        elevation: 0,
                        mini: true,
                        heroTag: 'pri1',
                        child: Text(" "),
                        backgroundColor: bt1,
                        onPressed: () {
                          priority = 2;
                          firestore
                              .collection('ToDo')
                              .doc('ToDoo2')
                              .update({"priority": priority});
                          bt1 = const Color(0xffb936DFF);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        elevation: 0,
                        mini: true,
                        heroTag: 'pri2',
                        child: Text(" "),
                        backgroundColor: const Color(0xffbFFB36D),
                        onPressed: () {
                          priority = 2;
                          firestore
                              .collection('ToDo')
                              .doc('ToDoo2')
                              .update({"priority": priority});
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        elevation: 0,
                        mini: true,
                        heroTag: 'pri3',
                        child: Text(" "),
                        backgroundColor: const Color(0xffbFFE86D),
                        onPressed: () {
                          priority = 3;
                          firestore
                              .collection('ToDo')
                              .doc('ToDoo2')
                              .update({"priority": priority});
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        elevation: 0,
                        mini: true,
                        heroTag: 'pri4',
                        child: Text(" "),
                        backgroundColor: const Color(0xffb9CFF6D),
                        onPressed: () {
                          priority = 4;
                          firestore
                              .collection('ToDo')
                              .doc('ToDoo2')
                              .update({"priority": priority});
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        elevation: 0,
                        mini: true,
                        heroTag: 'pri5',
                        child: Text(" "),
                        backgroundColor: const Color(0xffb6DA8FF),
                        onPressed: () {
                          priority = 5;
                          firestore
                              .collection('ToDo')
                              .doc('ToDoo2')
                              .update({"priority": priority});
                        },
                      ),
                    ),
                  ],
                )),
            Container(
              width: 355,
              height: 25,
              padding: EdgeInsets.only(left: 23),
              child: Image.asset(
                'assets/prio.png',
                fit: BoxFit.contain,
                height: 35,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 355,
              height: 20,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          child: Image.asset('assets/cate.png'), width: 5)),
                  Expanded(
                      flex: 4,
                      child: Text("Category setting"))
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 40),
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: const Color(0xffb936DFF), width: 1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: DropdownButton(
                        isExpanded: true,
                        iconSize: 34,
                        value: selected_value,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: const Color(0xffb936DFF),
                        items: value_list.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          selected_value = newValue!;
                          firestore
                              .collection('ToDo')
                              .doc('ToDoo2')
                              .update({"category": selected_value});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));

  }
}

class selectedProvider extends ChangeNotifier {
  String _selectedTime = "Expected time";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String get selectedTime => _selectedTime;

  void timeselect() async{
    DocumentSnapshot data1 =
    await firestore.collection('ToDo').doc('ToDoo2').get();
    _selectedTime = data1["selected_time"];
    notifyListeners();
  }
}

buildCustomTimer(BuildContext context) {
  late selectedProvider _selecteProvider;
  int selected_hour = 0;
  int selected_minute = 0;
  String selectedTime = "";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  _selecteProvider = Provider.of<selectedProvider>(context, listen: false);
  return CustomHourPicker(
    elevation: 2,
    onPositivePressed: (context, time) {
      selected_hour = time.hour;
      selected_minute = time.minute;
      selectedTime = "$selected_hour" + ":" + "$selected_minute";
      print(selectedTime);
      firestore.collection('ToDo').doc('ToDoo2').update({"selected_time": selectedTime,
        "time": time.hour});
      _selecteProvider.timeselect;
      Navigator.pop(context,selectedTime);
    },
    onNegativePressed: (context) {
      Navigator.pop(context);
    },
  );
}

Widget hourMinute24H() {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var _dateTime = 0;
  return Container(
    color: Colors.white,
    padding: EdgeInsets.only(top: 100),
    child: new Column(
      children: <Widget>[
        new TimePickerSpinner(
            is24HourMode: true,
            onTimeChange: (time) {
              _dateTime = time as int;
            })
      ],
    ),
  );
}

