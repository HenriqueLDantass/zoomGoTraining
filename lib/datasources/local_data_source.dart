import 'package:gotraining/modules/calendar/models/calendar_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource {
  LocalDataSource();

  Future<void> init() async {
    String path = '';
    path = await getDatabasesPath();
    String dbPath = path + "dboff.db";
    //deleteDatabase(dbPath).then((value) => print("Banco apagado"));
    openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
      CREATE TABLE IF NOT EXISTS agendamento (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        data TEXT,
        loja TEXT,
        parceiros TEXT,
        timeInicio TEXT,
        timeTermino TEXT,
        calendario TEXT,
        local TEXT,
        treinamento TEXT,
        tema TEXT,
        horario TEXT,
        fotos TEXT
      )
  ''');
        db.close();
      },
    );
  }

  Future<List<Map<String, Object?>>> getAgendamentoById(
      String agendamento) async {
    String path = '';

    path = await getDatabasesPath();
    String dbPath = path + "dboff.db";

    Database db = await openDatabase(dbPath);
    var resultar = await db
        .rawQuery("SELECT * FROM agendamento WHERE loja = ?", [agendamento]);

    // db.execute("SELECT * FROM agendamento WHERE nome = ?", [nome]);
    db.close();
    return resultar;
  }

  insertAgendamentoById(CalendarModel calendarModel) async {
    String path = '';

    path = await getDatabasesPath();
    String dbPath = path + "dboff.db";

    Database db = await openDatabase(dbPath);
    db.execute(
        "INSERT INTO agendamento (loja, parceiros, timeInicio, timeTermino, calendario, local, treinamento, tema, horario) VALUES (?,?,?,?,?,?,?,?,?)",
        [
          calendarModel.loja,
          calendarModel.parceiros,
          calendarModel.timeInicio,
          calendarModel.timeTermino,
          calendarModel.calendario,
          calendarModel.local,
          calendarModel.treinamento,
          calendarModel.tema,
          calendarModel.horario,
        ]);
    db.close();
  }
}
