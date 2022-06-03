
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/auth_provider.dart';
import 'package:smart_pay/app/shared_widgets/custom_text_field.dart';
import 'package:smart_pay/utils/color_scheme.dart';

import 'country_list_tile_container.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({Key? key}) : super(key: key);

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _countryController,
                keyboardType: TextInputType.name,
                icon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/images/search.png',
                    height: 18.0,
                    width: 18.0,
                    fit: BoxFit.cover,
                  ),
                ),
                onChanged: (_) {
                  context
                      .read<AuthProvider>()
                      .findCountry(_countryController.text);
                  setState(() {});
                },
                hint: 'Search',
              ),
            ),
            const SizedBox(width: 10.0),
            TextButton(
              onPressed: () {
                _countryController.clear();
                setState(() {});
              },
              child: Text(
                'Cancel',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: kOnPrimaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        CountryListTileContainer(
          countries:
              context.read<AuthProvider>().findCountry(_countryController.text),
        ),
        const SizedBox(height: 200.0),
      ],
    );
  }
}
