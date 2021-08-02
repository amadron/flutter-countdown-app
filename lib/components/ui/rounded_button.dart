import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(this.buttonText, this.icon, this.onTap) : super();

  final Function onTap;
  final String buttonText;
  final IconData icon;

  Widget build(BuildContext context) {
    return SizedBox.fromSize(
        size: Size(60, 60),
        child: ClipOval(
          child: Material(
            color: Colors.blueAccent.shade100,
            child: InkWell(
                splashColor: Colors.blueAccent,
                onTap: () => onTap(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Icon(icon), Text(buttonText)],
                )),
          ),
        ));
  }
}
