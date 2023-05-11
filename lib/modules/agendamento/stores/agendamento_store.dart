import 'package:flutter/material.dart';
import 'package:gotraining/datasources/local_data_source.dart';
import 'package:gotraining/modules/calendar/models/calendar_model.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendamentoStore extends ChangeNotifier {
  int currentStep = 0;
  String? valueBusiess;
  String? valueSolicitante;
  String? valueTreinamento;
  String? valueAvaliacao;
  String? valueParcerias;
  String? valueTema;
  //
  //data hora
  GlobalKey<FormState> globalKeyDataInicio = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeyDataTermino = GlobalKey<FormState>();
  //
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeyTreinamento = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeySolicitante = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeyBusinessCenter = GlobalKey<FormState>();

  //
  final tipoTreinamento = ValueNotifier('');
  final tipoAvaliacaoTreinamento = ValueNotifier('');
  final tipoParceiros = ValueNotifier('');
  final tipoTema = ValueNotifier('');
  final tipoSolicitante = ValueNotifier('');
  final tipoBusinessCenter = ValueNotifier('');
  //
  final lojaController = TextEditingController();
  final pontosController = TextEditingController();
  final limiteIncricoesController = TextEditingController();
  final publicoPrevistoController = TextEditingController();
  final observacaoController = TextEditingController();
  final cargaHorariaController = TextEditingController();
  final solicitanteController = TextEditingController();
  final parceirosController = TextEditingController();
  final controllerTimeInicio = TextEditingController();
  final controllerTimeTermino = TextEditingController();
  final dateCalendarioFormat = TextEditingController();

  final formatCalendar = DateFormat("dd/MM/yyyy");
  final format = DateFormat("HH:mm");

  CalendarFormat formatoCalendario = CalendarFormat.week;
  DateTime diaFocado = DateTime.now();
  late DateTime selectedDate = DateTime.parse(dateCalendarioFormat.text);
  List<CalendarModel> listCalendar = [];
  Map<String, List<CalendarModel>> eventosSelecionados = {};

  void updateSelectedDay(DateTime value) {
    selectedDate = value;
    notifyListeners();
  }

  void updateFocusedDay(DateTime value) {
    diaFocado = value;
    notifyListeners();
  }

  addCalendar(context) {
    if (lojaController.text.isEmpty &&
        solicitanteController.text.isEmpty &&
        parceirosController.text.isEmpty &&
        controllerTimeInicio.text.isEmpty &&
        dateCalendarioFormat.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Algum campo vazio'),
          duration: Duration(seconds: 2),
        ),
      );

      return;
    } else {
      //
      if (eventosSelecionados[DateFormat('yyyy-MM-dd').format(selectedDate)] !=
          null) {
        if (eventosSelecionados[
                DateFormat('yyyy-MM-dd').format(selectedDate)] ==
            null) {
          eventosSelecionados[
              DateFormat('yyyy-MM-dd').format(selectedDate).toString()] = [];
        }
        DateTime horarioAgora =
            DateTime.now().toUtc().subtract(const Duration(hours: 3));
        eventosSelecionados[DateFormat('yyyy-MM-dd').format(selectedDate)]!.add(
          CalendarModel(
            loja: lojaController.text.toString(),
            parceiros: parceirosController.text.toString(),
            solicitante: solicitanteController.text.toString(),
            timeInicio: controllerTimeInicio.text.toString(),
            timeTermino: controllerTimeTermino.text.toString(),
            calendario: dateCalendarioFormat.text.toString(),
            local: valueBusiess.toString(),
            treinamento: valueTreinamento.toString(),
            tema: valueTema.toString(),
            horario: DateFormat('HH:mm').format(horarioAgora),
            checking: 0,
          ),
        );
        notifyListeners();
      } else {
        if (eventosSelecionados[
                DateFormat('yyyy-MM-dd').format(selectedDate)] ==
            null) {
          eventosSelecionados[DateFormat('yyyy-MM-dd').format(selectedDate)] =
              [];
        }
        DateTime horarioAgora =
            DateTime.now().toUtc().subtract(const Duration(hours: 3));
        eventosSelecionados[DateFormat('yyyy-MM-dd').format(selectedDate)] = [
          CalendarModel(
            loja: lojaController.text.toString(),
            parceiros: parceirosController.text.toString(),
            solicitante: solicitanteController.text.toString(),
            timeInicio: controllerTimeInicio.text.toString(),
            timeTermino: controllerTimeTermino.text.toString(),
            calendario: dateCalendarioFormat.text.toString(),
            local: valueBusiess.toString(),
            treinamento: valueTreinamento.toString(),
            tema: valueTema.toString(),
            horario: DateFormat('HH:mm').format(horarioAgora),
            checking: 0,
          )
        ];
        LocalDataSource().insertAgendamentoById(CalendarModel(
          loja: lojaController.text.toString(),
          parceiros: parceirosController.text.toString(),
          solicitante: solicitanteController.text.toString(),
          timeInicio: controllerTimeInicio.text.toString(),
          timeTermino: controllerTimeTermino.text.toString(),
          calendario: dateCalendarioFormat.text.toString(),
          local: valueBusiess.toString(),
          treinamento: valueTreinamento.toString(),
          tema: valueTema.toString(),
          horario: DateFormat('HH:mm').format(horarioAgora),
          checking: 0,
        ));
        notifyListeners();
      }
      lojaController.clear();
      parceirosController.clear();
      solicitanteController.clear();
      dateCalendarioFormat.clear();
      controllerTimeInicio.clear();
      controllerTimeTermino.clear();
      currentStep = 0;
      return;
    }
  }

  continueStep() {
    if (currentStep < 4) {
      currentStep = currentStep + 1;
      notifyListeners();
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      currentStep = currentStep - 1;
      notifyListeners();
    }
  }

  onStepTapped(int value) {
    currentStep = value;
    notifyListeners();
  }

  verificacaoStep(context, details) {
    if (currentStep == 0) {
      controlLocal(context, details);
    } else if (currentStep < 3) {
      controlConcluir(context, details);
    } else {
      controlConcluir(context, details);
    }
  }

  AgendamentoStore() {
    selectedDate = diaFocado;
    notifyListeners();
  }

  List listOfDayEvents(DateTime dateTime) {
    if (eventosSelecionados[DateFormat('yyyy-MM-dd').format(dateTime)] !=
        null) {
      return eventosSelecionados[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  Widget controlLocal(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              if (globalKey.currentState!.validate()) {
                details.onStepContinue();
              }
            },
            child: const Text('Proximo'),
          ),
        ],
      ),
    );
  }

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              if (globalKeyTreinamento.currentState!.validate() &&
                  globalKeySolicitante.currentState!.validate() &&
                  globalKeyBusinessCenter.currentState!.validate() &&
                  globalKeyDataInicio.currentState!.validate() &&
                  globalKeyDataTermino.currentState!.validate()) {
                details.onStepContinue();
              }
            },
            child: const Text('Proximo'),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: details.onStepCancel,
            child: const Text('Voltar'),
          ),
        ],
      ),
    );
  }

  Widget controlConcluir(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              addCalendar(context);
              currentStep = 0;
              Navigator.pop(context);
            },
            child: const Text('Concluir'),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: details.onStepCancel,
            child: const Text('Voltar'),
          ),
        ],
      ),
    );
  }
}
