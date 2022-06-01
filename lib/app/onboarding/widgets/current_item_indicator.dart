import 'package:flutter/foundation.dart';
import 'package:smart_pay/app/shared_widgets/custom_container.dart';
import 'package:smart_pay/utils/color_scheme.dart';

class CurrentItemIndicator extends CustomContainer {
  const CurrentItemIndicator({Key? key, required bool isCurrentPage})
      : super(
          key: key,
          height: 6.0,
          width: isCurrentPage ? 32.0 : 6.0,
          containerColor: isCurrentPage ? kOnPrimaryColor : kAccentColor3,
        );
}
