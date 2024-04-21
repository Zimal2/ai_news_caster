import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final currentPassController = new TextEditingController();
  final newPassController = new TextEditingController();
  final confirmPassController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomContainer(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
              ),
              Center(
                child: sampleText(text: 'Change your Password', fontsize: 30),
              ),
              SizedBox(
                height: 50,
              ),
              CustomContainer(
                width: double.infinity,
                height: 60,
                color: Color(0xFFD9D9D9),
                radius: BorderRadius.all(Radius.circular(10)),
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: 10,
                    // ),
                    CustomContainer(
                      width: 270,
                      height: 50,
                      child: TextFormField(
                        controller: currentPassController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Current Password'),
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
              CustomContainer(
                width: double.infinity,
                height: 60,
                color: Color(0xFFD9D9D9),
                radius: BorderRadius.all(Radius.circular(10)),
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: 10,
                    // ),
                    CustomContainer(
                      width: 270,
                      height: 50,
                      child: TextFormField(
                        controller: newPassController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'New Password'),
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
                        controller: confirmPassController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password'),
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
                height: 50,
              ),
              button(
                title: 'Change your Password',
                ontap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
