import 'package:flutter/material.dart';
import 'package:hygieia/models/user.dart';
import 'package:hygieia/screens/authenticate/authenticate.dart';
import 'package:hygieia/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    // User not logged in
    if(user == null) return Authenticate();
    else return Home();
  }
}
