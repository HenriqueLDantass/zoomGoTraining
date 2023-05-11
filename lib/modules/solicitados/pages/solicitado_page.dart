import 'package:flutter/material.dart';
import 'package:gotraining/core/utils/colors/app_colors.dart';
import 'package:gotraining/modules/solicitados/widgets/card_grey_widget.dart';
import 'package:gotraining/modules/solicitados/widgets/checkout_widget.dart';
import 'package:gotraining/modules/solicitados/widgets/conteudo_menu.dart';
import 'package:gotraining/modules/solicitados/widgets/flotingacitonbutton_widget.dart';
import 'package:gotraining/modules/solicitados/widgets/header_solicitado.dart';
import 'package:gotraining/modules/solicitados/widgets/scroll_titulo_widget.dart';
import 'package:gotraining/modules/agendamento/stores/agendamento_store.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SolicitadoPage extends StatefulWidget {
  final int index;
  const SolicitadoPage({
    super.key,
    required this.index,
  });

  @override
  State<SolicitadoPage> createState() => _TestePageState();
}

class _TestePageState extends State<SolicitadoPage> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AgendamentoStore>(context);
    var lista = store.eventosSelecionados[
        DateFormat('yyyy-MM-dd').format(store.selectedDate)]!;

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          const HeaderSolicitadoWidget(),
          Positioned(
            top: 80,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        lista[widget.index].loja,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                      child: Text(
                          "${lista[widget.index].calendario} - ${lista[widget.index].timeInicio} às ${lista[widget.index].timeTermino}"),
                    ),
                    CardGreyWidget(
                      local: lista[widget.index].local,
                      tema: lista[widget.index].tema,
                      treinamento: lista[widget.index].treinamento,
                    ),
                    const ScrollTitulo(),
                    ConteudoMenu(),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ]),
            ),
          ),
        ]),
      ),
      floatingActionButton: lista[widget.index].checking == 0
          ? FloatingActionButton(
              backgroundColor: ColorsApp.colorItem,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Iniciar Treinamento'),
                      content: const Text(
                          'Deseja confirmar o início do treinamento nesta data e horário?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('CANCELAR'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              lista[widget.index].checking = 1;
                            });

                            // localizacao
                            Navigator.of(context).pop();
                          },
                          child: const Text('CONFIRMAR'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.location_on),
            )
          : lista[widget.index].checking == 1
              ? FlotingActionButtonCustom(
                  onpressed: () {
                    setState(() {
                      lista[widget.index].checking = 2;
                      Navigator.of(context).pop();
                    });
                  },
                )
              : const Checkout(),
    );
  }
}
