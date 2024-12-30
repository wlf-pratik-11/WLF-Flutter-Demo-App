import 'package:sqflite/sqflite.dart' as sql;
class SqfliteDemoScreenRepo {

    static Future<void> createTable(sql.Database database) async{
      await database.execute(
        """CREATE TABLE "contact"(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          name TEXT,
          mobile TEXT,
          img TEXT
        )""");
    }

    static Future<sql.Database> db() async{
      return sql.openDatabase("userContacts.db",version: 1,onCreate:(sql.Database database,int version) async{
          await createTable(database);
      },);
    }

    static Future<int> addNewContact(String name,String mobile,String img)async{

      final db = await SqfliteDemoScreenRepo.db();

      final data = {
        "name" : name,
        "mobile" : mobile,
        "img" : img,
      };
      final id = await db.insert("contact", data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
      return id;
    }

    static Future<List<Map<String,dynamic>>> getAllContacts() async{
      final db = await SqfliteDemoScreenRepo.db();
      return db.query("contact",orderBy: "name");
    }

    static Future<List<Map<String, dynamic>>> getContactById(int id) async {
      final db = await SqfliteDemoScreenRepo.db();
      return db.query('contact', where: "id = ?", whereArgs: [id], limit: 1);
    }

    static Future<int> updateContact(int id,String name,String mobile,String img)async{
      final db = await SqfliteDemoScreenRepo.db();
      final data = {
        "name" : name,
        "mobile" : mobile,
        "img" : img,
      };

      final result = await db.update("contact", data,where: "id = ?",whereArgs: [id]);

      return result;
    }

    static Future<void> deleteContact(int id) async {
      final db = await SqfliteDemoScreenRepo.db();
      try{
        await db.delete("contact",where: "id = ?",whereArgs: [id]);
      }catch(err){
        print("Something went wrong while delete : $err");
      }
    }
}