import 'package:flutter/material.dart';
import 'package:smart_pay/app/shared_widgets/custom_appbar.dart';
import 'package:smart_pay/app/shared_widgets/custom_elevated_button.dart';
import 'package:smart_pay/app/shared_widgets/custom_text_field.dart';
import 'package:smart_pay/app/shared_widgets/page_title.dart';
import 'package:smart_pay/utils/constants.dart';

class PasswordRecoveryPage extends StatelessWidget {
  const PasswordRecoveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context: context),
      body: Padding(
        padding: commonPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: const [
                SizedBox(height: 6.0),
                PageTitle(
                  title: 'Password Recovery',
                  description:
                      'Enter your registered email below to receive password instructions',
                  spaceBetween: 12.0,
                ),
                SizedBox(height: 32.0),
                CustomTextField(
                  hint: 'Email',
                ),
              ],
            ),
            CustomElevatedButton(
              text: 'Send verification code',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
