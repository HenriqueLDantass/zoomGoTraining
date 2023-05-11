import 'package:flutter/material.dart';
import 'package:gotraining/core/test/stores/teste_store.dart';
import 'package:gotraining/datasources/local_data_source.dart';
import 'package:gotraining/modules/calendar/models/calendar_model.dart';
import 'package:provider/provider.dart';

class TestePage extends StatelessWidget {
  const TestePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<TestStore>(context);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              LocalDataSource().init();
            },
            child: Text("Criar"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("inserir"),
          ),
          ElevatedButton(
            onPressed: () async {
              var resultado =
                  await LocalDataSource().getAgendamentoById("henrique");

              store.setList(resultado);
            },
            child: Text("pegar"),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: store.lista.length,
              itemBuilder: (context, i) => Text(store.lista[i]['local'] +
                  " " +
                  store.lista[i]['treinamento'] +
                  " " +
                  store.lista[i]['tema'] +
                  " " +
                  store.lista[i]['parceiros']),
            ),
          )
        ],
      )),
    );
  }
}
