import 'package:flutter/material.dart';
import 'package:gotraining/modules/cadastro_reembolso/pages/cadastro_reembolso_page.dart';
import 'package:gotraining/modules/home/widgets/grid_reembolso_widget.dart';

class ReembolsoScreen extends StatelessWidget {
  const ReembolsoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          const GridReembolsoCustom(),
          SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                child: const Text("Cadastrar despesa"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CadastroReembolsoPage()));
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
