import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/auth_provider.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/login_page_title.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/signup_page_title.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/validators.dart';
import 'package:smart_pay/app/shared_widgets/custom_elevated_button.dart';
import 'package:smart_pay/app/shared_widgets/custom_outlined_button.dart';
import 'package:smart_pay/app/shared_widgets/custom_text_field.dart';
import 'package:smart_pay/app/shared_widgets/http_exception.dart';
import 'package:smart_pay/utils/color_scheme.dart';
import 'package:smart_pay/utils/constants.dart';

class SignInPage extends StatefulWidget with SignInValidators {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var isPasswordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (authProvider.authType == AuthType.register) ...[
                              CustomTextField(
                                controller: _fullNameController,
                                hint: 'Full name',
                                keyboardType: TextInputType.name,
                                onChanged: (_) {
                                  // _formKey.currentState!.reset();
                                  final authProvider =
                                      context.read<AuthProvider>();
                                  authProvider.updateWith(
                                      fullName: _fullNameController.text);
                                  authProvider.checkSubmit();
                                },
                                validator: (val) {
                                  if (val == null ||
                                      !widget.nameValidator.isValidName(val)) {
                                    return SignInValidators
                                        .invalidNameErrorText;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                            ],
                            CustomTextField(
                              controller: _emailController,
                              hint: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (val) {
                                final authProvider =
                                    context.read<AuthProvider>();
                                authProvider.updateWith(
                                    email: _emailController.text);
                                authProvider.checkSubmit();
                              },
                              validator: (val) {
                                if (val == null ||
                                    !widget.emailValidator.isValidEmail(val)) {
                                  return SignInValidators.invalidEmailErrorText;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextField(
                              controller: _passwordController,
                              hint: 'Password e.g Somebody1',
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !isPasswordVisible,
                              suffixIcon: GestureDetector(
                                onTap: (() => setState(() =>
                                    isPasswordVisible = !isPasswordVisible)),
                                child: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: kSecondaryColor,
                                ),
                              ),
                              onChanged: (val) {
                                final authProvider =
                                    context.read<AuthProvider>();
                                authProvider.updateWith(
                                    password: _passwordController.text);
                                authProvider.checkSubmit();
                              },
                              validator: (val) {
                                if (val == null ||
                                    !widget.passwordValidator
                                        .isValidPassword(val)) {
                                  return SignInValidators
                                      .invalidPasswordErrorText;
                                }
                                return null;
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
                              text: authProvider.authType == AuthType.login
                                  ? 'Sign In'
                                  : 'Sign Up',
                              isLoading: authProvider.isLoading,
                              onPressed:
                                  authProvider.canSubmit ? fetchToken : null,
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
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
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

  Future<void> fetchToken() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
    } else {
      return;
    }
    try {
      final authProvider = context.read<AuthProvider>();
      if (authProvider.authType == AuthType.login) {
        await authProvider.login();
        // ignore: use_build_context_synchronously
        context.goNamed('home');
      } else {
        await authProvider.fetchEmailToken();
        // ignore: use_build_context_synchronously
        context.pushNamed('pin_page');
      }
    } on CustomHttpException catch (_) {
    } catch (_) {}
  }
}
