class CalendarModel {
  String loja;
  String parceiros;
  String solicitante;
  String timeInicio;
  String timeTermino;
  String calendario;
  String local;
  String treinamento;
  String tema;
  String horario;
  int checking;

  CalendarModel({
    required this.loja,
    required this.parceiros,
    required this.solicitante,
    required this.timeInicio,
    required this.timeTermino,
    required this.calendario,
    required this.local,
    required this.treinamento,
    required this.tema,
    required this.horario,
    required this.checking,
  });

  Map<String, dynamic> toJson() {
    return {
      'loja': loja,
      'parceiros': parceiros,
      'solicitante': solicitante,
      'timeInicio': timeInicio,
      'timeTermino': timeTermino,
      'calendario': calendario,
      'local': local,
      'treinamento': treinamento,
      'tema': tema,
      'horario': horario,
      'checking': checking,
    };
  }
}
