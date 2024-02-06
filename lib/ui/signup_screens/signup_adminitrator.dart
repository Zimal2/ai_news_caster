import 'package:ai_news_caster/ui/sign_in_screens/sign_in-administrator.dart';
import 'package:ai_news_caster/ui/signup_screens/email_confirm.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:ai_news_caster/widgets/text_button.dart';
import 'package:flutter/material.dart';

class SignupAdminitrator extends StatefulWidget {
  const SignupAdminitrator({super.key});

  @override
  State<SignupAdminitrator> createState() => _SignupAdministratorState();
}

class _SignupAdministratorState extends State<SignupAdminitrator> {
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
        padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
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
                    text: 'Sign up as Administrator',
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
                        controller: usernameController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Username'),
                      ),
                    ),
                    CustomContainer(
                      width: 50,
                      height: 50,
                      child: Icon(Icons.person),
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
                        controller: institueController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Institute'),
                      ),
                    ),
                    CustomContainer(
                      width: 50,
                      height: 50,
                      child: Image.asset('lib/assests/images/institue.png'),
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
                        controller: postController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Post/Position'),
                      ),
                    ),
                    CustomContainer(
                      width: 50,
                      height: 50,
                      child: Image.asset('lib/assests/images/post.png'),
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
              SizedBox(
                height: 10,
              ),
              button(
                title: 'Next',
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmailConfirm(),
                      ));
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomContainer(
                width: double.infinity,
                height: 10,
                child: Image.asset('lib/assests/images/line.png',
                    fit: BoxFit.cover),
              ),
              SizedBox(
                height: 10,
              ),
              button(title: 'Sign Up with Google', ontap: () {}),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sampleText(
                      text: 'Already have an account?', color: Colors.black),
                  Textbutton(
                      title: "Sign in",
                      color: Color(0xFFBD1616),
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SigninAdminitrator(),
                            ));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
