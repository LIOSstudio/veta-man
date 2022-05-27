import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../goal/py1.dart';
import 'login.dart';
import 'register.dart';

class SocialLogin extends StatelessWidget {
  // const SocialLogin({Key key}) : super(key: key);
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential`
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo_2.png', width: 200, height: 200),
            //구글 로그인
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: OutlinedButton(
                  onPressed: () {
                    signInWithGoogle();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => nameinput()));
                  },
                  // onPressed: signInWithGoogle,

                  style: TextButton.styleFrom(
                    side: BorderSide(color: Color(0xff222222)),
                    primary: Colors.white,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('구글로 시작하기',
                      style: TextStyle(
                          color: Color(0xff222222),
                          fontSize: 15,
                          fontFamily: 'NotoSansKR'))),
            ),
            SizedBox(
              height: 50,
            ),

            SizedBox(
              height: 30,
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                      child: Text('이메일로 회원가입')),
                  Container(
                    height: 50,
                    child: VerticalDivider(
                        color: Colors.grey[300], thickness: 1.0),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text('이메일로 로그인')),
                ],
              ),
            ),

            //카카오 로그인
            // TextButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => RegisterPage()));
            //       },
            //     style: TextButton.styleFrom(
            //       primary: Colors.yellow,
            //       backgroundColor: Colors.black,
            //     ),
            //     child: Text('카카오로 로그인하기'),
            // ),
            //이메일 로그인
          ],
        ),
      ),
    );
  }
}
