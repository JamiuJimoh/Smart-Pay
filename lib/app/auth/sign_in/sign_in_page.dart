import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/auth_provider.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/login_page_title.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/signup_page_title.dart';
import 'package:smart_pay/app/shared_widgets/custom_elevated_button.dart';
import 'package:smart_pay/app/shared_widgets/custom_outlined_button.dart';
import 'package:smart_pay/app/shared_widgets/custom_text_field.dart';
import 'package:smart_pay/utils/color_scheme.dart';
import 'package:smart_pay/utils/constants.dart';
import '../../shared_widgets/custom_appbar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // print(context.watch<AuthProvider>());
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: commonPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6.0),
                      if (authProvider.authType == AuthType.register) ...[
                        const SignUpPageTitle(),
                        const SizedBox(height: 32.0),
                      ],
                      if (authProvider.authType == AuthType.login)
                        const LoginPageTitle(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (authProvider.authType == AuthType.register) ...[
                            CustomTextField(
                              hint: 'Full name',
                              onChanged: (val) {
                                context
                                    .read<AuthProvider>()
                                    .updateWith(fullName: val);
                              },
                            ),
                            const SizedBox(height: 16.0),
                          ],
                          CustomTextField(
                            hint: 'Email',
                            onChanged: (val) {
                              context
                                  .read<AuthProvider>()
                                  .updateWith(email: val);
                            },
                          ),
                          const SizedBox(height: 16.0),
                          CustomTextField(
                            hint: 'Password',
                            obscureText: !isPasswordVisible,
                            suffixIcon: GestureDetector(
                              onTap: (() => setState(() =>
                                  isPasswordVisible = !isPasswordVisible)),
                              child: Icon(
                                !isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: kSecondaryColor,
                              ),
                            ),
                            onChanged: (val) {
                              context
                                  .read<AuthProvider>()
                                  .updateWith(password: val);
                            },
                          ),
                          if (authProvider.authType == AuthType.login) ...[
                            const SizedBox(height: 24.0),
                            GestureDetector(
                              onTap: () =>
                                  context.pushNamed('password_recovery'),
                              child: Text(
                                'Forgot Password?',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ],
                          const SizedBox(height: 24.0),
                          CustomElevatedButton(
                            text: 'Sign Up',
                            onPressed: () {},
                          ),
                          const SizedBox(height: 32.0),
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: kAccentColor3,
                                  // indent: 18.5,
                                  thickness: 1.0,
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Text('OR',
                                  style: Theme.of(context).textTheme.subtitle2),
                              const SizedBox(width: 12.0),
                              const Expanded(
                                child: Divider(
                                  color: kAccentColor3,
                                  // endIndent: 18.5,
                                  thickness: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32.0),
                          Row(
                            children: const [
                              Expanded(
                                child: CustomOutlinedButton(
                                  image: 'assets/socials/google.png',
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: CustomOutlinedButton(
                                  image: 'assets/socials/apple.png',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: context.read<AuthProvider>().toggleAuthType,
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            text: authProvider.toggleAuthPageText()[0],
                          ),
                          TextSpan(
                            style: Theme.of(context).textTheme.headline6,
                            text: authProvider.toggleAuthPageText().last,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
