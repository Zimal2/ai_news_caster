import 'package:ai_news_caster/ui/sign_in_screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/change_password.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:ai_news_caster/widgets/text_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    final methodsProvider = Provider.of<Methods>(context, listen: false);
    methodsProvider.fetchUserProfileImage();

    methodsProvider
        .fetchUserProfileImage()
        .then((value) => methodsProvider.imageurl);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child:  Column(
          children: [
            SizedBox(
              height: 20,
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
            FutureBuilder(
              future: methodsProvider.fetchUserProfileImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Icon(Icons.error);
                } else {
                  var data = snapshot.data;
                  print("data check:$data");
                  if (data != null) {
                    return Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: data['image'] == ""
                                ? Icon(Icons.person,size: 60,)
                                : Image.network(
                                    data['image'],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            methodsProvider.pickProfileImage(context);
                          },
                          child: sampleText(
                              text: "Upload Picture",
                              color: Colors.black,
                              textAlign: TextAlign.center,
                              fontsize: 15),
                        ),
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
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CustomContainer(
                            width: double.infinity,
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: sampleText(
                                    text: "Username",
                                    color: Colors.black,
                                    fontsize: 15,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: sampleText(
                                    text: data['UserName'],
                                    color: Colors.black,
                                    fontsize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: sampleText(
                                                text: "Email",
                                                color: Colors.black,
                                                fontsize: 15),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: sampleText(
                                                text: methodsProvider
                                                        .loginEmail ??
                                                    "",
                                                color: Colors.black,
                                                fontsize: 15),
                                          ),
                                        ],
                                      )),
                                  CustomContainer(
                                      width: double.infinity,
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: sampleText(
                                                text: "Password",
                                                color: Colors.black,
                                                fontsize: 15),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: sampleText(
                                                text: data['Password'] ?? "",
                                                color: Colors.black,
                                                fontsize: 15),
                                          ),
                                        ],
                                      )),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                        ),
                        button(
                            title: "Logout",
                            ontap: () async {
                              await GoogleSignIn().signOut();
                              FirebaseAuth.instance.signOut();

                              methodsProvider.showSnackBar(context,
                                  "Logout Sucessfully", SnackBarType.success);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SigninScreen()),
                              );
                            })
                      ],
                    );
                  } else {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFBD1616),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 60,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
    
   ) );
  }
}
