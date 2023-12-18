import '../../../common/api.dart';
import '../../../constants/api_endpoints.dart';
import '../../../models/address.dart';
import '../../../models/data_result.dart';
import '../../../models/division.dart';
import '../../../models/response_status.dart';

class AddressRepo {
  AddressRepo._();

  static Future<DataResult> getDivisions() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.getDivisions, true);

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => Division.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> getAddresses() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.getAddresses, true);

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => Address.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> deleteAddress(String id) async {
    final DataResult dataResult = DataResult();

    final result = await Api.delete(ApiEndPoints.deleteAddress(id));

    if (result.error == null) {
      final json = result.json != null ? result.json as Map<String, dynamic> : <String, dynamic>{};

      dataResult.data = ResponseStatus.fromJson(json);
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> createAddress(String body) async {
    final DataResult dataResult = DataResult();

    final result = await Api.post(ApiEndPoints.createAddress, body);

    if (result.error == null) {
      final json = result.json != null ? result.json as Map<String, dynamic> : <String, dynamic>{};

      dataResult.data = ResponseStatus.fromJson(json);
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }
}
