import 'package:alchef/core/network/api_client.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/features/address/model/address_model.dart';
import 'package:alchef/features/auth/model/auth_request.dart';

class AddressRepository {
  static final _apiClient = ApiClient();

  static Future<List<Emirate>> getEmirates() async {
    final response = await _apiClient.post(url: ApiEndpoints.emirates);

    final data = response.data['data'] as List;

    return data.map((e) => Emirate.fromJson(e)).toList();
  }

  static Future<List<Address>> getAddress(UserRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.addressList,
      data: request.toJson(),
    );

    return (response.data['data'] as List)
        .map((e) => Address.fromJson(e))
        .toList();
  }

  static Future<String> addAddress(AddAddressRequest request) async {
    final respone = await _apiClient.post(
      url: ApiEndpoints.addAddress,
      data: request.toJson(),
    );

    return respone.data['message']?.toString() ?? 'Address added successfully';
  }

  static Future<String> editAddress(EditAddressRequest request) async {
    final respone = await _apiClient.post(
      url: ApiEndpoints.addAddress,
      data: request.toJson(),
    );

    return respone.data['message']?.toString() ?? 'Address added successfully';
  }
}
