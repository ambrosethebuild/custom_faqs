import 'package:custom_faqs/custom_faqs.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CustomFaqPage(
        title: 'Faqs',
        subtitle: 'Answers to common questions',
        link: "https://fuodz.edentech.online/api/app/faqs",
        style: CustomFaqStyle.classic,
      ),
    );
  }
}
