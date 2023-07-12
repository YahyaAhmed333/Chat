import 'package:chat/components/chat_bubble.dart';
import 'package:chat/consts.dart';
import 'package:chat/models/message.dart';
import 'package:chat/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});
  static String id = "ChatPage";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  TextEditingController controller = TextEditingController();
  Future sendMessage(String data, String email) async {
    messages.add({kMessage: data, kCreatedAt: DateTime.now(), "id": email});
    controller.clear();
    _controller.animateTo(_controller.position.minScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message>? messagesList = [];
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: AppBar(
              backgroundColor: const Color(0xffcccccc),
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 70,
                  ),
                  const Text(
                    "Chat App",
                    style: TextStyle(color: kComponentColor),
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: ChatBubble(
                                message: messagesList[index],
                              ))
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: ChatBubbleForFriend(
                                message: messagesList[index],
                              ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) async {
                      await sendMessage(data, email as String);
                    },
                    decoration: InputDecoration(
                      hintText: "Send Message",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kComponentColor)),
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          await sendMessage(controller.text, email as String);
                        },
                        child: const Icon(
                          Icons.send,
                          color: kComponentColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Scaffold(
              backgroundColor: kPrimaryColor,
              appBar: AppBar(
                backgroundColor: const Color(0xffcccccc),
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 70,
                    ),
                    const Text(
                      "Chat App",
                      style: TextStyle(color: kComponentColor),
                    )
                  ],
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Loading",
                        style: TextStyle(fontSize: 30, color: kComponentColor),
                      ),
                    ),
                    LoadingAnimationWidget.inkDrop(
                      color: kComponentColor,
                      size: 50,
                    ),
                  ],
                ),
              ));
        }
      },
    );
  }
}
