import 'package:masterapp/dbconnection/dbConnectionHelper.dart';
import 'package:masterapp/entity/person.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';

class PersonDao {
//Kişileri Listeleme
  Future<List<Person>> allPerson() async {
    var db = await DbConnectionHelper.dbAccess();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("Select * from persons");

    print("//\\'allPerson' çalışıyor");

    return List.generate(maps.length, (p) {
      var line = maps[p];
      return Person(
          id: line["person_id"],
          name: line["person_name"],
          lastname: line["person_lastName"],
          num: line["person_num"]);
    });
  }

//Kişi ekleme
  Future<void> addPerson(String personName, String personLastname,
      String personNum, String? personMail, String? personCompany) async {
    var db = await DbConnectionHelper.dbAccess();
    // var personInfo = Map<String, dynamic>();
    Map<String, dynamic> personInfo = {};

    personInfo["person_name"] = personName;
    personInfo["person_lastName"] = personLastname;
    personInfo["person_num"] = personNum;

    await db.insert("persons", personInfo);
  }

//Kişi Arama
  Future<List<Person>> searchPerson(String searchWord) async {
    var db = await DbConnectionHelper.dbAccess();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "select * from persons where person_name like '%$searchWord%'");

    return List.generate(maps.length, (p) {
      var line = maps[p];
      return Person(
          id: line["person_id"],
          name: line["person_name"],
          lastname: line["person_lastName"],
          num: line["person_num"]);
    });
  }

  //Kişi güncelleme
  Future<void> personUpdate(
      int personId, String personName, String personLastname, String personNum,
      {String personMail = "", String personCompany = " "}) async {
    var db = await DbConnectionHelper.dbAccess();
    Map<String, dynamic> personInfo = {};
    personInfo["person_name"] = personName;
    personInfo["person_lastName"] = personLastname;
    personInfo["person_num"] = personNum;
    personInfo["person_mail"] = personMail;
    personInfo["person_company"] = personCompany;

    await db.update("persons", personInfo,
        where: "person_id=?", whereArgs: [personId]);
  }

  //Kişi Sil
  Future<void> personDelete(int personId) async {
    var db = await DbConnectionHelper.dbAccess();
    await db.delete("persons", where: "person_id=?", whereArgs: [personId]);
  }

//Eklenen son kişiyi çekme
  Future<List<Person>> getByIdPerson() async {
    var db = await DbConnectionHelper.dbAccess();
    List<Map<String, dynamic>> map =
        (await db.rawQuery("SELECT * FROM persons ORDER BY 1 DESC limit 1;"));

/*  Future<Person> getByIdPerson() async {
    var db = await dbConnectionHelper.dbAccess();
    List<Map<String, dynamic>> map =
        (await db.rawQuery("SELECT * FROM persons ORDER BY 1 DESC limit 1;"));

    var line = map[0];
    return Person(
        id: line["person_id"],
        name: line["person_name"],
        lastname: line["person_lastName"],
        num: line["person_num"]);
*/
/* Future<List<Person>> getByIdPerson() async {
    var db = await dbConnectionHelper.dbAccess();
    List<Map<String, dynamic>> map =
        (await db.rawQuery("SELECT * FROM persons ORDER BY 1 DESC limit 1;"));
*/
    return List.generate(map.length, (p) {
      var line = map[p];
      return Person(
          id: line["person_id"],
          name: line["person_name"],
          lastname: line["person_lastName"],
          num: line["person_num"]);
    });

    /*  // var line = map;
    // return Person(
    //     id: line["person_id"],
    //     name: line["person_name"],
    //     lastname: line["person_lastName"],
    //     num: line["person_num"]);
  */
  }

  Future<Person> getByContact() async {
    var db = await DbConnectionHelper.dbAccess();
    List<Map<String, dynamic>> map =
        (await db.rawQuery("SELECT * FROM persons ORDER BY 1 DESC limit 1;"));

    var line = map[0];
    return Person(
        id: line["person_id"],
        name: line["person_name"],
        lastname: line["person_lastName"],
        num: line["person_num"]);
  }
}
