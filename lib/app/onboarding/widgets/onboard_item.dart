import 'package:flutter/material.dart';

import 'package:smart_pay/models/onboard.dart';

class OnboardItem extends StatelessWidget {
  const OnboardItem({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Onboard data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(data.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Text(
            data.title,
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            data.description,
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
