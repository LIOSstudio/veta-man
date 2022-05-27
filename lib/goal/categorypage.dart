import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class categoryPick extends StatefulWidget {
  const categoryPick({Key? key}) : super(key: key);

  @override
  State<categoryPick> createState() => _categoryPickState();
}

class _categoryPickState extends State<categoryPick> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String selected_value = "Study";
  var value_list = [
    "Study",
    "Exercise",
    "Reading",
    "Relations",
    "Hobby",
    "Job prepare"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: const Color(0xffb936DFF),
          backgroundColor: Colors.white,
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Save'),
                style: TextButton.styleFrom(
                  primary: const Color(0xffb936DFF),
                  backgroundColor: Colors.white,
                  elevation: 1, shape: BeveledRectangleBorder(),
                  padding: EdgeInsets.all(0.0),
                  // minimumSize: Size(0,0)
                )),
          ],
          title: Text("Category setting",
              style: TextStyle(fontSize: 20, color: Colors.black)),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(50),
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
                            setState(() {
                              selected_value = newValue!;
                              firestore
                                  .collection('ToDo')
                                  .doc('ToDoo2')
                                  .update({"category": selected_value});
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
