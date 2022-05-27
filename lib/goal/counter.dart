import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final List<Color> colors = [
    Color(0xffb003399),
    Color(0xffb1F62C7),
    Color(0xffb7C91DB),
    Color(0xffbC6CEF8),
    Color(0xffbDCE4FF)
  ];
  final int price = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halsuitta")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ToDo').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return Container(
                  color: colors[docs[index]['priority']],
                  padding: EdgeInsets.all(8),
                  child: Text(docs[index]['Title']),
                );
              });
        },
      ),
    );
  }
}
