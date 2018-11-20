import 'package:orel_codes_langbattle_daaart_2/orel_codes_langbattle_dart_2.dart' as server;


Future<void> main(List<String> args) async {

  final workerMaxCount = (args.isEmpty)? 2 : int.parse(args[0], radix: 10);
  await server.run(workerMaxCount);

}
