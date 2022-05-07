import 'dart:convert';

import 'package:dionys/app/models/address.dart';
import 'package:http/http.dart' as http;

const apiUrl = "https://online-gateway.ghn.vn/shiip/public-api/master-data/";
const GHNToken = "8abf528e-2bd1-11ec-ab03-e680cb72ac98";

class AddressService {
  Future<List<Province>> getProvices() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'token': GHNToken,
    };
    var uri = Uri.parse(apiUrl + "province");
    var response = await http.get(uri, headers: requestHeaders);

    if (response.statusCode == 200) {
      var addressJson = jsonDecode(response.body);
      var provinces = Province.fromListJson(addressJson["data"]);

      return provinces;
    }

    throw Exception("request failed");
  }

  Future<List<District>> getDistricts(int provinceId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': GHNToken,
    };
    var uri = Uri.parse(apiUrl + "district");
    var response = await http.post(uri,
        headers: requestHeaders,
        body: json.encode({"province_id": provinceId}));

    if (response.statusCode == 200) {
      var addressJson = jsonDecode(response.body);
      var districts = District.fromListJson(addressJson["data"]);

      return districts;
    }

    throw Exception("request failed");
  }

  Future<List<Ward>> getWards(int districtId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': GHNToken,
    };
    var uri = Uri.parse(apiUrl + "ward");
    var response = await http.post(uri,
        headers: requestHeaders,
        body: json.encode({"district_id": districtId}));

    if (response.statusCode == 200) {
      var addressJson = jsonDecode(response.body);
      var wards = Ward.fromListJson(addressJson["data"]);

      return wards;
    }

    throw Exception("request failed");
  }
}
