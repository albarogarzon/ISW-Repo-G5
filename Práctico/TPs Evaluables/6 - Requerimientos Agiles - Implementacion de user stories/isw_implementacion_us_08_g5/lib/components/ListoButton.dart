import 'package:flutter/material.dart';
import 'package:isw_implementacion_us_08_g5/resources/Strings.dart';

class ListoButton extends StatelessWidget {
  final VoidCallback onPressed;

  ListoButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: RaisedButton(
        color: Color(0xffA42B36),
        onPressed: onPressed == null ? null : onPressed,
        child: Text(Strings.LISTO,
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}
