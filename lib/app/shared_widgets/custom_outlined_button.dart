import 'package:flutter/material.dart';
import 'package:smart_pay/utils/color_scheme.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    this.onPressed,
    required this.image,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.0,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(8.0),
          elevation: 0.15,
          primary: kOnPrimaryColor,
          backgroundColor: Colors.white,
          side: const BorderSide(color: kAccentColor3),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
        ),
        onPressed: onPressed,
        child: Image.asset(image),
      ),
    );
  }
}
