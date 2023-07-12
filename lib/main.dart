import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/home_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/pages/registeration_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Chat());
}

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegestrationPage.id: (context) => RegestrationPage(),
        ChatPage.id: (context) => ChatPage()
      },
      debugShowCheckedModeBanner: false,
      //home: ChatPage(),
      home: const HomePage(),
    );
  }
}
