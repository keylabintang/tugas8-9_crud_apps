import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database = await openDatabase(path,
        version: 2, onCreate: _createDatabase, onUpgrade: _onUpgrade);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String createTableSql =
        "CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,contact TEXT,description TEXT);";
    await database.execute(createTableSql);
  }

  Future<void> _onUpgrade(
      Database database, int oldVersion, int newVersion) async {
    // If you need to add a new column, you can do it here
    if (oldVersion == 1 && newVersion == 2) {
      String addColumnSql = "ALTER TABLE users ADD COLUMN address TEXT;";
      await database.execute(addColumnSql);
    }
  }
}
