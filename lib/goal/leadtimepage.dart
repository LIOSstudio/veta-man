import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_pickerr/time_pickerr.dart';

class leadtimePage extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int timee = 0;
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
              child: Text("save"),
              style: TextButton.styleFrom(
                primary: const Color(0xffb936DFF),
                backgroundColor: Colors.white,
                elevation: 1, shape: BeveledRectangleBorder(),
                padding: EdgeInsets.all(0.0),
                // minimumSize: Size(0,0)
              )),
        ],
        title: Text("Lead time setting",
            style: TextStyle(fontSize: 20, color: Colors.black)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: TextField(
              style: TextStyle(fontSize: 32, color: Colors.black),
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: 'Lead time'),
              onChanged: (value) {
                timee = int.parse(value);
                firestore
                    .collection('ToDo')
                    .doc('ToDoo2')
                    .update({"time": timee});
              },
            ),
            padding: EdgeInsets.only(left: 20),
            margin: EdgeInsets.only(top: 70, left: 40),
            width: 300,
            height: 100,
          ),
        ],
      ),
    );
  }
}
