import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'settingpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp()
  );
}

class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
        home: nameinput()
    );
  }
}
class nameinput extends StatefulWidget {
  @override
  State<nameinput> createState() => _nameinputState();
}

class _nameinputState extends State<nameinput> {
  final formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 35,
              )
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: Material(
            child: Center(
                child: Column(children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 40, top: 10),
                      height: 70,
                      width: 323,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: const Color(0xffb936DFF),
                          width: 1,
                        ),
                      ),
                      child: const Center(
                        child: Text("Do not try to be original"),
                      )),
                  Container(
                    child: SizedBox(
                      height: 350,
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection(user!.uid)
                                    .orderBy("priority")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  final docs = snapshot.data!.docs;
                                  final List<Color> colors = [
                                    const Color(0xffbFF6D6D),
                                    const Color(0xffbFFB36D),
                                    const Color(0xffbFFE86D),
                                    const Color(0xffb9CFF6D),
                                    const Color(0xffb6DA8FF)
                                  ];
                                  return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: docs.length,
                                      itemBuilder: (context, index) {
                                        final item = docs[index];
                                        return Slidable(
                                          key: ValueKey(index),
                                          child: buildListTile(item),
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                // An action can be bigger than the others.
                                                flex: 1,
                                                onPressed: (context) {
                                                  firestore
                                                      .collection(user!.uid)
                                                      .doc(item.id)
                                                      .update({"Completion": true});
                                                },
                                                backgroundColor: const Color(0xFF7BC043),
                                                foregroundColor: Colors.white,
                                                icon: Icons.archive,
                                                label: 'Archive',
                                              ),
                                              SlidableAction(
                                                onPressed: (context) {
                                                  firestore
                                                      .collection(user!.uid)
                                                      .doc(item.id)
                                                      .delete();
                                                },
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                icon: Icons.delete,
                                                label: 'delete',
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                              ),
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,),
                  Container(
                    height: 60,
                    child: Row(
                      children: [
                        const Expanded(flex: 5, child: Text(" ")),
                        Expanded(
                          flex: 3,
                          child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor: const Color(0xffb936DFF),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Settingpage()),
                              );
                            },
                            child: const Icon(
                              Icons.add,
                              size: 40,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),]))));
  }
  final List<Color> colors = [
    const Color(0xffbFF6D6D),
    const Color(0xffbFFB36D),
    const Color(0xffbFFE86D),
    const Color(0xffb9CFF6D),
    const Color(0xffb6DA8FF)
  ];

  Widget buildListTile(item) => ListTile(

    leading: Container(
      margin: EdgeInsets.all(10),
      width: 15,
      height: 15,
      color: colors[item['priority']-1]
    ),
    title: Text(
      item['Title'],
      style: const TextStyle(fontSize: 16),
    ),
    tileColor: choiceColor(item),
    onTap: () {
      showDialog(
          context: context,
          //barrierDismissible - Dialog? ??? ?? ?? ?? x
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              // RoundedRectangleBorder - Dialog ?? ??? ??? ??
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              //Dialog Main Title
              title: Column(
                children: <Widget>[
                  new Text("Dialog Title"),
                ],
              ),
              //
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item["Title"],
                  ),
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("??"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      });}

choiceColor(item) {
  if(item['Completion'] == false) {
    return Colors.white;
  } else {
    return Colors.grey;
  }
}


