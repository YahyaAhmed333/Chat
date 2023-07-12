import 'package:chat/components/text_field.dart';
import 'package:chat/consts.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/registeration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Center(
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset("Assets/images/logo_transparent.png")),
              ),
              const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 30,
                      color: kComponentColor,
                      fontFamily: 'Pacifico'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: CustomTextField(
                  isOk: false,
                  onChanged: (data) {
                    email = data;
                  },
                  hintForUser: "E-mail Adress",
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: CustomTextField(
                    isOk: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintForUser: "Password"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 8),
                child: GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        // ignore: unused_local_variable
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: email!, password: password!);
                        Fluttertoast.showToast(msg: "Loged In");
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          Fluttertoast.showToast(
                              msg: 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          Fluttertoast.showToast(
                              msg: "Wrong password provided for that user.");
                        } else {
                          Fluttertoast.showToast(msg: "Unknown error");
                        }
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg:
                                "Please enter user name and passwork correctly");
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: kComponentColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    alignment: Alignment.center,
                    height: 50,
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "dosen't have an account ? ",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegestrationPage.id);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: kComponentColor, fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
