
import 'package:flutter/material.dart';

class LabeledInput extends StatelessWidget {
  const LabeledInput({super.key, required this.label, required this.textController, this.widget});

  final String label;
  final TextEditingController textController;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.deepPurple),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          spacing: 10,
          children: [
            Text("$label:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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