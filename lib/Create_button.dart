import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  CreateButton({Key? key, this.color, this.colorText, this.text, this.action})
      : super(key: key);
  Color? color;
  String? text;
  Color? colorText;
  VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: GestureDetector(
        onTap: action,
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
            )
          ], color: color, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              text!,
              style: TextStyle(
                  color: colorText, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
