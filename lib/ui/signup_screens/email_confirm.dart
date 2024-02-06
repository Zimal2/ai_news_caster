import 'package:ai_news_caster/ui/emailconfirmation.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';

class EmailConfirm extends StatefulWidget {
  const EmailConfirm({super.key});

  @override
  State<EmailConfirm> createState() => _EmailConfirmState();
}

class _EmailConfirmState extends State<EmailConfirm> {
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
                height: 50,
              ),
              sampleText(
                  text: 'Enter a 4 didgit code sent on your email to verify',
                  fontsize: 13,
                  color: Colors.black),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CustomContainer(
                      width: 70,
                      height: 70,
                      radius: BorderRadius.circular(10),
                      color: Color(0xFFD9D9D9),
                      child: Center(
                        child: sampleText(
                            text: '0', color: Colors.black, fontsize: 20),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  CustomContainer(
                      width: 70,
                      height: 70,
                      radius: BorderRadius.circular(10),
                      color: Color(0xFFD9D9D9),
                      child: Center(
                        child: sampleText(
                            text: '0', color: Colors.black, fontsize: 20),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  CustomContainer(
                      width: 70,
                      height: 70,
                      radius: BorderRadius.circular(10),
                      color: Color(0xFFD9D9D9),
                      child: Center(
                        child: sampleText(
                            text: '0', color: Colors.black, fontsize: 20),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  CustomContainer(
                      width: 70,
                      height: 70,
                      radius: BorderRadius.circular(10),
                      color: Color(0xFFD9D9D9),
                      child: Center(
                        child: sampleText(
                            text: '0', color: Colors.black, fontsize: 20),
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              button(
                  title: 'Confirm',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailConfirmation(),
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
