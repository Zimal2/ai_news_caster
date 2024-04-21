import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordAdmin extends StatelessWidget {
  ForgetPasswordAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Change your password'),
        ),
        body: Form(
          key: methodsProvider.forgetFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 8),
                // TextField(
                //   controller: methodsProvider.newPassForgetController,
                //   decoration: InputDecoration(
                //     filled: true,
                //     fillColor: Colors.grey[200],
                //     hintText: 'New Password',
                //     contentPadding:
                //         EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //       borderSide: BorderSide.none,
                //     ),
                //     suffixIcon: const Icon(Icons.visibility),
                //   ),
                // ),
                // const SizedBox(height: 16),
                TextField(
                  controller: methodsProvider
                      .PhoneNumberForgetPassPhoneNumberController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Phone number',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller:
                      methodsProvider.PassForgetPassPhoneNumberController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Password',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.visibility),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: button(
                    title: 'Update Password',
                    ontap: () => methodsProvider.forgetPasswordAdmin(context),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
