// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:chat/consts.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.hintForUser, required this.onChanged, required this.isOk});
  String? hintForUser;
  Function(String)? onChanged;
  bool? isOk;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isOk!,
      validator: (value) {
        if (value!.isEmpty) {
          return "Field is required";
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          labelText: hintForUser,
          hintText: hintForUser,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kComponentColor)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: kComponentColor))),
    );
  }
}
