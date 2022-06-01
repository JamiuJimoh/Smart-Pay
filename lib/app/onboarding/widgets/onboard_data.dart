import 'package:smart_pay/models/onboard.dart';

class OnboardingData {
  static const List<Onboard> _data = [
    Onboard(
        image: 'assets/onboarding/onboarding1.png',
        title: 'Finance app the safest and most trusted',
        description:
            'Your finance work starts here. Our here to help you track and deal with speeding up your transactions.'),
    Onboard(
        image: 'assets/onboarding/onboarding2.png',
        title: 'The fastest transaction process only here',
        description:
            'Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.'),
  ];

  List<Onboard> get data => _data;
}
