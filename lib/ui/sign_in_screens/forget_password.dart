import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

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
                TextField(
                  
                  controller: methodsProvider.emailController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Email',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: button(
                    title: 'Next',
                    ontap: () => methodsProvider.validateForm(
                        context, methodsProvider.emailController),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
