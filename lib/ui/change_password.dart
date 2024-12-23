import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/signup_screens/change_password_screen2.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final currentPassController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);

    return Scaffold(
      appBar: AppBar(
        title: sampleText(text: 'Change your Password', fontsize: 22),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: CustomContainer(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: currentPassController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Current Password',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(Icons.key),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              button(
                title: 'Next',
                ontap: () {
                  if (currentPassController.text == methodsProvider.loginPass) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen2(),
                      ),
                    );
                  } else {
                    methodsProvider.showSnackBar(context,
                        "Wrong password. Please try again.", SnackBarType.fail);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
