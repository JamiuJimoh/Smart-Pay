import 'package:flutter/material.dart';
import 'package:smart_pay/utils/color_scheme.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.height = 56.0,
    this.width = double.infinity,
    this.radius = 16.0,
    this.color,
    this.disabledColor,
    this.padding,
    this.borderColor,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String text;
  final double? height;
  final double? width;
  final double radius;
  final Color? color;
  final Color? disabledColor;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return color?.withOpacity(0.8) ??
                    kOnPrimaryColor.withOpacity(0.8);
              } else if (states.contains(MaterialState.disabled)) {
                return kOnPrimaryColor.withOpacity(0.8);
              }
              return color ?? kOnPrimaryColor;
            },
          ),
          elevation: MaterialStateProperty.all<double>(0.15),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: borderColor == null
                    ? disabledColor != null
                        ? BorderSide(color: disabledColor!)
                        : const BorderSide(color: Colors.white)
                    : BorderSide(color: borderColor!)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
