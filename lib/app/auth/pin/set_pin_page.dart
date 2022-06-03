import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/auth_provider.dart';
import 'package:smart_pay/app/shared_widgets/custom_elevated_button.dart';
import 'package:smart_pay/app/shared_widgets/page_title.dart';
import 'package:smart_pay/utils/color_scheme.dart';
import 'package:smart_pay/utils/constants.dart';

import 'widgets/pin_text_field.dart';

class SetPINCodePage extends StatefulWidget {
  const SetPINCodePage({Key? key}) : super(key: key);

  @override
  State<SetPINCodePage> createState() => _SetPINCodePageState();
}

class _SetPINCodePageState extends State<SetPINCodePage> {
  final _pins = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  late String pinCode;

  var activeField = 0;

  var _disableButton = true;

  @override
  void initState() {
    super.initState();
    pinCode = '';
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
    // final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(),
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
                  const PageTitle(
                    title: 'Set your PIN code',
                    spaceBetween: 12.0,
                    description:
                        'We use state-of-the-art security measures to protect your information at all times',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var pin in _pins)
                        Flexible(
                          child: Row(
                            children: [
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: PINTextField(
                                  controller: pin,
                                  context: context,
                                  pinType: PINType.setting,
                                  obscure: false,
                                  isFocused: activeField == 5
                                      ? false
                                      : pin == _pins[activeField],
                                ),
                              ),
                              const SizedBox(width: 10.0),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                ],
              ),
            ),
            Column(
              children: [
                CustomElevatedButton(
                  // context: context,
                  onPressed: _disableButton
                      ? null
                      : () {
                          if (pinCode.length <= 5) {
                            for (var pin in _pins) {
                              pinCode += pin.text;
                            }
                          }
                          context.read<AuthProvider>().updateWith(pin: pinCode);
                          if (pinCode.length != _pins.length) return;
                          verifyPin();
                          pinCode = '';
                        },
                  text: 'Create PIN',
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

  void verifyPin() async {
    // if (widget.value.validatePIN()) {
    //   ConfirmPINCodeSetPage.show(context).then((_) => reset());
    // } else {
    //   await PopupDialogs(context).failureAlert(
    //       title: 'Oops!',
    //       description:
    //           'PIN is too common and easily guessed. Be more creative 😃',
    //       timedDismissible: false);
    reset();
    context.pushNamed('success_page');
    // }
  }
}
