import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DbConnectionHelper {
  static const String dbName = "person.sqlite";

  static Future<Database> dbAccess() async {
    //1. Yöntem - rootBundle.load() yöntemi
    String dbUrl = join(
        await /*databasein yolunun almayı sağlar :*/ getDatabasesPath(),
        /*veritabanı adı:*/ dbName);
    if (await /*verilen yolda db var mı yokmu kontrolü yapar*/ databaseExists(
        dbUrl)) {
      print("Veritabanı var, kopyalama yapılmayacak.");
    } else {
      ByteData data = await rootBundle.load(
          /*rootbundle ile db nesnesine ulaşım sağlıyor */
          "database/$dbName"); //db yi telefona kopyalamak için byte olarak data çevirme işlemi yapılıyor.
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbUrl).writeAsBytes(bytes, flush: true);
      print("Veritabanı kopyalandı!");
    }
    return openDatabase(dbUrl);

    //2. Bir Yönet - File.fromUri() yöntemi
  }
}
