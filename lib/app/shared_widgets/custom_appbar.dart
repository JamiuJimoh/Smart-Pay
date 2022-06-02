import 'package:flutter/material.dart';

import 'appbar_back_button.dart';

class CustomAppbar extends AppBar {
   CustomAppbar({Key? key, required BuildContext context})
      : super(
          key: key,
      leading: AppBarBackButton(context: context),

        );
}
