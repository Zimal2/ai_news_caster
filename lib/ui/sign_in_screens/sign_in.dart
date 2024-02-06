import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/ui/sign_in_screens/sign_in-administrator.dart';
import 'package:ai_news_caster/ui/signup_screens/signup.dart';
import 'package:ai_news_caster/utils/flutterToast.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:ai_news_caster/widgets/text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  void login() {
    if (_formkey.currentState!.validate()) {
      _auth
          .signInWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then((value) {
        Utils().toastMessage(value.user!.email!);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ));
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomContainer(
                // width: double.infinity,
                // height: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      //  width: double.infinity,
                      height: 100,
                    ),
                    Center(
                      child: sampleText(text: 'Welcome!', fontsize: 30),
                    ),
                    Center(
                      child: sampleText(
                          text: 'Please Sign in to your account',
                          fontsize: 16,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomContainer(
                      width: double.infinity,
                      height: 60,
                      color: const Color(0xFFD9D9D9),
                      radius: const BorderRadius.all(Radius.circular(10)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          CustomContainer(
                            width: 270,
                            height: 50,
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email Address'),
                            ),
                          ),
                          CustomContainer(
                            width: 50,
                            height: 50,
                            child: const Icon(Icons.email),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomContainer(
                      width: double.infinity,
                      height: 60,
                      color: const Color(0xFFD9D9D9),
                      radius: const BorderRadius.all(Radius.circular(10)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          CustomContainer(
                            width: 270,
                            height: 50,
                            child: TextFormField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password'),
                            ),
                          ),
                          CustomContainer(
                            width: 50,
                            height: 50,
                            child: const Icon(Icons.visibility),
                          ),
                        ],
                      ),
                    ),
                    CustomContainer(
                      width: double.infinity,
                      height: 40,
                      alignment: Alignment.centerRight,
                      child: sampleText(
                          text: 'Forget Password?',
                          color: Colors.black,
                          fontsize: 12),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    button(
                      title: 'Sign in',
                      ontap: () {
                        login();
                      },
                    ),
                    CustomContainer(
                        width: double.infinity,
                        height: 40,
                        alignment: Alignment.centerRight,
                        child: Textbutton(
                            title: 'Sign in as Administrator?',
                            color: const Color(0xFFBD1616),
                            ontap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SigninAdminitrator(),
                                  ));
                            })),
                    CustomContainer(
                      width: double.infinity,
                      height: 10,
                      child: Image.asset('lib/assests/images/line.png',
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    button(title: 'Sign in with Google', ontap: () {}),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sampleText(
                            text: 'Don\'t have an account?',
                            color: Colors.black),
                        const SizedBox(
                          width: 10,
                        ),
                        Textbutton(
                            title: 'Sign up',
                            color: const Color(0xFFBD1616),
                            ontap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ));
                            })
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
