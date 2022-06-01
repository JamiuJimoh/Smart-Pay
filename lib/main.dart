import 'package:flutter/material.dart';
import 'package:smart_pay/app/onboarding/onboarding_page.dart';
import 'package:smart_pay/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light(),
      home: OnboardingPage(),
    );
  }
}
