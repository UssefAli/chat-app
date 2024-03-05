// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/sign_up_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helpers/constants.dart';
import '../helpers/functions.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const String id = 'Login Page';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passowrdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool unvisiblePassword = true;
  bool isLoading = false;
  Widget selectIcon() {
    if (unvisiblePassword == true) {
      return const Icon(Icons.visibility);
    } else {
      return Icon(Icons.visibility_off);
    }
  }

  @override
  void dispose() {
    passowrdController;
    emailController;
    super.dispose();
  }

  late String email;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 60),
                Image.asset(
                  'assets/images/_b71db9ac-0965-456a-b6c6-84cc349a441d-removebg.png',
                  height: 300,
                ),
                const SizedBox(height: 40),
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  child: CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                    keyType: TextInputType.emailAddress,
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  child: CustomTextField(
                    controller: passowrdController,
                    obscureText: unvisiblePassword,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            unvisiblePassword = !unvisiblePassword;
                          });
                        },
                        icon: selectIcon()),
                    hintText: 'password',
                    keyType: TextInputType.visiblePassword,
                    onChanged: (data) {},
                  ),
                ),
                CustomButton(
                    buttonText: 'Sign in',
                    onTap: () async {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passowrdController.text);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChatPage(email: email);
                        }));
                        passowrdController.clear();
                        emailController.clear();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, print: 'user not found');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, print: 'incorrect password');
                        } else {
                          //print(e);
                          showSnackBar(context, print: 'there is an error');
                        }
                      } catch (e) {
                        //print(e);
                        showSnackBar(context, print: 'invalid data');
                      }
                      isLoading = false;
                      setState(() {});
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an account ',
                        style: TextStyle(color: Colors.white60, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpPage.id);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
