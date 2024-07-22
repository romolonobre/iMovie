import 'package:flutter/material.dart';

class ImovieTextformField extends StatefulWidget {
  final String? hintText;
  final Function(String)? onChanged;
  final bool isPasswordField;
  final String? initialValue;
  final bool isReadOnly;

  const ImovieTextformField({
    this.hintText,
    this.onChanged,
    this.initialValue,
    this.isPasswordField = false,
    this.isReadOnly = false,
    super.key,
  });

  @override
  _ImovieTextformFieldState createState() => _ImovieTextformFieldState();
}

class _ImovieTextformFieldState extends State<ImovieTextformField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      style: TextStyle(color: widget.isReadOnly ? Colors.grey.shade500 : Colors.white),
      obscureText: widget.isPasswordField ? _obscureText : false,
      readOnly: widget.isReadOnly,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        suffixIcon: suffixIcon(),
      ),
      onChanged: widget.onChanged != null ? (value) => widget.onChanged!(value) : null,
    );
  }

  Widget? suffixIcon() {
    if (widget.isPasswordField) {
      return IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.white),
          onPressed: () => setState(() => _obscureText = !_obscureText));
    }
    if (widget.isReadOnly) {
      return const Icon(Icons.lock);
    }
    return null;
  }
}
