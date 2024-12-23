import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/sign_in_screens/sign_in.dart';
import 'package:ai_news_caster/ui/signup_screens/signup_adminitrator.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:ai_news_caster/widgets/text_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomContainer(
                width: double.infinity,
                // height: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 100,
                    ),
                    Center(
                      child: sampleText(text: 'Welcome!', fontsize: 30),
                    ),
                    Center(
                      child: sampleText(
                          text: 'Please sign up to your account',
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter username';
                                }
                                return null;
                              },
                              controller: usernameController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Username'),
                            ),
                          ),
                          CustomContainer(
                            width: 50,
                            height: 50,
                            child: const Icon(Icons.person),
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
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
                            width: 320,
                            height: 50,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              controller: passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: togglePasswordVisibility,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    button(
                      title: 'Sign Up',
                      ontap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          _auth
                              .createUserWithEmailAndPassword(
                                  email: emailController.text.toString(),
                                  password: passwordController.text.toString())
                              .then((value) async {
                            CollectionReference _information = FirebaseFirestore
                                .instance
                                .collection('UserSignUpData');
                            String userID = _information.doc().id;

                            await _information.doc(userID).set({
                              "EmailAdress": emailController.text.trim(),
                              "UserName": usernameController.text.trim(),
                              "Password": passwordController.text.trim(),
                              "userId": userID,
                              "image":""
                            });
                            methodsProvider.showSnackBar(context,
                                "Sign up successfull", SnackBarType.success);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SigninScreen(),
                                ));
                          }).onError((error, stackTrace) {
                            setState(() {
                              isLoading = false;
                            });
                            if (error is FirebaseAuthException) {
                              if (error.code == 'email-already-in-use') {
                                // Show snackbar indicating that the email is already in use
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Email is already in use. Please use a different email.'),
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              } else {
                                // Show generic error snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'An error occurred. Please try again later.'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            }
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }
                      },
                    ),
                    CustomContainer(
                        width: double.infinity,
                        height: 40,
                        alignment: Alignment.centerRight,
                        child: Textbutton(
                            title: 'Sign up as Administrator?',
                            color: const Color(0xFFBD1616),
                            ontap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupAdminitrator(),
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
                    button(
                        title: 'Sign Up with Google',
                        ontap: () {
                          methodsProvider.signInWithGoogle(context);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sampleText(
                            text: 'Already have an account?',
                            color: Colors.black),
                        Textbutton(
                            title: 'Sign in',
                            color: const Color(0xFFBD1616),
                            ontap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SigninScreen(),
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
