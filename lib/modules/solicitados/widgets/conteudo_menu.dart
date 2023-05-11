import 'package:flutter/material.dart';
import 'package:gotraining/modules/agendamento/stores/agendamento_store.dart';
import 'package:gotraining/modules/solicitados/screens/avaliacao_screen.dart';
import 'package:gotraining/modules/solicitados/screens/comentario_screen.dart';
import 'package:gotraining/modules/solicitados/screens/fotos_screen.dart';
import 'package:gotraining/modules/solicitados/screens/logistica_screen.dart';
import 'package:gotraining/modules/solicitados/screens/participantas_screen.dart';
import 'package:gotraining/modules/solicitados/screens/reembolso_screen.dart';
import 'package:gotraining/modules/solicitados/stores/dados_card_store.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConteudoMenu extends StatefulWidget {
  const ConteudoMenu({super.key});

  @override
  State<ConteudoMenu> createState() => _ConteudoMenuState();
}

class _ConteudoMenuState extends State<ConteudoMenu> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<SolicitadosStore>(context);

    return SingleChildScrollView(
      controller: store.scroll,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SolicitadoScreen(),
          AvaliacaoScreen(),
          ReembolsoScreen(),
          LogisticaScreen(),
          FotosScreen(),
          ComentarioScreen()
        ],
      ),
    );
  }
}
