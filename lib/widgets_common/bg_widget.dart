import 'package:flutter/material.dart';

Widget bg({Widget? child}) {
  return Container(
    width: double.infinity,
    
    height: 1400,
    decoration: BoxDecoration(
      color: Colors.yellow,
      
      
    ),
    child: child,
  );
}
