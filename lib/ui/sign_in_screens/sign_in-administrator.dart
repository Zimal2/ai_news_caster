import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/ui/signup_screens/signup_adminitrator.dart';
import 'package:ai_news_caster/ui/uploadnews.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:ai_news_caster/widgets/text_button.dart';
import 'package:flutter/material.dart';

class SigninAdminitrator extends StatefulWidget {
  const SigninAdminitrator({super.key});

  @override
  State<SigninAdminitrator> createState() => _SigninAdministratorState();
}

class _SigninAdministratorState extends State<SigninAdminitrator> {
  final usernameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final institueController = new TextEditingController();
  final postController = new TextEditingController();
  final phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 55, left: 10, right: 10),
        child: CustomContainer(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
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
                    color: Color(0xFFBD1616)),
              ),
              SizedBox(
                height: 30,
              ),
              CustomContainer(
                width: double.infinity,
                height: 60,
                color: Color(0xFFD9D9D9),
                radius: BorderRadius.all(Radius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CustomContainer(
                      width: 270,
                      height: 50,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email Address'),
                      ),
                    ),
                    CustomContainer(
                      width: 50,
                      height: 50,
                      child: Icon(Icons.email),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomContainer(
                width: double.infinity,
                height: 60,
                color: Color(0xFFD9D9D9),
                radius: BorderRadius.all(Radius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CustomContainer(
                      width: 270,
                      height: 50,
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Phone Number'),
                      ),
                    ),
                    CustomContainer(
                      width: 50,
                      height: 50,
                      child: Icon(Icons.phone),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomContainer(
                width: double.infinity,
                height: 60,
                color: Color(0xFFD9D9D9),
                radius: BorderRadius.all(Radius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CustomContainer(
                      width: 270,
                      height: 50,
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Password'),
                      ),
                    ),
                    CustomContainer(
                      width: 50,
                      height: 50,
                      child: Icon(Icons.visibility),
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
              SizedBox(
                height: 30,
              ),
              button(
                title: 'Sign in as Administrator',
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadNews(),
                      ));
                },
              ),
              SizedBox(
                height: 5,
              ),
              CustomContainer(
                width: double.infinity,
                height: 10,
                child: Image.asset('lib/assests/images/line.png',
                    fit: BoxFit.cover),
              ),
              SizedBox(
                height: 30,
              ),
              button(title: 'Sign in with Google', ontap: () {}),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sampleText(
                      text: 'Don\'t have an account?', color: Colors.black),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Textbutton(
                    title: 'Sign up',
                    color: Color(0xFFBD1616),
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupAdminitrator(),
                          ));
                    },
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
