import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/sign_in_screens/forget_password_admin.dart';
import 'package:ai_news_caster/ui/sign_in_screens/sign_in.dart';
import 'package:ai_news_caster/ui/signup_screens/signup_adminitrator.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:ai_news_caster/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninAdminitrator extends StatefulWidget {
  const SigninAdminitrator({super.key});

  @override
  State<SigninAdminitrator> createState() => _SigninAdministratorState();
}

class _SigninAdministratorState extends State<SigninAdminitrator> {
  final _signInAdminformkey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  // @override
  // void dispose() {
  //   // Dispose text controllers to clear their values
  //   Provider.of<Methods>(context, listen: false).phoneControllerSignin.dispose();
  //   Provider.of<Methods>(context, listen: false).passwordControllerSignin.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _signInAdminformkey,
            child: Padding(
              padding: const EdgeInsets.only(top: 55, left: 10, right: 10),
              child: CustomContainer(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 30,
                    ),
                    Center(
                      child: sampleText(text: 'Welcome!', fontsize: 30),
                    ),
                    Center(
                      child: sampleText(
                          text: 'Sign in as Administrator',
                          fontsize: 16,
                          color: const Color(0xFFBD1616)),
                    ),
                    const SizedBox(
                      height: 30,
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
                                  return 'Please enter phone number';
                                }
                                return null;
                              },
                              controller: methodsProvider.phoneControllerSignin,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: " Enter Phone Number"),
                            ),
                          ),
                          CustomContainer(
                            width: 50,
                            height: 50,
                            child: const Icon(Icons.phone),
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
                              controller:
                                  methodsProvider.passwordControllerSignin,
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
                    CustomContainer(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPasswordAdmin(),
                          )),
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
                    Center(
                      child: button(
                        loading: methodsProvider.loading,
                        title: 'Sign in as Administrator',
                        ontap: () {
                          if (_signInAdminformkey.currentState!.validate()) {
                            methodsProvider.signinA(context);
                          }
                        },
                      ),
                    ),
                    CustomContainer(
                        width: double.infinity,
                        height: 40,
                        alignment: Alignment.centerRight,
                        child: Textbutton(
                            title: 'Sign in as User?',
                            color: const Color(0xFFBD1616),
                            ontap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SigninScreen(),
                                  ));
                            })),
                    CustomContainer(
                      width: double.infinity,
                      height: 10,
                      child: Image.asset('lib/assests/images/line.png',
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Center(
                    //   child: button(
                    //       title: 'Sign in with Google',
                    //       ontap: () {
                    //         methodsProvider.signInWithGoogle(context);
                    //       }),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          sampleText(
                              text: 'Don\'t have an account?',
                              color: Colors.black),
                          Textbutton(
                            title: 'Sign up',
                            color: const Color(0xFFBD1616),
                            ontap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupAdminitrator(),
                                  ));
                            },
                          )
                        ],
                      ),
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
