import 'package:flutter/material.dart';
import 'package:smart_pay/app/shared_widgets/custom_container.dart';
import 'package:smart_pay/models/country.dart';
import 'package:smart_pay/utils/color_scheme.dart';

class PickerContainer extends CustomContainer {
  PickerContainer({
    Key? key,
    required BuildContext context,
    VoidCallback? onPressed,
    Country? country,
    String? hint,
    double? height,
  }) : super(
          key: key,
          height: height,
          radius: 16.0,
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          onPressed: onPressed,
          containerColor: kSecondaryColor3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (country != null)
                    SizedBox(
                      height: 24.0,
                      width: 32.0,
                      child: Image.asset(
                        'icons/flags/png/${country.iso2.toLowerCase()}.png',
                        package: 'country_icons',
                      ),
                    ),
                  const SizedBox(width: 16.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.53,
                    child: country?.name == null
                        ? Text(
                            hint ?? 'Select country',
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(
                            country!.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(fontSize: 16.0),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                ],
              ),
              const Icon(
                Icons.expand_more_rounded,
                color: kSecondaryColor,
              ),
            ],
          ),
        );
}
