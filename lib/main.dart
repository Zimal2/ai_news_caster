import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/sign_in_screens/sign_in-administrator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Methods(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        const SigninAdminitrator(),
      ),
    );
  }
}
