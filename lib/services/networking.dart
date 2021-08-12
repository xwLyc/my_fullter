import 'dart:io';
import 'dart:convert';

var httpClient = new HttpClient();

class NetworkHelper {
  Future getData(url) async {
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        return data;
      } else {
        return {'code': response.statusCode};
      }
    } catch (e) {
      return {'code': 0};
    }
  }
}
