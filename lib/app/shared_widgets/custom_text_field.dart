import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_pay/utils/color_scheme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.hint = '',
      this.height = 56.0,
      this.width = double.infinity,
      this.suffixIcon,
      this.obscureText = false,
      this.validator,
      this.controller,
      this.onSaved,
      this.onChanged,
      this.keyboardType,
      this.filled = true,
      this.enabled,
      this.textAlign = TextAlign.start,
      this.contentPadding,
      this.border,
      this.disabledBorder,
      this.style,
      this.icon,
      this.inputFormatter})
      : super(key: key);
  final double? height;
  final double? width;
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
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign textAlign;
  final InputBorder? border;
  final InputBorder? disabledBorder;
  final TextStyle? style;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        validator: validator,
        onSaved: onSaved,
        inputFormatters: inputFormatter,
        cursorColor: kOnPrimaryColor,
        cursorWidth: 1.0,
        style: style ?? Theme.of(context).textTheme.bodyText1,
        obscureText: obscureText!,
        keyboardType: keyboardType,
        onChanged: onChanged,
        textAlign: textAlign,
        enabled: enabled,
        decoration: InputDecoration(
          // icon: icon,
          prefixIcon: icon,
          contentPadding: contentPadding ?? const EdgeInsets.all(16.0),
          filled: filled,
          fillColor: kFillColor,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
            borderSide: BorderSide.none,
          ),
          border: border ??
              const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                borderSide: BorderSide.none,
              ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
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
          disabledBorder: disabledBorder ??
              const OutlineInputBorder(
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
