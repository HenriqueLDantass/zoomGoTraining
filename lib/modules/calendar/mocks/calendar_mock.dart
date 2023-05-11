//simula uma requisição
import 'package:gotraining/modules/calendar/models/calendar_model.dart';

class CalendarMock {
  List<CalendarModel> get() {
    List<CalendarModel> list = [];
    list.add(
      CalendarModel(
        loja: "loja",
        parceiros: "parceiros",
        solicitante: "solicitante",
        timeInicio: "timeInicio",
        timeTermino: "timeTermino",
        calendario: "calendario",
        local: "local",
        treinamento: "treinamento",
        tema: "tema",
        horario: "horario",
        checking: 0,
      ),
    );
    return list;
  }
}
