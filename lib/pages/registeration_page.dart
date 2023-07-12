import 'package:chat/components/text_field.dart';
import 'package:chat/consts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegestrationPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  RegestrationPage({super.key});
  static const id = "regestration_page";

  @override
  State<RegestrationPage> createState() => _RegestrationPageState();
}

class _RegestrationPageState extends State<RegestrationPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: const Text("Regestration Page"),
          backgroundColor: kComponentColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset("Assets/images/logo_transparent.png")),
                  const Text(
                    "Regestration",
                    style: TextStyle(
                        fontSize: 20,
                        color: kComponentColor,
                        fontFamily: 'Pacifico'),
                  ),
                  SizedBox(
                    height: 220,
                    child: ListView(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                        //   child: CustomTextField(
                        //     hintForUser: "First Name",
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        //   child: CustomTextField(
                        //     hintForUser: "Last Name",
                        //   ),
                        // ),
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 0),
                                  child: CustomTextField(
                                    isOk: false,
                                    hintForUser: "E-mail Adress",
                                    onChanged: (data) {
                                      email = data;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 0),
                                  child: CustomTextField(
                                    isOk: true,
                                    hintForUser: "Password",
                                    onChanged: (data) {
                                      password = data;
                                    },
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                    child: GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            // ignore: unused_local_variable
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: email!, password: password!);
                            Fluttertoast.showToast(
                                msg: "Registered Successfully");
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              Fluttertoast.showToast(
                                  msg: "The password provided is too weak.");
                            } else if (e.code == 'email-already-in-use') {
                              Fluttertoast.showToast(
                                  msg: "The account already exists");
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
                          "Sign Up",
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
                        "Already have an account ? ",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign In",
                          style:
                              TextStyle(color: kComponentColor, fontSize: 16),
                        ),
                      )
                    ],
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
