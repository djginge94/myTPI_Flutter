import 'dart:convert';
import 'package:my_tpi/Models/Appliance.dart';
import 'package:http/http.dart' as http;
import 'package:my_tpi/Models/CreateApplianceDTO.dart';

abstract class IApplianceService {
  Future<Appliance> createInspection(CreateApplianceDTO dto);
  Future<List<Appliance>> getInspections();
  Future<bool> deleteInspection(String id);
}

class ApplianceService implements IApplianceService {
  Future<Appliance> createInspection(CreateApplianceDTO dto) async {
    final url =
        "https://us-central1-mytpi-dde27.cloudfunctions.net/api/appliance/inspection";
    final headers = {'Content-Type': 'application/json'};
    final body = dto.toJson();
    final encoding = Encoding.getByName('utf-8');
    final response =
        await http.post(url, headers: headers, body: body, encoding: encoding);
    if (response.statusCode == 201) {
      return Appliance.fromJson(json.decode(response.body));
    }
    throw Exception("Create Insepction Failed");
  }

  Future<List<Appliance>> getInspections() async {
    final url =
        "https://us-central1-mytpi-dde27.cloudfunctions.net/api/appliance/inspection";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map(($0) => Appliance.fromJson($0)).toList();
    }
    throw Exception("Failed To Get Insepctions");
  }

  Future<bool> deleteInspection(String id) async {
    final url =
        "https://us-central1-mytpi-dde27.cloudfunctions.net/api/appliance/inspection/$id";
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
