import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/utils/color_scheme.dart';
import 'package:smart_pay/utils/constants.dart';

import 'auth/sign_in/widgets/auth_provider.dart';
import 'shared_widgets/http_exception.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: FutureBuilder<String>(
          future: context.watch<AuthProvider>().dashboard(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.black));
            }
            if (snapshot.hasData) {
              final text = snapshot.data!;
              return Padding(
                padding: commonPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              Center(
                  child: Text(
                'Oops! An error occurred',
                style: Theme.of(context).textTheme.headline1,
              ));
            }
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kAccentColor,
        onPressed: () => logout(context),
        child: const Icon(
          Icons.logout_outlined,
          color: kOnPrimaryColor,
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    try {
      await authProvider.logout();
      // ignore: use_build_context_synchronously
      authProvider.updateWith(authType: AuthType.login);
      // ignore: use_build_context_synchronously
      context.goNamed('signin');
    } on CustomHttpException catch (_) {
    } catch (_) {}
  }
}
