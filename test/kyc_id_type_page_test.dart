import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/entities/user_entity.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/screens/kyc_step3_id_card/kyc_step3_id_card_screen.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/ui_models/kyc_form_data.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/account_type_modal.dart';
import 'package:flutter_test/flutter_test.dart';

const _idCardKey = 'kyc_module.step3.id_card';
const _passportKey = 'kyc_module.step3.passport';

void main() {
  testWidgets("selection d'une methode de verification met a jour le UI", (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));

    final user = UserEntity(
      id: 1,
      uuid: 'uuid',
      slug: 'slug',
      username: 'username',
      noms: 'noms',
      nom: 'nom',
      prenom: 'prenom',
      photoUrl: null,
      profilBannerUrl: null,
      birthyear: 1990,
      email: 'a@b.c',
      pays: 'CM',
      telephone: '123',
      createdAt: DateTime(2020),
      updatedAt: DateTime(2020),
    );
    final step1 = KycFormDataStep1(
      currentUser: user,
      accountType: AccountType.particulier,
      firstName: 'A',
      lastName: 'B',
      birthdate: DateTime(1990),
      gender: EGender.M,
    );
    final step2 = KycFormDataStep2(
      previousData: step1,
      street: 'street',
      city: 'city',
      country: CountryCode.fromCountryCode('CM'),
      postalCode: '123',
    );

    await tester.pumpWidget(
      MaterialApp(home: KycStep3IdCardScreen(step2Data: step2)),
    );
    await tester.pumpAndSettle();

    Color borderColorOf(String title) {
      final tile = tester.widget<AnimatedContainer>(
        find
            .ancestor(
              of: find.text(title),
              matching: find.byType(AnimatedContainer),
            )
            .first,
      );
      final decoration = tile.decoration! as BoxDecoration;
      return (decoration.border! as Border).top.color;
    }

    // Au départ, nationalCni est sélectionné (bordure noire).
    expect(borderColorOf(_idCardKey), Colors.black);
    expect(borderColorOf(_passportKey), const Color(0xFFE2E5EA));

    // On tape sur Passeport.
    await tester.tap(find.text(_passportKey));
    await tester.pumpAndSettle();

    // La sélection doit basculer.
    expect(borderColorOf(_passportKey), Colors.black);
    expect(borderColorOf(_idCardKey), const Color(0xFFE2E5EA));
  });
}
