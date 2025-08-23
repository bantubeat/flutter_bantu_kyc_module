import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';

class KycFormAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KycFormAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      /*
      leading: IconButton(
        onPressed: () => Modular.to.pop(),
        icon: const Icon(Icons.arrow_back, color: Colors.black),
      ), */
      title: Text(
        LocaleKeys.kyc_module_appBarTitle.tr(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }
}
