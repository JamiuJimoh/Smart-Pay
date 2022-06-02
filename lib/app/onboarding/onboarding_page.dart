import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/app/onboarding/widgets/current_item_indicator.dart';
import 'package:smart_pay/app/onboarding/widgets/onboard_item.dart';
import 'package:smart_pay/app/shared_widgets/custom_elevated_button.dart';
import 'package:smart_pay/models/onboard.dart';
import 'package:smart_pay/utils/constants.dart';

import 'widgets/onboard_data.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  var _currIndex = 0;
  late final List<Onboard> _data = OnboardingData().data;
  final _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: commonPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 35.0),
            Text(
              'Skip',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.end,
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _data.length,
                itemBuilder: (_, i) => OnboardItem(data: _data[i]),
                onPageChanged: (i) => setState(() => _currIndex = i),
              ),
            ),
            const SizedBox(height: 21.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < _data.length; i++) ...[
                        CurrentItemIndicator(isCurrentPage: _currIndex == i),
                        const SizedBox(width: 4.0),
                      ],
                    ],
                  ),
                  const SizedBox(height: 34.0),
                  CustomElevatedButton(
                    text: 'Get Started',
                    onPressed: () => context.goNamed('signin'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
