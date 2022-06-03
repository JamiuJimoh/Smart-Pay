// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/app/auth/sign_in/widgets/auth_provider.dart';
import 'package:smart_pay/app/shared_widgets/custom_appbar.dart';
import 'package:smart_pay/app/shared_widgets/custom_elevated_button.dart';
import 'package:smart_pay/app/shared_widgets/http_exception.dart';
import 'package:smart_pay/app/shared_widgets/page_title.dart';
import 'package:smart_pay/utils/constants.dart';

import 'widgets/bottom_sheet_content.dart';
import 'widgets/picker_container.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key}) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: CustomAppbar(context: context),
      body: Padding(
        padding: commonPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 8.0),
                const PageTitle(
                  title: 'Country of Residence',
                  description:
                      'Please select all the countries that you’re a tax resident in',
                  spaceBetween: 12.0,
                ),
                const SizedBox(height: 32.0),
                PickerContainer(
                  context: context,
                  country: authProvider.country,
                  onPressed: _showCountryPicker,
                ),
              ],
            ),
            CustomElevatedButton(
              text: 'Continue',
              isLoading: authProvider.isLoading,
              onPressed: authProvider.country == null ? null : register,
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker() {
    showDraggableScrollableSheet(context, const BottomSheetContent());
    FocusScope.of(context).unfocus();
  }

  Future<bool?> showDraggableScrollableSheet(
    BuildContext context,
    Widget child, [
    double? initialChildSize,
    bool? isDismissible,
    EdgeInsetsGeometry? padding,
  ]) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: isDismissible ?? true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        minChildSize: 0.5,
        initialChildSize: initialChildSize ?? 0.8,
        maxChildSize: 0.8,
        builder: (_, controller) => Padding(
          padding: padding ?? commonPadding,
          child: SingleChildScrollView(
            controller: controller,
            child: child,
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    final authProvider = context.read<AuthProvider>();
    try {
      await authProvider.register();
      if (authProvider.token.isNotEmpty) {
        context.goNamed('set_pin_page');
      }
    } on CustomHttpException catch (_) {
    } catch (_) {}
  }
}
