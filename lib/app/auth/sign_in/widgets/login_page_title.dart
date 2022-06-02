import 'package:flutter/cupertino.dart';
import 'package:smart_pay/app/shared_widgets/page_title.dart';

class LoginPageTitle extends StatelessWidget {
  const LoginPageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageTitle(
      title: 'Hi There! 👋',
      description: 'Welcome back, Sign in to your account',
    );
  }
}
