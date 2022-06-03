import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/auth_provider.dart';
import 'package:smart_pay/models/country.dart';
import 'package:smart_pay/utils/color_scheme.dart';

class CountryListTileContainer extends StatefulWidget {
  const CountryListTileContainer({
    Key? key,
    required this.countries,
    // required this.onTap,
  }) : super(key: key);
  final List<Country> countries;

  @override
  State<CountryListTileContainer> createState() =>
      _CountryListTileContainerState();
}

class _CountryListTileContainerState extends State<CountryListTileContainer> {
  // final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var country in widget.countries)
          InkWell(
            onTap: () {
              context.read<AuthProvider>().updateWith(country: country);
              FocusScope.of(context).unfocus();
              // Navigator.of(context).pop();
              // setState(() {});
            },
            child: ListTile(
              dense: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              selectedTileColor: kSecondaryColor3,
              selected: context.watch<AuthProvider>().country == country,
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                country.name,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: kOnPrimaryColor, fontWeight: FontWeight.w600),
              ),
              leading: SizedBox(
                width: 80.0,
                child: Row(
                  children: [
                    SizedBox(
                      height: 24.0,
                      width: 32.0,
                      child: Image.asset(
                        'icons/flags/png/${country.iso2.toLowerCase()}.png',
                        package: 'country_icons',
                      ),
                    ),
                    const SizedBox(width: 14.0),
                    Text(country.iso2,
                        //
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              trailing: context.watch<AuthProvider>().country == country
                  ? const Icon(Icons.check, color: kAccentColor2)
                  : null,
            ),
          ),
      ],
    );
  }
}
