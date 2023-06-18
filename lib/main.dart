import 'package:flutter/material.dart';
import 'package:sherpa_translator/env/env.dart';
import 'package:sherpa_translator/widgets/translation_form.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sherpa Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TranslatorScreen(),
    );
  }
}

class TranslatorScreen extends StatelessWidget {
  TranslatorScreen({Key? key}) : super(key: key);

  final String title = Env.appName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: TranslationForm(),
      ),
    );
  }
}
