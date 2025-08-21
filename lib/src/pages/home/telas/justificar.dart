import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inforvix_ux/inforvix_ux.dart' as externo;
import 'package:rep_p_mobile/src/ui/fonts.dart';
import 'package:rep_p_mobile/src/ui/widgets/button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';

class JustificarPage extends StatefulWidget {
  const JustificarPage({super.key});

  @override
  State<JustificarPage> createState() => _JustificarPageState();
}

class _JustificarPageState extends State<JustificarPage> {
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
                'Registrar Justificativa',
                style: Fonts.textStyleTituloEdit,
              ),
            ),
            externo.EditInforvix(
                controller: TextEditingController(),
                title: 'Tipo de Justificativa *',
                hintText: 'Ex: Atestado, Declaração, etc.'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: externo.EditMemoInforvix(
                title: 'Observação *',
                hintText: 'Ex: Problemas com a internet',
                controller: _observacaoController,
              ),
            ),
            const SizedBox(height: 20),
            ButtonPrimaryInforvix(
              titulo: 'Anexar Arquivo *',
              funcao: () async {
                // final uploadInput = html.FileUploadInputElement();
                // uploadInput.accept =
                //     'image/*,application/pdf'; // aceita imagens e pdfs
                // uploadInput.click();

                // uploadInput.onChange.listen((event) {
                //   final files = uploadInput.files;
                //   if (files != null && files.isNotEmpty) {
                //     final file = files.first;

                //     print('Arquivo selecionado: ${file.name}');
                //   }
                // });
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message:
                        "Módulo em desenvolvimento, em breve função estara disponivel!",
                  ),
                );
              },
            ),
            const Spacer(),
            ButtonPrimaryInforvix(
              titulo: 'Solicitar Inclusão',
              funcao: () async {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message:
                        "Módulo em desenvolvimento, em breve função estara disponivel!",
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
