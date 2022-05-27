import 'package:flutter/material.dart';

import 'counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stream Builder",
      theme: ThemeData(primaryColor: Colors.blue),
      home: Counter(),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class listView extends StatelessWidget {
  const listView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("Halsuitta")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Container(
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('ToDo').snapshots(),
                  builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final messages =snapshot.data;
                  List<Text> messageWidgets =[];
                    final messageText =messages.docs["Title"];
                    final messageSender=messages["priority"];
                    final messageWidget =
                        Text('$messageText from $messageSender');
                    messageWidgets.add(messageWidget);
                  return Column(
                    children: messageWidgets,
                  );


                  })
            ],
          ),
    ),
    ],),);
  }
}






void messagesStream() async {
  await for (var snapshot in FirebaseFirestore.instance.collection('ToDo').snapshots()){
    for (var message in snapshot.docs) {
      print(message.data);
    }
  }
}
*/
