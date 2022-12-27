import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FDatabase {
  ///Handle all database functions
  ///
  ///


  Future<bool> tableExists(String tableName) async {
    /// Check if table exists
    ///

    String path = await getDatabasesPath();
    String finalPath = join(path, 'questions.db');
    final db = await openDatabase(finalPath);

    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [tableName]);

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkIfTableExists(String tableName) async {
    if (await tableExists(tableName)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> createDatabaseAndTables(String tableName) async {
    ///Create the required database and tables.
    try {
      String path = await getDatabasesPath();
      String finalPath = join(path, 'questions.db');
      final db = await openDatabase(finalPath);

       await db.execute('CREATE TABLE $tableName ('
            'id INTEGER AUTO INCREMENT PRIMARY KEY, '
            'question TEXT NOT NULL,'
            'answer TEXT NOT NULL,'
            'options TEXT NOT NULL,'
            'answerIndex TEXT NOT NULL'
            ')');
        // return false;
      
    } catch (e) {
      print("Error creating table or database $e");
      // return false;
    }
  }

  Future<void> addQuestionsToTable(String tableName) async {
    ///Add the questions to the table
    ///
    ///

    try {
      String path = await getDatabasesPath();
      String finalPath = join(path, 'questions.db');
      final db = await openDatabase(finalPath);
      Batch batch = db.batch();

      batch.insert(
          tableName,
          {
            'question': 'What is ges100',
            'answer': 'It is introduction to english',
            'options':
                'It is introduction to english|It is a language|It is math|It is jargons',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'what type of thing is Uniport',
            'answer': 'A noun',
            'options':
                'It is a verb|It is a school|It is language|It is a noun',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'What is ges100',
            'answer': 'Is maxwell a person',
            'options': 'No|yes|No Answer',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      var results = await batch.commit();
      // return true;
    } catch (e) {
      // print('Error inserting questions to the table $e');
      // return false;
    }
  }

  static Future<int> countQuestions(String tableName) async {
    ///Count the number of questions in the table
    ///

    String path = await getDatabasesPath();
    String finalPath = join(path, 'questions.db');
    final db = await openDatabase(finalPath);

    try {
      List<Map<String, dynamic>> numberOfQuestions =
          await db.rawQuery('SELECT COUNT(*) FROM $tableName');
      // print("the result is ${numberOfQuestions[0]['COUNT(*)']}");
      return numberOfQuestions[0]['COUNT(*)'];
    } catch (e) {
      print("Error counting the number of questions $e");
      return 0;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchQuestions(
      String tableName) async {
    ///Fetch all questions from the specific table
    ///

    String path = await getDatabasesPath();
    String finalPath = join(path, 'questions.db');
    final db = await openDatabase(finalPath);

    try {
      List<Map<String, dynamic>> questions = await db.query(tableName);
      // print("the questions is $questions");
      return questions;
    } catch (e) {
      print("Error fetching questions from the table $e");
      return [];
    }
  }

  // static Future<bool> checkAnswer(int chosenIndex)
}
