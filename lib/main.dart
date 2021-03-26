import 'package:flutter/material.dart';
import 'package:hygieia/screens/home/home.dart';
import 'package:hygieia/screens/settings/settings.dart';
import 'package:hygieia/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hygieia/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Source());
}

class Source extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
