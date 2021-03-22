import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hygieia/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: Container(
          padding: EdgeInsets.fromLTRB(50, 15, 103, 10),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/AuthScreen/bg1.jpg"),
                fit: BoxFit.cover,
              )
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text(
              'Welcome to',
              style: GoogleFonts.montserrat(
                fontSize:  35,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                // letterSpacing: 2,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              'Hygieia',
              style: GoogleFonts.montserrat(
                fontSize:  35,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,

            ),
            OutlinedButton(
              child: Text('Sign in anonymously', textAlign: TextAlign.left,),
                onPressed: () async{
                  dynamic res = await _auth.signInAnon();
                  if(res == null){
                    print('Bad Login');
                  }
                  else{
                    print('Signed in');
                    print(res.uid);
                  }
                }
            ),
          ],
        ),
        // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        // child: TextButton(
        //   child: Text('Sign in Anonymously'),
        //   onPressed: () async{
        //
        //   },
        // )
      ),
    );
  }
}
