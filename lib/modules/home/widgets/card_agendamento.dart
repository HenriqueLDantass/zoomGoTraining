import 'package:flutter/material.dart';
import 'package:gotraining/modules/agendamento/stores/agendamento_store.dart';
import 'package:provider/provider.dart';

class CardAgenamento extends StatelessWidget {
  const CardAgenamento({super.key});

  @override
  Widget build(BuildContext context) {
    var agendamentoStore = Provider.of<AgendamentoStore>(context);
    DateTime time = DateTime.now();
    return Column(
      children: [
        if (agendamentoStore.listOfDayEvents(time).isEmpty)
          const Text(
            "Nenhum agendamento encontrado.",
            style: TextStyle(
              fontSize: 18,
            ),
          )
        else
          ...agendamentoStore.listOfDayEvents(DateTime.now()).map((myEvents) =>
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 5,
                              height: 120,
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                  ))),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10.0,
                                      spreadRadius: 3.0,
                                      offset: const Offset(0.3, 2.0),
                                    )
                                  ],
                                ),
                                height: 120,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${myEvents.loja}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${myEvents.timeInicio} às ${myEvents.timeTermino}'),
                                          Column(
                                            children: [
                                              const Text("0 Pessoas",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  )),
                                              Text(
                                                '${myEvents.local}',
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 110, 109, 109),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Tema: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("${myEvents.tema}'")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ])
                  ],
                ),
              ))
      ],
    );
  }
}
