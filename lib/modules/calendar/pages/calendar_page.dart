import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gotraining/core/utils/colors/app_colors.dart';
import 'package:gotraining/modules/agendamento/stores/agendamento_store.dart';
import 'package:gotraining/modules/calendar/widgets/calendar_item.dart';
import 'package:gotraining/modules/calendar/widgets/menu_buttom_widget.dart';

import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Widget> _buildItem(eventos) {
    List<Widget> list = [];

    var teste = json.encode(eventos);
    var teste2 = json.decode(teste);

    for (var i = 0; i < teste2.length; i++) {
      list.add(
        CalendarItem(myEvents: teste2[i], index: i),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AgendamentoStore>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.colorItem,
        title: const Text(
          "Minha Agenda",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
        Column(
          children: [
            TableCalendar(
              //formato calendario
              availableCalendarFormats: const {
                CalendarFormat.week: 'Mês',
                CalendarFormat.month: 'Semana',
              },
              //localização
              locale: 'pt_BR',
              //ano inicio
              firstDay: DateTime(2022),
              // ano fim
              lastDay: DateTime(2100),
              //dia pra focar
              focusedDay: store.diaFocado,
              //mostra as semanas
              calendarFormat: store.formatoCalendario,
              // dia selecionado no calendario

              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(store.selectedDate, selectedDay)) {
                  setState(() {
                    store.selectedDate = focusedDay;
                    store.diaFocado = selectedDay;
                  });
                }
              },
//bolinha em volta
              selectedDayPredicate: (day) {
                return isSameDay(store.selectedDate, day);
              },
              //alterar o mes pra sema
              onFormatChanged: (format) {
                if (store.formatoCalendario != format) {
                  setState(() {
                    store.formatoCalendario = format;
                  });
                }
              },
              eventLoader: store.listOfDayEvents,
            ),
            Column(
              children: _buildItem(
                store.listOfDayEvents(store.selectedDate),
              ).toList(),
            )
          ],
        ),
      ]),
      floatingActionButton: const MenuButtom(),
    );
  }
}
