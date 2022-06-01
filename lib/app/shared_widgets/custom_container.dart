import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final Color? borderColor;
  final double? height;
  final double? width;
  final Color? containerColor;
  final double? radius;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  const CustomContainer({
    Key? key,
    this.child,
    this.borderColor,
    this.height = 100.0,
    this.width = 100.0,
    this.containerColor,
    this.topLeftRadius,
    this.radius = 500.0,
    this.topRightRadius,
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.padding,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: radius == null
              ? null
              : BorderRadius.only(
                  bottomLeft: Radius.circular(bottomLeftRadius ?? radius!),
                  bottomRight: Radius.circular(bottomRightRadius ?? radius!),
                  topLeft: Radius.circular(topLeftRadius ?? radius!),
                  topRight: Radius.circular(topRightRadius ?? radius!),
                ),
          color: containerColor,
        ),
        child: child,
      ),
    );
  }
}
