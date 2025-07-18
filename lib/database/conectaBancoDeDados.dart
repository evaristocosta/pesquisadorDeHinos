import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

Future<String> conectaBancoDeDados() async {
  var bdCaminho = await getDatabasesPath();
  var caminho = join(bdCaminho, "pesquisadorHinos_v2.db");

  // Make sure the parent directory exists
  try {
    await Directory(dirname(caminho)).create(recursive: true);
  } catch (_) {}

  // Copy from asset
  ByteData data =
      await rootBundle.load(join("assets/database", "pesquisadorHinos_v2.db"));
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  // Write and flush the bytes written
  await File(caminho).writeAsBytes(bytes, flush: true);

  return caminho;
}
