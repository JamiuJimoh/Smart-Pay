import 'package:flutter/material.dart';
import 'package:smart_pay/utils/color_scheme.dart';

class SignUpPageTitle extends StatelessWidget {
  const SignUpPageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
              style: Theme.of(context).textTheme.headline1,
              text: 'Create a ',
            ),
            TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(color: kAccentColor),
              text: 'SmartPay',
            ),
          ]),
        ),
        Text(
          'account',
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}
