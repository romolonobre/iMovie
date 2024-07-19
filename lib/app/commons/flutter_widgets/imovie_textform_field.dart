import 'package:flutter/material.dart';

class ImovieTextformField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  const ImovieTextformField({required this.hintText, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onChanged: (value) => onChanged(value),
    );
  }
}
