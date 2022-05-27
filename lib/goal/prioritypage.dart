import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class priorityPage extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late var priority = 1;
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
                firestore
                    .collection('ToDo')
                    .doc('ToDoo2')
                    .update({"priority": priority});
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
        title: Text("Priority setting",
            style: TextStyle(fontSize: 20, color: Colors.black)),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 106,
              width: 323,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: const Color(0xffb936DFF),
                  width: 1,
                ),
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  height: 20,
                  child: Center(
                    child: Text("Priority"),
                  ),
                ),
                Container(
                    width: 300,
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
                            backgroundColor: const Color(0xffbFF6D6D),
                            onPressed: () {
                              priority = 1;
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
                            },
                          ),
                        ),
                      ],
                    )),
                Container(
                  width: 323,
                  height: 20,
                  child: Image.asset(
                    'assets/prio.png',
                    fit: BoxFit.contain,
                    height: 35,
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
