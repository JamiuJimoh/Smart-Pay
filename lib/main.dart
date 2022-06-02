import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/app/auth/sign_in/password_recovery_page.dart';
import 'package:smart_pay/app/auth/sign_in/sign_in_page.dart';
import 'package:smart_pay/app/onboarding/onboarding_page.dart';
import 'package:smart_pay/utils/app_theme.dart';

import 'app/auth/sign_in/widgets/auth_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
      child: MaterialApp.router(
        title: 'SmartPay',
        theme: AppTheme.light(),
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
      ),
    );
  }

  final _router = GoRouter(
    // refreshListenable: AuthProvider(),
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        name: 'signin',
        path: '/signin',
        builder: (context, state) => const SignInPage(),
        // routes: [

        // ],
      ),
      GoRoute(
        name: 'password_recovery',
        path: '/passwordRecovery',
        builder: (context, state) => const PasswordRecoveryPage(),
      ),
    ],
  );
}
