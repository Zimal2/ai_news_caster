import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen2 extends StatefulWidget {
  const ChangePasswordScreen2({super.key});

  @override
  State<ChangePasswordScreen2> createState() => _ChangePasswordScreen2State();
}

class _ChangePasswordScreen2State extends State<ChangePasswordScreen2> {
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
                controller: methodsProvider.newPassController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'New Password',
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
                height: 10,
              ),
              TextField(
                controller: methodsProvider.confirmPassController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Confirm Password',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(Icons.phone),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              button(
                title: 'Change your Password',
                ontap: () {
                  methodsProvider.newPassController.text ==
                          methodsProvider.confirmPassController.text
                      ? methodsProvider.updatePassword(
                          methodsProvider.newPassController.text, context)
                      : methodsProvider.showSnackBar(
                          context,
                          "Password mismatch. Please try again.",
                          SnackBarType.fail);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
