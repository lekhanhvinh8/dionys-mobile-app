class Address {
  int id = 0;
  int? provinceId;
  int? districtId;
  String? wardCode;
  String? provinceName;
  String? districtName;
  String? wardName;
  String? detail = "";
  bool isDefault = false;

  String customerName = "";
  String phoneNumber = "";

  Address(
      {this.id = 0,
      this.provinceId,
      this.districtId,
      this.wardCode,
      this.provinceName,
      this.districtName,
      this.wardName,
      this.detail,
      this.customerName = "",
      this.phoneNumber = "",
      this.isDefault = false});

  static fromJson(Map<String, dynamic> json) {
    return Address(
        id: json["id"],
        isDefault: json["isDefault"],
        provinceId: json["provinceId"],
        districtId: json["districtId"],
        wardCode: json["wardCode"],
        provinceName: json["provinceName"],
        districtName: json["districtName"],
        wardName: json["wardName"],
        detail: json["detail"],
        customerName: json["customerName"],
        phoneNumber: json["phoneNumber"]);
  }

  static fromListJson(List<dynamic> listJson) {
    List<Address> addresses = [];

    for (var json in listJson) {
      var address = fromJson(json);
      addresses.add(address);
    }

    return addresses;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "provinceId": provinceId,
      "districtId": districtId,
      "wardCode": wardCode,
      "provinceName": provinceName,
      "districtName": districtName,
      "wardName": wardName,
      "detail": detail,
      "customerName": customerName,
      "phoneNumber": phoneNumber,
      "isDefault": isDefault,
    };
  }
}

class District {
  int id;
  String name;
  int provinceId;

  District(this.id, this.name, this.provinceId);

  static fromJson(Map<String, dynamic> json) {
    return District(
        json['DistrictID'], json['DistrictName'], json['ProvinceID']);
  }

  static List<District> fromListJson(List<dynamic> json) {
    List<District> districts = [];
    for (var districtJson in json) {
      if (districtJson["Status"] == null) continue;
      if ((districtJson["DistrictName"] as String).contains("Đặc biệt")) {
        continue;
      }

      var district = fromJson(districtJson);
      districts.add(district);
    }

    return districts;
  }
}

class Province {
  int id;
  String name;
  String code;

  Province(this.id, this.name, this.code);

  static fromJson(Map<String, dynamic> json) {
    return Province(json['ProvinceID'], json['ProvinceName'], json['Code']);
  }

  static List<Province> fromListJson(List<dynamic> json) {
    List<Province> provinces = [];
    for (var provinceJson in json) {
      var province = fromJson(provinceJson);
      provinces.add(province);
    }

    return provinces.reversed.toList();
  }
}

class Ward {
  String code;
  String name;
  int districtId;

  Ward(this.code, this.name, this.districtId);

  static fromJson(Map<String, dynamic> json) {
    return Ward(json['WardCode'], json['WardName'], json['DistrictID']);
  }

  static List<Ward> fromListJson(List<dynamic> json) {
    List<Ward> wards = [];
    for (var wardJson in json) {
      var ward = fromJson(wardJson);
      wards.add(ward);
    }

    return wards;
  }
}
