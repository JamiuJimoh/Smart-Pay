import 'package:flutter/material.dart';
import 'package:smart_pay/utils/color_scheme.dart';

import '../../../shared_widgets/custom_text_field.dart';

enum PINType { setting, verification }

class PINTextField extends CustomTextField {
  PINTextField({
    Key? key,
    required BuildContext context,
    required TextEditingController controller,
    PINType pinType = PINType.verification,
    bool isFocused = false,
    bool obscure = true,
    void Function(String)? onChanged,
  }) : super(
          key: key,
          filled: pinType == PINType.verification,
          width: 56.0,
          enabled: false,

          controller: controller,
          obscureText: obscure,
          // contentPadding: const EdgeInsets.all(12.0),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
          onChanged: onChanged,

          // enabledBorder: const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(10.0),
          //   ),
          //   borderSide: BorderSide(color: AppColor.kSwitchActiveColor),
          // ),

          // border: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.green),
          // ),

          border: pinType == PINType.verification
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide.none,
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
          disabledBorder: pinType == PINType.verification
              ? OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: isFocused
                      ? const BorderSide(color: kAccentColor2)
                      : BorderSide.none,
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: kAccentColor, width: 1.5),
                ),
          // disabledBorder: pinType == PINType.verification
          //     ? const OutlineInputBorder(
          //         borderRadius: BorderRadius.all(
          //           Radius.circular(12.0),
          //         ),
          //         borderSide: BorderSide(color: AppColor.kSwitchActiveColor),
          //       )
          //     : const UnderlineInputBorder(
          //         borderSide: BorderSide(color: AppColor.kSwitchActiveColor),
          //       ),
          // focusedBorder: const UnderlineInputBorder(
          //   borderSide: BorderSide(color: AppColor.kSwitchActiveColor),
          // ),
          // enabledBorder: const UnderlineInputBorder(
          //   borderSide: BorderSide(color: AppColor.kSwitchActiveColor),
          // ),
          // disabledBorder: const UnderlineInputBorder(
          //   borderSide: BorderSide(color: AppColor.kSwitchActiveColor),
          // ),
        );
}
