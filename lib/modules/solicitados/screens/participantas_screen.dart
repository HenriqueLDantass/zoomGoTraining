import 'package:flutter/material.dart';
import 'package:gotraining/modules/agendamento/stores/agendamento_store.dart';
import 'package:gotraining/modules/solicitados/stores/dados_card_store.dart';
import 'package:gotraining/modules/solicitados/widgets/card_participantes_com_modal.dart';
import 'package:gotraining/modules/solicitados/widgets/card_participantes_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SolicitadoScreen extends StatefulWidget {
  const SolicitadoScreen({super.key});

  @override
  State<SolicitadoScreen> createState() => _SolicitadoScreenState();
}

class _SolicitadoScreenState extends State<SolicitadoScreen> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AgendamentoStore>(context);
    var lista = store.eventosSelecionados[
        DateFormat('yyyy-MM-dd').format(store.selectedDate)]!;

    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("0 Realizado"),
              Text("0 Previsto"),
              Text("0 Limite"),
            ],
          ),
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
              child: Text('Cadastre os participantes'),
            ),
            CardParticipantesWidget(),

            //CardPrticipantesWidget(),
          ],
        ),
      ],
    );
  }
}
