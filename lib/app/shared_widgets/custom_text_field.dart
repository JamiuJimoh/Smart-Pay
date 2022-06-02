import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_pay/utils/color_scheme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.hint,
      this.suffixIcon,
      this.obscureText = false,
      this.validator,
      this.controller,
      this.onSaved,
      this.onChanged,
      this.keyboardType,
      this.filled = true,
      this.enabled,
      this.inputFormatter})
      : super(key: key);
  final String hint;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? filled;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.0,
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        validator: validator,
        onSaved: onSaved,
        inputFormatters: inputFormatter,
        cursorColor: kOnPrimaryColor,
        cursorWidth: 1.0,
        style: Theme.of(context).textTheme.bodyText1,
        obscureText: obscureText!,
        keyboardType: keyboardType,
        onChanged: onChanged,
        enabled: enabled,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16.0),
          filled: filled,
          fillColor: kFillColor,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
            borderSide: BorderSide.none,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
          ),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.subtitle1,
          suffixIcon: suffixIcon,
          suffixIconColor: kSecondaryColor,
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
            borderSide: BorderSide(color: kAccentColor2),
          ),
        ),
      ),
    );
  }
}
