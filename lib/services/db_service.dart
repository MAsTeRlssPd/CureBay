import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB('curebay_patients.db');
    return _db!;
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE patients (
  id $idType,
  name $textType,
  age $intType,
  gender $textType
)
''');

    await db.execute('''
CREATE TABLE assessments (
  id $idType,
  patient_id $intType,
  timestamp $textType,
  symptoms $textType,
  diagnosis $textType,
  risk_level $textType
)
''');
  }

  Future<void> insertPatient(Map<String, dynamic> patient) async {
    final db = await database;
    await db.insert('patients', patient);
  }

  Future<void> insertAssessment(Map<String, dynamic> assessment) async {
    final db = await database;
    await db.insert('assessments', assessment);
  }
}
