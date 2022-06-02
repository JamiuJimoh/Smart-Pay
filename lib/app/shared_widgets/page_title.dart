import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key? key,
    required this.title,
    required this.description,
    this.spaceBetween = 8.0,
  }) : super(key: key);
  final String title;
  final String description;
  final double spaceBetween;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: spaceBetween),
        Row(
          children: [
            Flexible(
              child: Text(description,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
