
import 'package:flutter/material.dart';

class LabeledInput extends StatelessWidget {
  const LabeledInput({super.key, required this.label, required this.textController, this.widget, required this.icon, required this.color});

  final String label;
  final TextEditingController textController;
  final Widget? widget;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 2, color: color),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          spacing: 10,
          children: [
            Icon(icon, color: color),
            Text("$label:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                controller: textController,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null ) {
                    return "Needs to be a number";
                  }
                  return null;
                },
              ),
            ),
            if (widget != null)
              widget!
          ],
        ),
      ),
    );
  }

}