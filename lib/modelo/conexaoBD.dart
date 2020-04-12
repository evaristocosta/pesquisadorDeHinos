import 'dart:io';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

Future<String> conexaoBD() async {
  var bdCaminho = await getDatabasesPath();
  var caminho = join(bdCaminho, "pesquisadorHinos.db");

  // Make sure the parent directory exists
  try {
    await Directory(dirname(caminho)).create(recursive: true);
  } catch (_) {}

  // Copy from asset
  ByteData data = await rootBundle.load(join("assets", "pesquisadorHinos.db"));
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  // Write and flush the bytes written
  await File(caminho).writeAsBytes(bytes, flush: true);

  return caminho;
}
