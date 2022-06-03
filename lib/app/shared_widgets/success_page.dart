import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/auth_provider.dart';
import 'package:smart_pay/app/shared_widgets/custom_elevated_button.dart';
import 'package:smart_pay/utils/constants.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: commonPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32.0),
                  Image.asset('assets/images/world.png'),
                  const SizedBox(height: 56.33),
                  Text(
                    'Congratulations',
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Hey ${authProvider.fullName}, your account has been successfully created 👋 ',
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            CustomElevatedButton(
              text: 'Proceed to home',
              isLoading: authProvider.isLoading,
              onPressed: () => context.goNamed('home'),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> goAhead(BuildContext context) async {
  //   final authProvider = context.read<AuthProvider>();
  //   try {
  //     await authProvider.dashboard();
  //     // if (authProvider.token.isNotEmpty) {
  //     // ignore: use_build_context_synchronously
  //     context.goNamed('home');
  //     // }
  //   } on CustomHttpException catch (e) {
  //   } catch (e) {}
  // }
}
