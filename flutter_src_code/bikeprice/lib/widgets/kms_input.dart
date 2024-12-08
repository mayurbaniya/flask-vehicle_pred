import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class KmsInput extends StatelessWidget {
  final String value;
  final Function(String) onTap;

  KmsInput({required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: value);

    return TextField(
      controller: _controller,
      enabled: false, // Prevents editing the field
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffix: Icon(Icons.speed, color: Colors.grey, size: 22),
        hintText: 'eg: 8000Km',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        filled: true,
        fillColor: Colors.black87,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
          borderRadius: BorderRadius.circular(8.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ).pSymmetric(v: 20).onTap(() {
      onTap(value); // Call the onTap callback and pass the value
    });
  }
}
