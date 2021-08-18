import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';

class CheckDialog extends StatelessWidget {
  const CheckDialog({
    Key key,
    this.title,
    this.content,
    this.pressYes,
    this.pressNo,
  }) : super(key: key);
  final String title;
  final String content;
  final GestureTapCallback pressYes;
  final GestureTapCallback pressNo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
            child:
            Text(StringConst.no),
            onPressed: pressNo),
        FlatButton(
          child: Text(StringConst.yes),
          onPressed: pressYes,

          //onPressed: pressYes,
        )
      ],
    );
  }
}
