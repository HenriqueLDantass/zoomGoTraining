import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gotraining/modules/agendamento/stores/agendamento_store.dart';
import 'package:gotraining/modules/solicitados/stores/dados_card_store.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FotosScreen extends StatefulWidget {
  FotosScreen({super.key});

  @override
  State<FotosScreen> createState() => _FotosScreenState();
}

class _FotosScreenState extends State<FotosScreen> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<SolicitadosStore>(context);

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          width: 300,
          height: 300,
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(6, (index) {
              return Center(
                child: store.imagens[index] == null
                    ? Icon(Icons.photo, size: 80)
                    : Image.file(store.imagens[index]!),
              );
            }),
          ),
        ));
  }
}
