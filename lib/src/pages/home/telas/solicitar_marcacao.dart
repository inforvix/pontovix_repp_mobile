import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inforvix_ux/inforvix_ux.dart' as externo;
import 'package:rep_p_mobile/src/repositories/marcacao.dart';
import 'package:rep_p_mobile/src/ui/fonts.dart';
import 'package:rep_p_mobile/src/ui/widgets/button.dart';
import 'package:rep_p_mobile/src/ui/widgets/edit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SolicitarInclusaoMarcacao extends StatefulWidget {
  const SolicitarInclusaoMarcacao({super.key});

  @override
  State<SolicitarInclusaoMarcacao> createState() =>
      _SolicitarInclusaoMarcacaoState();
}

class _SolicitarInclusaoMarcacaoState extends State<SolicitarInclusaoMarcacao> {
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  final TextEditingController _observacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Solicitar Inclusão de Marcação',
                style: Fonts.textStyleTituloEdit,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EditData(
                    titulo: 'Data',
                    controller: _dataController,
                  ),
                  EditHora(
                    titulo: 'Hora',
                    controller: _horaController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: externo.EditMemoInforvix(
                title: 'Observação',
                hintText: 'Ex: Problemas com a internet',
                controller: _observacaoController,
              ),
            ),
            const Spacer(),
            ButtonPrimaryInforvix(
              titulo: 'Solicitar Inclusão',
              funcao: () async {
                if (_dataController.text.isEmpty ||
                    _horaController.text.isEmpty) {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message: "Por favor, preencha todos os campos.",
                    ),
                  );
                } else {
                  MarcacaoRepository().solicitarMarcacao(
                      data: _dataController.text,
                      hora: _horaController.text,
                      observacao: _observacaoController.text);

                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.success(
                      message: "Solicitação enviada com sucesso!",
                    ),
                  );

                  _observacaoController.clear();
                  _dataController.clear();
                  _horaController.clear();
                }
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
