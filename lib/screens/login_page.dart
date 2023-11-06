import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/screens/chat_page.dart';
//import 'package:scholar_chat/screens/chat_page.dart';
// ignore: unused_import
import 'package:scholar_chat/screens/register_page.dart';
import 'package:scholar_chat/widgets/constants.dart';
import 'package:scholar_chat/widgets/costom_button.dart';
import 'package:scholar_chat/widgets/custom_text_filed.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'login page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Image.asset(
                  kLogo,
                ),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                const Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextFiled(
                  obscureText: false,
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomFormTextFiled(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          // ignore: use_build_context_synchronously
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (ex.code == 'wrong-password') {
                          // ignore: use_build_context_synchronously
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      } catch (ex) {
                        // ignore: use_build_context_synchronously
                        showSnackBar(context, 'there was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  title: 'LOGIN',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        '   Register',
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
