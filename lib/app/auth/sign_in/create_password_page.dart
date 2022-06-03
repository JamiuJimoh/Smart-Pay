import 'package:flutter/material.dart';
import 'package:smart_pay/app/shared_widgets/custom_appbar.dart';
import 'package:smart_pay/app/shared_widgets/custom_elevated_button.dart';
import 'package:smart_pay/app/shared_widgets/custom_text_field.dart';
import 'package:smart_pay/app/shared_widgets/page_title.dart';
import 'package:smart_pay/utils/constants.dart';

class CreateNewPasswordPage extends StatelessWidget {
  const CreateNewPasswordPage({Key? key}) : super(key: key);

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
                  title: 'Create New Password',
                  description:
                      'Please, enter a new password below different from the previous password',
                  spaceBetween: 12.0,
                ),
                SizedBox(height: 32.0),
                CustomTextField(
                  hint: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  hint: 'Confirm Password',
                  obscureText: true,
                ),
              ],
            ),
            const CustomElevatedButton(
              text: 'Create new password',
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
