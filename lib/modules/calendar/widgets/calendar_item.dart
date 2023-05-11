import 'package:flutter/material.dart';
import 'package:gotraining/modules/solicitados/pages/solicitado_page.dart';
import 'package:gotraining/modules/agendamento/widgets/linha_com_bolinha.dart';

class CalendarItem extends StatefulWidget {
  final dynamic myEvents;
  final int index;
  const CalendarItem({super.key, this.myEvents, required this.index});

  @override
  State<CalendarItem> createState() => _CalendarItemState();
}

class _CalendarItemState extends State<CalendarItem> {
  bool check = false;

  checking() {
    setState(() {
      check = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SolicitadoPage(index: widget.index),
        ));
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 12, right: 3),
            child: SizedBox(
              width: 50,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  children: [
                    Text(
                      '${widget.myEvents['timeInicio']}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.myEvents['treinamento']}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const LinhaComBolinha(),
          Container(
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0),
                )),
            width: 7,
            height: 120,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.myEvents['loja']}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${widget.myEvents['timeInicio']} às ${widget.myEvents['timeTermino']}'),
                          Column(
                            children: [
                              const Text("0 Pessoas",
                                  style: TextStyle(
                                    fontSize: 12,
                                  )),
                              Text(
                                '${widget.myEvents['local']} ',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 110, 109, 109),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tema: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('${widget.myEvents['tema']}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
