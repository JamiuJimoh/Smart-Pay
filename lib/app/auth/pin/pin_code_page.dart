import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/auth_provider.dart';
import 'package:smart_pay/app/shared_widgets/custom_appbar.dart';
import 'package:smart_pay/app/shared_widgets/custom_elevated_button.dart';
import 'package:smart_pay/app/shared_widgets/page_title.dart';
import 'package:smart_pay/utils/color_scheme.dart';
import 'package:smart_pay/utils/constants.dart';

import '../../shared_widgets/http_exception.dart';
import 'widgets/pin_text_field.dart';
import 'widgets/timer_button.dart';

class PINCodePage extends StatefulWidget {
  const PINCodePage({Key? key}) : super(key: key);

  @override
  State<PINCodePage> createState() => _PINCodePageState();
}

class _PINCodePageState extends State<PINCodePage> {
  final _pins = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  late String otp;

  var activeField = 0;

  var _disableButton = true;
  var _resendButtonLoading = false;

  @override
  void initState() {
    super.initState();
    otp = '';
    // context.watch<AuthProvider>.updateWith(otp: otp);
    // widget.value.updateWith(pin: otp);
  }

  @override
  void dispose() {
    super.dispose();

    for (var pin in _pins) {
      pin.dispose();
    }
  }

  void reset() {
    for (var pin in _pins) {
      pin.clear();
    }
    activeField = 0;
    _disableButton = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: CustomAppbar(context: context),
      body: Padding(
        padding: commonPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PageTitle(
                    title: 'Verify it’s you',
                    spaceBetween: 12.0,
                    description:
                        'We sent a code to ( ${authProvider.encryptedEmail()} ). Enter it here to verify your identity. Your PIN is ${authProvider.otpResponse}.',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var pin in _pins)
                        Flexible(
                          child: Row(
                            children: [
                              const SizedBox(width: 5.0),
                              Expanded(
                                child: PINTextField(
                                  controller: pin,
                                  context: context,
                                  obscure: false,
                                  isFocused: activeField == 5
                                      ? false
                                      : pin == _pins[activeField],
                                ),
                              ),
                              const SizedBox(width: 5.0),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        TimerButton(
                          secs: 15,
                          isLoading: _resendButtonLoading,
                          onTap: (startTimer) async {
                            await onResend();
                            startTimer();
                            for (var pin in _pins) {
                              pin.clear();
                            }
                          },
                        ),
                        const SizedBox(height: 32.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                CustomElevatedButton(
                  // context: context,
                  isLoading: authProvider.isLoading,
                  onPressed: _disableButton
                      ? null
                      : () {
                          if (otp.length <= 5) {
                            for (var pin in _pins) {
                              otp += pin.text;
                            }
                          }
                          context.read<AuthProvider>().updateWith(otp: otp);
                          if (otp.length != _pins.length) return;
                          verifyPin();
                          otp = '';
                        },
                  text: 'Confirm',
                ),
                const SizedBox(height: 24.0),
                Column(
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 13.5,
                        mainAxisSpacing: 13.5,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: 12,
                      itemBuilder: (_, i) {
                        return InkWell(
                          onTap: () {
                            keysPressed(i);
                            if (_pins.last.text.isEmpty) {
                              setState(() => _disableButton = true);
                            } else {
                              setState(() => _disableButton = false);
                            }
                          },
                          child: SizedBox(
                            height: 30.0,
                            width: 30.0,
                            child: Center(
                              child: i == 11
                                  ? const Icon(
                                      Icons.backspace_outlined,
                                      size: 24.0,
                                      color: kOnPrimaryColor,
                                    )
                                  : Text(
                                      i == 10
                                          ? '0'
                                          : (i == 9 ? '' : '${i + 1}'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500)),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int zeroKeyPressed(int i) {
    if (i == 10) {
      return 0;
    } else {
      return i + 1;
    }
  }

  void keysPressed(int i) {
    if (i == 9) return;
    if (i == 11) {
      if (activeField != 0) {
        _pins[--activeField].clear();
      }
    } else {
      if (activeField != _pins.length) {
        _pins[activeField++].text = zeroKeyPressed(i).toString();
      }
    }
  }

  Future<void> onResend() async {
    try {
      setState(() => _resendButtonLoading = true);

      await context.read<AuthProvider>().fetchEmailToken();
      setState(() => _resendButtonLoading = false);
    } on CustomHttpException catch (_) {
    } catch (_) {}
  }

  Future<void> verifyPin() async {
    try {
      final verified = await context.read<AuthProvider>().verifyEmailToken();
      if (verified) {
        reset();
        // ignore: use_build_context_synchronously
        context.pushNamed('country_page');
      }
      return;
    } on CustomHttpException catch (_) {
    } catch (_) {}
  }
}
