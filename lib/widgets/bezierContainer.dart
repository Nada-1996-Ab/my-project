import 'dart:math';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
class BackOpcity extends StatelessWidget {
  const BackOpcity({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Opacity(
        opacity: .6,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.primaryTwo.withOpacity(.8), AppColors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.mirror,
                stops: [.5, 6]),
          ),
        ),
      ),
    );
  }
}