// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/helpers/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_button.dart';
import '../helpers/functions.dart';
import '../widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });
  static const String id = 'SignUp Page';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? email;
  String? password;
  String? rePassword;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView(
                children: [
                  const SizedBox(height: 60),
                  Image.asset(
                      'assets/images/_b71db9ac-0965-456a-b6c6-84cc349a441d-removebg.png',
                      height: 200),
                  // const Text(
                  //   'Registeration',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6),
                    child: CustomTextField(
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'this field is required';
                        } else if (!(email.contains('@') &&
                            email.contains('.com'))) {
                          return 'invalid email';
                        } else {
                          return null;
                        }
                      },
                      hintText: 'Email',
                      keyType: TextInputType.emailAddress,
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6),
                    child: CustomTextField(
                      obscureText: true,
                      //suffixIcon: const Icon(Icons.remove_red_eye),
                      validator: (password) {
                        if (password!.isEmpty) {
                          return 'invalid password';
                        } else if (password.length < 8) {
                          return 'password is less than 8 characters';
                        } else if (!(password.contains('@') ||
                            password.contains('&') ||
                            password.contains('#') ||
                            password.contains('\$'))) {
                          return 'password must have a special character Like (@,&,#,\$)';
                        } else if (!password.contains(RegExp(r'[a-z]'))) {
                          return 'password must have atleast on character';
                        } else if (password.contains(' ')) {
                          return 'space is not allowd';
                        } else {
                          return null;
                        }
                      },
                      hintText: 'New Password',
                      keyType: TextInputType.visiblePassword,
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6),
                    child: CustomTextField(
                      obscureText: true,
                      //suffixIcon: const Icon(Icons.remove_red_eye),
                      validator: (rePassword) {
                        if (rePassword!.isEmpty) {
                          return 'this field is required';
                        } else if (rePassword != password) {
                          return 'dosn\'t match the password';
                        } else {
                          return null;
                        }
                      },
                      hintText: 'Confirm Password',
                      keyType: TextInputType.visiblePassword,
                      onChanged: (data) {
                        rePassword = data;
                      },
                    ),
                  ),
                  CustomButton(
                    buttonText: 'Sign up',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email!, password: password!);
                          showSnackBar(context, print: 'successfuly registred');
                          Navigator.pop(context);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(context,
                                print: 'the password is weak');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,
                                print: 'this account already exicts');
                          }
                        } catch (e) {
                          showSnackBar(context, print: e.toString());
                        }
                        isLoading = false;
                        setState(() {});
                      } else {}
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'already have an account ',
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
