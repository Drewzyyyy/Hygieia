import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[100],
        backgroundBlendMode: BlendMode.dstATop,
      ),
      child: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 50,
        )
      )
    );
  }
}
