import 'dart:convert';

import 'package:dionys/app/config.dart';
import 'package:dionys/app/models/address.dart';
import 'package:http/http.dart' as http;

final apiUrl = Config.apiUrl;
final apiEndpoint = apiUrl + "user";

class UserService {
  final String token;

  Map<String, String>? requestHeaders;

  UserService(this.token) {
    requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "bearer " + token,
    };
  }

  Future<List<Address>> getAddresses() async {
    var uri = Uri.parse(apiEndpoint + "/getAddresses");
    var response = await http.get(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      var addresses = jsonDecode(response.body);

      try {
        final newAddresses = Address.fromListJson(addresses);
        return newAddresses;
      } catch (ex) {
        return [];
      }
    }

    return [];
  }

  Future<Address> addAddress(Address address) async {
    var uri = Uri.parse(apiEndpoint + "/addAddress");
    var response = await http.post(uri,
        headers: requestHeaders, body: json.encode(address.toJson()));

    if (response.statusCode == 200) {
      return Address.fromJson(jsonDecode(response.body));
    }

    return Address();
  }

  Future<bool> removeAddress(int addressId) async {
    var uri = Uri.parse(apiEndpoint + "/deleteAddress/" + addressId.toString());
    var response = await http.delete(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> setDefaultAddress(int addressId) async {
    final uri =
        Uri.parse(apiEndpoint + "/setDefaultAddress/" + addressId.toString());
    final result = await http.post(uri, headers: requestHeaders);

    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }
}
