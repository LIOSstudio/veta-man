import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../navigationbar.dart';
import 'settingpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

bool isTutorial = false;
String priority='';
int time=0;

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
  //tutorial? ?? ?
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targetsList = [];

  final GlobalKey key1 = GlobalKey();
  final GlobalKey key2 = GlobalKey();

  //?? ??

  void initTarget(String script, String des, GlobalKey tutorialkey) {
    print("init Target ??");
    targetsList.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: tutorialkey,
        color: Color(0xff936DFF),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      script,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom:20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              des,
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.previous();
                              },
                              icon: Icon(Icons.chevron_left),
                              iconSize: 40,
                              color: Colors.white,

                            ),
                          ],
                        )


                    ),
                  ],
                ),
              );
            },
          )
        ],
        // shape: ShapeLightFocus.Circle,
        // radius: 5,
      ),
    );}

  void showTutorial() {
    if (!isTutorial) {
      print("??? ?? show tutorial?");
      isTutorial = true;
      tutorialCoachMark = TutorialCoachMark(context,
        targets: targetsList, colorShadow: Colors.black, opacityShadow: 0.85,
        onFinish: () {
          print("finish");
        },
        onClickTarget: (target) {
          print('????? onClickTarget: $target');
        },
        onClickTargetWithTapPosition: (target, tapDetails) {
          print("???? target: $target");
          print("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
        },
        onClickOverlay: (target) {
          print('onClickOverlay: $target');
        },
        onSkip: () {
          print("skip");
        },

      )
        ..show();
    }
    else {
      print("?? ? ? ?? ??");
    }
  }



  @override
  void initState(){
    /// TODO:
    /// ??? : firebase CRUD, where
    /// https://github.com/kdjun97/tci-me-project/blob/main/lib/select_teach_learn.dart
    /// where ??? ??
    /// 1. firebase ??? ???. FirebaseAuth.instance.currentUser.uid ??? ??? ??.
    /// 2. Home Tutorial collection? uid document ? field ??(?? ?? isTutorial:false ?? ??)
    /// 3. ?? false?? showTutorial() ?? true?? ?????
    /// 4. showTutorial ???? onFinish()??, DB field ????(???? ??? true?)
    /// 4?? ???? ?? ??? : firebase update
    /// collection ?? : HomeTutorial, document ?? : ?? uid (FirebaseAuth.instance.currentUser.uid ?? ??)
    /// HomeTutorial (bool)isTutorial ??? 2? ?? ??.
    /// ?????, HomeTutorial ??? ??? false? ? ?.



    print("In initState@@@@@@@@@@@@@@@@@@@@@@@@");
    initTarget("? ?? ?????","?? ? ??? ??? ? ???",key1);
    initTarget("? ?? ?? ?? ?????","???? ?????? ????? ??? ? ???.",key2);
    Future.delayed(Duration(microseconds: 100), showTutorial);
    super.initState();
    print("???? initState@@@@@@@@@@@@@@@@@@@@@@@@");
  }


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
                      margin: EdgeInsets.only(bottom: 40, top: 10),
                      height: 56,
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
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => quotesPage()));
                          },
                          child: Hero(
                            tag: 'text',
                            child: Text(
                                "???? ???? ?? ???? ????\n?? ??? ???? ??? ???? ?? ????"),
                          ),
                        ),
                      )),
                  Container(
                    key : key2,
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
                                        /////??? ???//////
                                        //????? ???? ??? ?? ???? ??? ??? ??.
                                        if (item['priority']==1){
                                          priority = '?? ??';
                                        }else if(item['priority']==2){
                                          priority = '??';
                                        }else if(item['priority']==3){
                                          priority = '??';
                                        }else if(item['priority']==4){
                                          priority = '??';
                                        }else{
                                          priority = '?? ??';
                                        }
                                        //??? ?????? ??,???? ?
                                        ////////////////////////
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
                            key: key1,
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
      //////??? ???//////////////
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
                            child:Text(item['time'].toString()),

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
                              child:Text('      '+priority,style: TextStyle(fontSize: 15),)
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
                            child:Text('??'),
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

choiceColor(item) {
  if(item['Completion'] == false) {
    return Colors.white;
  } else {
    return Colors.grey;
  }
}

class quotesPage extends StatelessWidget {
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