import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/profile.dart';
import 'package:ai_news_caster/ui/sign_in_screens/sign_in.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/dialog_box.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);
    return CustomContainer(
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          CustomContainer(
              onTap: () {
                methodsProvider.getSharedPref();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
              width: 50,
              height: 50,
              child: const Icon(Icons.menu)),
          const SizedBox(
            width: 35,
          ),
          CustomContainer(
            width: 200,
            height: 130,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                CustomContainer(
                    width: 150,
                    height: 30,
                    child: sampleText(
                        text: 'ANCHOR AI',
                        color: const Color(0xFFBD1616),
                        textAlign: TextAlign.center,
                        fontsize: 20)),
                CustomContainer(
                    width: 200,
                    height: 30,
                    child: sampleText(
                        text: 'Smart News Broadcasting Platform',
                        color: Colors.black,
                        textAlign: TextAlign.center,
                        fontsize: 11)),
              ],
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          GestureDetector(
            onTap: () {
              DialogBox.showLogoutDialog(
                context: context,
                color: Colors.white,
                heading: 'Logout',
                text: 'Do you want to logout of our account?',
                button1text: 'No',
                button1color: Colors.black,
                button1onTap: () {
                  Navigator.of(context).pop();
                },
                button2text: 'Yes',
                button2color: Colors.red,
                button2onTap: () async {
                  await GoogleSignIn().signOut();
                  FirebaseAuth.instance.signOut();

                  methodsProvider.showSnackBar(
                      context, "Logout Sucessfully", SnackBarType.success);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SigninScreen()),
                  );
                },
              );
            },
            child: CustomContainer(
              // onTap: () async {
              //   await GoogleSignIn().signOut();
              //   FirebaseAuth.instance.signOut();
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => SigninScreen()));
              // },
              width: 50,
              height: 50,
              child: const Icon(Icons.power_settings_new_outlined),
            ),
          )
        ],
      ),
    );
  }
}
