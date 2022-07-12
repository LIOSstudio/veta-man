import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../navigationbar.dart';
import 'settingpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


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
        home: MainPage()
    );
  }
}
class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}
//?????
class _MainPageState extends State<MainPage> {
  final formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(//? ?
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start, //? ? ??
            children: [
              Image.asset( //?? ???
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
                  Container( //?? ??
                      margin: EdgeInsets.only(bottom: 40, top: 10),
                      height: 56,
                      width: 323,
                      decoration: BoxDecoration( //?? ?? ???
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: const Color(0xffb936DFF),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () { //?? ?? ?? ? ???? ??
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => quotesPage()));
                          },
                          child: Hero(
                            tag: 'text',
                            child: Text(
                                'Good'),
                          ),
                        ),
                      )),
                  Container(
                    child: SizedBox( //?????
                      height: 350,
                      child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection(user!.uid)
                                      .orderBy("priority")
                                      .snapshots(), //priority ??? ?? ???? uid? ?? ??? ????
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) { //?? ??? ???? ??? ??? ?? ???
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    final docs = snapshot.data!.docs; //uid?? ??? ???
                                    return ListView.builder( //?? ???? ??
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: docs.length,
                                        itemBuilder: (context, index) {
                                          final item = docs[index]; //???? ???? ???
                                          return Slidable(
                                            key: ValueKey(index),
                                            child: buildListTile(item), //?? ??? ?? ????
                                            endActionPane: ActionPane( //??, ?? ?? ???
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction( //Archive ??
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
                                                SlidableAction( //?? ??
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
                            ),
                          )),
                    ),
                  ),
                  Container( //?? ??? ? ?? ?? ? + ??
                    height: 60,
                    child: Row(
                      children: [
                        const Expanded(flex: 5, child: Text(" ")), //??
                        Expanded( //+ ??
                          flex: 3,
                          child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor: const Color(0xffb936DFF),
                            onPressed: () { // + ?? ??? ?? ???? ??
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
  //???? ?? ???
  final List<Color> colors = [
    const Color(0xffbFF6D6D),
    const Color(0xffbFFB36D),
    const Color(0xffbFFE86D),
    const Color(0xffb9CFF6D),
    const Color(0xffb6DA8FF)
  ];

  //?? ??? ?? ?? ????? ??
  Widget buildListTile(item) => ListTile(

    leading: Container( //?? ?? ????? ?? ??
      margin: EdgeInsets.all(10),
      width: 15,
      height: 15,
      color: colors[item['priority']-1]
    ),
    title: Text( //? ?? ??
      item['Title'],
      style: const TextStyle(fontSize: 16),
    ),
    tileColor: choiceColor(item),
    onTap: () {
      //???? ??? ? ?? ???
      showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (BuildContext context) {

          return Container(
            height: 800,
            child: Column(
              children: <Widget>[
                Row(
                  children: [

                    Expanded(child: Container(
                      child:Row(
                        children:[
                          Padding(
                            padding:EdgeInsets.only(left:20),
                            child: Text(item['Title'],style: TextStyle(fontSize: 20)), //??
                          ),
                        ],
                      ),
                    )),
                    IconButton(
                      icon: Icon(Icons.close_rounded, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),

                  ],
                ),
                const Divider(
                  height: 20,
                  color: Colors.black,
                  thickness: 0.5,
                ),
                Padding(padding:EdgeInsets.only(left: 30.0,right: 10.0),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:[
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: Color(0xffb936DFF),
                              ),
                              Text('  Lead time',style: TextStyle(fontSize: 20),)
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child:Text('      '+item['time'].toString()),

                          ),//LEAD TIME???
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children:[
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: Color(0xffb936DFF),
                              ),
                              Text('  Importance',style: TextStyle(fontSize: 20),),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child:Text('      '+item['priority'].toString(),style: TextStyle(fontSize: 15),)
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children:[
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: Color(0xffb936DFF),
                              ),
                              Text('  Category',style: TextStyle(fontSize: 20),),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child:Text('      '+item['category'],style: TextStyle(fontSize: 15))

                          ),//?????


                        ],

                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Column(

                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(

                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(primary: Color(0xff936DFF),
                                shape: RoundedRectangleBorder(
                                  // shape : ??? ??? ??? ?? ??

                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                                elevation: 0.0),
                            child:Text('Confirm'),
                          ),
                        ],
                      ),






                    ],

                  ),
                ),
              ],
            ),
          );
        },
      ).then((value) { setState(() { }); });
    },);}


choiceColor(item) { //?? ?? ??? ?? ?? ???? ??? ?? ??
  if(item['Completion'] == false) {
    return Colors.white;
  } else {
    return Colors.grey;
  }
}

class quotesPage extends StatelessWidget { //?? ?? ??? ? ?? ???
  const quotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationPage()),
                  );
                },
                child: Hero(
                    tag: 'image',
                    child: Image.asset(
                      'assets/hahyul.jpeg',
                      width: 1080,
                      height: 2340,
                    )))));
  }
}