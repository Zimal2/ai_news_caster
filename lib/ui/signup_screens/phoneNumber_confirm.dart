import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneNumberConfirm extends StatefulWidget {
  final String verificationId;
  const PhoneNumberConfirm({super.key, required this.verificationId});

  @override
  State<PhoneNumberConfirm> createState() => _PhoneNumberConfirmState();
}

class _PhoneNumberConfirmState extends State<PhoneNumberConfirm> {
  @override
  Widget build(BuildContext context) {
    final methodProvider = Provider.of<Methods>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
        child: CustomContainer(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(
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
                    color: const Color(0xFFBD1616)),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    sampleText(
                        text:
                            'Enter a 6 didgit code sent on your PhoneNumber to verify.',
                        fontsize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter code';
                        }
                        return null;
                      },
                      controller: methodProvider.phoneCodeController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter 6 digit code',
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              button(
                  title: 'Confirm',
                  ontap: () {
                    methodProvider.confirmPhoneNumber(
                        context, widget.verificationId);
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => methodProvider.confirmPhoneNumber(
                      context, widget.verificationId),
                  child: sampleText(
                      text: "Resend code?", color: const Color(0xFFBD1616)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
