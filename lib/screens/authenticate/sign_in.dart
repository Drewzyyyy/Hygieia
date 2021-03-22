import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hygieia/services/auth.dart';
import 'package:hygieia/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // For Logging in
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // Will the password be visible
  bool _passVisible = true;

  // Change the state of password visibility
  void _hidePass(){
    setState(() {
      _passVisible = !_passVisible;
    });
  }

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/AuthScreen/bg1.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                )
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(50, 5, 50, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 80),
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
                SizedBox(height: 20),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (val) => val.isEmpty ? "Please enter valid email": null,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                              labelStyle: TextStyle(
                                  decorationColor: Colors.white
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    style: BorderStyle.solid
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    style: BorderStyle.solid
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid
                                ),
                              ),
                              suffixIcon: Icon(Icons.email_outlined,color: Colors.white)
                          ),
                          onChanged: (val) {
                            setState(()=> email = val);
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: _passVisible,
                          validator: (val) => val.length < 6 ? "Password must be 6+ characters": null,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                            labelStyle: TextStyle(
                                decorationColor: Colors.white
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid
                              ),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red,
                                  style: BorderStyle.solid
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility_outlined),
                              color: Colors.white,
                              onPressed: _hidePass,
                            ),
                          ),
                          onChanged: (val) {
                            setState(()=> password = val);
                          },
                        ),
                        SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () async {
                            if(_formkey.currentState.validate()){
                              setState(() => loading = true);
                              dynamic result = await _auth.signInWithEmailAndPass(email, password);
                              if(result==null){
                                setState(() {
                                  error = "Invalid email and/or password";
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Text(
                            "LOGIN",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )
                              ),
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              minimumSize: MaterialStateProperty.all(Size(500 , 40))
                          ),
                        ),
                        Text(
                          error,
                          style: GoogleFonts.montserrat(
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 200),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                      onPressed: ()=>widget.toggleView(),
                      child: Text(
                        "Don't have an account? Sign Up",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}