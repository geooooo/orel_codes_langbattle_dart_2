import 'dart:io' as io;
import 'dart:convert' as conv;


void main(List<String> args) {

  final requestCount =  (args.isEmpty)? 2 : int.parse(args[0], radix: 10);

  for (var i = 0; i < requestCount; i++) {
    final httpClient = io.HttpClient();
    httpClient.post('localhost', 8080, '').then((request) async {
      request.write(conv.jsonEncode({
        'id': 'id',
        'first_name': 'firstname',
        'last_name': 'lastname'
      }));
      final response = await request.close();
      final jsonData = conv.utf8.decode(await response.single);
      print('');
      print(response.headers.contentType);
      print(jsonData);
      print('');
      httpClient.close();
    });
  }

}
