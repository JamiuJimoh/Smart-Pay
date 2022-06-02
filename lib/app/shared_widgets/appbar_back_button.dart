import 'package:flutter/material.dart';

import 'package:smart_pay/utils/color_scheme.dart';

import 'custom_container.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    Key? key,
    required this.context,
    this.onTap,
  }) : super(key: key);
  final BuildContext context;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16.0),
        CustomContainer(
          height: 40.0,
          width: 40.0,
          radius: 12.0,
          onPressed: onTap ?? Navigator.of(context).pop,
          borderColor: kAccentColor3,
          child: const Icon(Icons.chevron_left_rounded, color: kOnPrimaryColor),
        ),
      ],
    );
  }
}
