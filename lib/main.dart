import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/app/auth/country/country_page.dart';
import 'package:smart_pay/app/auth/pin/pin_code_page.dart';
import 'package:smart_pay/app/auth/pin/set_pin_page.dart';
import 'package:smart_pay/app/auth/sign_in/create_password_page.dart';
import 'package:smart_pay/app/auth/sign_in/password_recovery_page.dart';
import 'package:smart_pay/app/auth/sign_in/sign_in_page.dart';
import 'package:smart_pay/app/home_page.dart';
import 'package:smart_pay/app/onboarding/onboarding_page.dart';
import 'package:smart_pay/app/shared_widgets/success_page.dart';
import 'package:smart_pay/repos/auth.dart';
import 'package:smart_pay/utils/app_theme.dart';

import 'app/auth/sign_in/widgets/auth_provider.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBase>(
          create: (context) => AuthRepo(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) =>
              AuthProvider(auth: Provider.of<AuthBase>(listen: false, context)),
        ),
      ],
      child: MaterialApp.router(
        title: 'SmartPay',
        theme: AppTheme.light(),
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
      ),
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        name: 'onboarding',
        path: '/',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: 'signin',
        path: '/signin',
        builder: (context, state) => SignInPage(),
      ),
      GoRoute(
        name: 'password_recovery',
        path: '/passwordRecovery',
        builder: (context, state) => const PasswordRecoveryPage(),
      ),
      GoRoute(
        name: 'pin_page',
        path: '/pinPage',
        builder: (context, state) => const PINCodePage(),
      ),
      GoRoute(
        name: 'country_page',
        path: '/country',
        builder: (context, state) => const CountryPage(),
      ),
      GoRoute(
        name: 'set_pin_page',
        path: '/setPin',
        builder: (context, state) => const SetPINCodePage(),
      ),
      GoRoute(
        name: 'new_password_page',
        path: '/newPasswordPage',
        builder: (context, state) => const CreateNewPasswordPage(),
      ),
      GoRoute(
        name: 'success_page',
        path: '/successPage',
        builder: (context, state) => const SuccessPage(),
      ),
    ],
  );
}
