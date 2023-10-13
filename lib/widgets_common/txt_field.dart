import 'package:flutter/material.dart';

Widget txtField({color, txt, brdrcolor, val, controller, validator, icon}) {
  return TextFormField(
    obscureText: val,
    controller: controller,
    decoration: InputDecoration(
      fillColor: color,
      hintText: txt,
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      border: InputBorder.none,
      filled: true,
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: brdrcolor)),
    ),
    validator: validator,
  );
}
