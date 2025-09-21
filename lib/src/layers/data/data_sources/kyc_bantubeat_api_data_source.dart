import 'package:dio/dio.dart' show FormData, MultipartFile;

import '../../../core/network/my_http/kyc_http.dart';
import '../models/payment_preference_model.dart';
import '../models/kyc_model.dart';
import '../models/user_model.dart';

///
/// This is a Bantubeat API Data Source, all methods are named regarding to the
/// api path to call, first is the HTTP METHOD to use GET, POST, etc
/// then the second is the uri in cameCase, so GET /public/all-currencies will
/// be  get$publicAllCurrencies.
final class KycBantubeatApiDataSource {
  final KycHttpClient _client;
  // final KycHttpClient _cachedClient;

  const KycBantubeatApiDataSource({
    required KycHttpClient client,
    required KycHttpClient cachedClient,
  }) : _client = client;
  // _cachedClient = cachedClient;

  // String _mapToQueryParams(Map<String, dynamic> params) {
  //   return params.entries
  //       .map((e) {
  //         return '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}';
  //       })
  //       .join('&');
  // }

  Future<UserModel> get$authUser() {
    return _client.get('/auth/user').then((r) => UserModel.fromJson(r.data));
  }

  /// Get payment preferences
  Future<List<PaymentPreferenceModel>> get$paymentPreferences() {
    return _client
        .get('/balance/payment-preferences')
        .then((r) => r.data as List)
        .then((list) => list.map((e) => e as Map<String, dynamic>))
        .then((jsonList) => jsonList.map(PaymentPreferenceModel.fromJson))
        .then((iterable) => iterable.toList());
  }

  Future<KycModel> get$accountKyc() async {
    try {
      final response = await _client.get('/account/kyc');
      return KycModel.fromJson(response.data);
    } on MyHttpException catch (e) {
      throw ServerException(e.message ?? 'Unknown error', e.statusCode);
    }
  }

  Future<void> delete$accountKyc() {
    return _client.delete('/account/kyc').then((_) {});
  }

  Future<void> post$accountKyc({
    required String firstName,
    String? lastName,
    required String address,
    required String city,
    required String country,
    String? zipCode,
    required String frontFaceImagePath,
    required String backFaceImagePath,
    required String normalSelfieImagePath,
    required String selfieWithIdCardImagePath,
    required String? linkRs,
    required String email,
    ({String name, String registrationNumber, String? tva})? company,
    ({String registrationNumber})? particular,
  }) async {
    assert(company != null || particular != null);
    try {
      final formData = FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        'address': address,
        'city': city,
        'country': country.toUpperCase(),
        'zip_code': zipCode,
        'front_face_image': await MultipartFile.fromFile(frontFaceImagePath),
        'back_face_image': await MultipartFile.fromFile(backFaceImagePath),
        'normal_selfie_image': await MultipartFile.fromFile(
          normalSelfieImagePath,
        ),
        'selfie_with_id_card_image': await MultipartFile.fromFile(
          selfieWithIdCardImagePath,
        ),
        'link_rs': linkRs ?? '#',
        'email': email,
        'is_company': company != null ? 1 : 0,
        if (company != null) ...{
          'company_name': company.name,
          'company_registration_number': company.registrationNumber,
          'company_tva': company.tva,
        },
        if (particular != null) ...{
          'company_registration_number': particular.registrationNumber,
        },
      });

      await _client.post('/account/kyc', body: formData);
    } on MyHttpException catch (e) {
      throw ServerException(e.message ?? 'Unknown error', e.statusCode);
    }
  }
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException(this.message, [this.statusCode]);
}
