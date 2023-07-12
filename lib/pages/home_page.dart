import 'package:chat/consts.dart';
import 'package:chat/pages/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kPrimaryColor, body: Login());
  }
}
