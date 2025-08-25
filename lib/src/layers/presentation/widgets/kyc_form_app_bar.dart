import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../kyc_module.dart';

class KycFormAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KycFormAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _onClosePressed() {
    Modular.get<OnKycFinishFn>()(false);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12, top: 8),
          child: InkWell(
            onTap: _onClosePressed,
            child: Column(
              children: [
                const Icon(Icons.cancel, color: Colors.redAccent),
                Text(
                  LocaleKeys.kyc_module_common_cancel.tr(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
