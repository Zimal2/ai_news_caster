import 'package:ai_news_caster/ui/change_password.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:ai_news_caster/widgets/text_button.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            CustomContainer(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.10,
              child: sampleText(
                  text: "My Profile",
                  color: Colors.black,
                  fontsize: 30,
                  textAlign: TextAlign.center),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFBD1616)),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 60,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            sampleText(
                text: "Username",
                color: Colors.black,
                textAlign: TextAlign.center,
                fontsize: 20),
            Textbutton(
                title: "Change your password",
                color: Color(0xFFBD1616),
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePassword(),
                      ));
                }),
            // CustomContainer(
            //   width: double.infinity,
            //   height: 10,
            //   child: Image.asset('assets/images/line.png', fit: BoxFit.cover),
            // ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CustomContainer(
                  width: double.infinity,
                  height: 150,
                  color: Color(0xFFFFF7F7),
                  child: Column(
                    children: [
                      CustomContainer(
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "Personal Information",
                                    color: Colors.black,
                                    fontsize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "Edit",
                                    color: Color(0xFFBD1616),
                                    fontsize: 15),
                              ),
                            ],
                          )),
                      CustomContainer(
                          width: double.infinity,
                          height: 30,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: " First Name",
                                    color: Colors.black,
                                    fontsize: 15),
                              ),
                              SizedBox(
                                width: 150,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "Jacob",
                                    color: Colors.black,
                                    fontsize: 15),
                              ),
                            ],
                          )),
                      CustomContainer(
                          width: double.infinity,
                          height: 30,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "Last Name",
                                    color: Colors.black,
                                    fontsize: 15),
                              ),
                              SizedBox(
                                width: 150,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "Fitts",
                                    color: Colors.black,
                                    fontsize: 15),
                              ),
                            ],
                          )),
                      CustomContainer(
                          width: double.infinity,
                          height: 30,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "Userame",
                                    color: Colors.black,
                                    fontsize: 15),
                              ),
                              SizedBox(
                                width: 200,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "JF",
                                    color: Colors.black,
                                    fontsize: 15),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CustomContainer(
                  width: double.infinity,
                  height: 150,
                  color: Color(0xFFFFF7F7),
                  child: Column(
                    children: [
                      CustomContainer(
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "Contact Information",
                                    color: Colors.black,
                                    fontsize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "Edit",
                                    color: Color(0xFFBD1616),
                                    fontsize: 15),
                              ),
                            ],
                          )),
                      CustomContainer(
                          width: double.infinity,
                          height: 30,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "Phone Number",
                                    color: Colors.black,
                                    fontsize: 15),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "09764689",
                                    color: Colors.black,
                                    fontsize: 15),
                              ),
                            ],
                          )),
                      CustomContainer(
                          width: double.infinity,
                          height: 30,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "Email",
                                    color: Colors.black,
                                    fontsize: 15),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: sampleText(
                                    text: "jacobfitts@gamil.com",
                                    color: Colors.black,
                                    fontsize: 15),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
            button(title: "Logout", ontap: () {})
          ],
        ),
      ),
    );
  }
}
