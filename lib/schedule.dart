import 'package:flutter/material.dart';

void main() {
  runApp(schedulePage());
}

class schedulePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'mypage',
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {

  // This widget is the root of your application.
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
        child: Column(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
                radius: 30.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('Name'),

            SizedBox(
              height: 20.0,
            ),
            OutlinedButton( onPressed: () { print('User');}, child: Text("user",style: TextStyle(color: Color(0xff222222)),),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(
              color: Colors.grey[300],
            ),

          ],
        ),
      ),

    );
  }
}