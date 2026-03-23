import 'package:flutter/material.dart';

class RollButton extends StatelessWidget {
  const RollButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            fixedSize: Size(200, 50)),
        onPressed: onPressed,
        child: SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Center(
                  child: Text(
                "Roll",
                style: TextStyle(color: Colors.white, fontSize: 30),
              )),
            )));
  }
}
