import 'dart:io' as io;
import 'dart:isolate' as iso;
import 'dart:convert' as conv;

import 'package:crypto/crypto.dart' as cryp;
import 'package:date_format/date_format.dart' as format;


Future<void> run(int workerMaxCount) async {

  final isolates = <Map<String, dynamic>>[];

  for (var i = 0; i < workerMaxCount; i++) {
    var reader = iso.ReceivePort();
    await iso.Isolate.spawn(_handler, reader.sendPort);
    final writer = await reader.first;
    isolates.add({
      'w': writer,
      'rs': [],
    });
    reader = iso.ReceivePort();
    writer.send(reader.sendPort);
    reader.listen((jsonData) async {
      isolates[i]['rs'][0].headers.contentType = io.ContentType.json;
      isolates[i]['rs'][0].write(conv.json.encode(jsonData));
      await isolates[i]['rs'][0].close();
      isolates[i]['rs'].removeAt(0);
    });
  }

  print('Starting server with $workerMaxCount workers (CTRL+C to stop)...');
  final httpServer = await io.HttpServer.bind(io.InternetAddress.loopbackIPv4, 8080);

  io.ProcessSignal.sigint.watch().listen((io.ProcessSignal signal) async {
    print('Stoping server...');
    await httpServer.close(force: true);
    io.exit(0);
  });

  var isolateNumber = 0;

  httpServer.listen((io.HttpRequest request) async {
    if (request.method != 'POST') {
      await request.response.close();
      return;
    }
    isolates[isolateNumber]['rs'].add(request.response);
    isolates[isolateNumber]['w'].send(await request.single);
    isolateNumber++;
    if (isolateNumber >= workerMaxCount) isolateNumber = 0;
  });

}


Future<void> _handler(iso.SendPort writer) async {

  final reader = iso.ReceivePort();
  writer.send(reader.sendPort);

  await for (var data in reader) {
    if (data is iso.SendPort) {
      writer = data;
    } else {
      final jsonData = conv.json.decode(conv.utf8.decode(data));
      final firstNameMD5 = cryp.md5
                               .convert(conv.utf8.encode(jsonData['first_name']))
                               .bytes
                               .map((int byte) => byte.toRadixString(16))
                               .join('');
      jsonData['first_name'] += firstNameMD5;
      final lastNameMD5 = cryp.md5
                              .convert(conv.utf8.encode(jsonData['last_name']))
                              .bytes
                              .map((int byte) => byte.toRadixString(16))
                              .join('');
      jsonData['last_name'] += lastNameMD5;
      final dateFormat = [
        format.yyyy, '-', format.m, '-', format.dd,
        ' ',
        format.HH, ':', format.nn, ':', format.ss,
        ' ',
        format.z
      ];
      jsonData['current_time'] = format.formatDate(DateTime.now(), dateFormat);
      jsonData['say'] = 'Dart is beautiful !';
      writer.send(jsonData);
    }
  }

}
