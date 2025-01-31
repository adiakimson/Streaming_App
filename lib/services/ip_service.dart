import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IpService {
  Future<String> getPublicIp() async {
    final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['ip'];
    } else {
      throw Exception('Failed to get public IP');
    }
  }

  Future<String> getLocalIp() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4) {
          return addr.address;
        }
      }
    }
    throw Exception('Failed to get local IP');
  }
}