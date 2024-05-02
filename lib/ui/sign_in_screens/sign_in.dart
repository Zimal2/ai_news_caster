import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/ui/sign_in_screens/forget_password.dart';
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
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
<<<<<<< Updated upstream
=======
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void login() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _auth
          .signInWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        Utils().toastMessage(value.user!.email!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        // Handle sign-in errors
        String errorMessage = "Sign-in failed: ";
        if (error is FirebaseAuthException) {
          if (error.code == 'user-not-found') {
            errorMessage += 'No user found with this email.';
          } else if (error.code == 'wrong-password') {
            errorMessage += 'Wrong password provided for this user.';
          } else {
            errorMessage += error.message ?? "Unknown error";
          }
        } else {
          errorMessage += error.toString();
        }
        Utils().toastMessage(errorMessage);
      });
    }
  }

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: methodsProvider.formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomContainer(
                child: Column(
                  children: [
<<<<<<< Updated upstream
                    const SizedBox(
                      height: 100,
                    ),
=======
                    const SizedBox(height: 100),
>>>>>>> Stashed changes
                    Center(
                      child: sampleText(text: 'Welcome!', fontsize: 30),
                    ),
                    Center(
                      child: sampleText(
                          text: 'Please Sign in to your account',
                          fontsize: 16,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    CustomContainer(
                      width: double.infinity,
                      height: 60,
                      color: const Color(0xFFD9D9D9),
                      radius: const BorderRadius.all(Radius.circular(10)),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
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
                              controller: methodsProvider.emailController,
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
                    const SizedBox(height: 10),
                    CustomContainer(
                      width: double.infinity,
                      height: 60,
                      color: const Color(0xFFD9D9D9),
                      radius: const BorderRadius.all(Radius.circular(10)),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
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
<<<<<<< Updated upstream
                              controller: methodsProvider.passwordController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password'),
=======
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
>>>>>>> Stashed changes
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomContainer(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPassword(),
                          )),
                      width: double.infinity,
                      height: 40,
                      alignment: Alignment.centerRight,
                      child: sampleText(
                          text: 'Forget Password?',
                          color: Colors.black,
                          fontsize: 12),
                    ),
                    const SizedBox(height: 30),
                    button(
<<<<<<< Updated upstream
                      title: 'Sign in',
                      ontap: () {
                        methodsProvider.login(context);
                      },
                    ),
=======
                            loading: _isLoading,
                            title: 'Sign in',
                            ontap: () {
                                login();
                            },
                          ),
>>>>>>> Stashed changes
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
                    const SizedBox(height: 30),
                    button(
                        title: 'Sign in with Google',
                        ontap: () {
                          methodsProvider.signInWithGoogle(context);
                        }),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sampleText(
                            text: 'Don\'t have an account?',
                            color: Colors.black),
                        const SizedBox(width: 10),
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
