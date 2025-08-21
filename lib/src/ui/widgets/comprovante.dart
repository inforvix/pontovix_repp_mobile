import 'package:flutter/material.dart';
import 'package:inforvix_ux/inforvix_ux.dart';
import 'package:rep_p_mobile/src/model/marcacao.dart';
import 'package:rep_p_mobile/src/repositories/marcacao.dart';
import 'package:rep_p_mobile/src/ui/cores.dart';
import 'package:rep_p_mobile/src/ui/fonts.dart';
import 'package:rep_p_mobile/src/ui/widgets/button.dart';
import 'package:rep_p_mobile/src/ui/widgets/titulo_data.dart';
import 'package:svg_flutter/svg.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ComprovanteWidget extends StatefulWidget {
  const ComprovanteWidget({
    super.key,
    required this.marcacao,
  });

  final GetMarcacoesModel marcacao;

  @override
  State<ComprovanteWidget> createState() => _ComprovanteWidgetState();
}

class _ComprovanteWidgetState extends State<ComprovanteWidget> {
  final TextEditingController memoInforvix = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 10,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Text('justificar Marcação',
                          style: Fonts.textStyleTituloHoras),
                      SizedBox(height: 10),
                      EditMemoInforvix(
                        title: 'Digite uma observação para esta marcação',
                        controller: memoInforvix,
                        hintText: 'Ex: tive problemas de saúde',
                      )
                    ],
                  ),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: ButtonPrimaryInforvix(
                            titulo: 'Cancelar',
                            funcao: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ButtonPrimaryInforvix(
                            titulo: 'Salvar',
                            funcao: () async {
                              try {
                                if (memoInforvix.text.isEmpty) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.info(
                                      message: "Observação não pode ser vazia",
                                    ),
                                  );
                                  return;
                                }

                                await MarcacaoRepository().justificarMarcacao(
                                    nsr: widget.marcacao.nsr!,
                                    cpf: widget.marcacao.cpf,
                                    hora: widget.marcacao.hora,
                                    observacao: memoInforvix.text);

                                memoInforvix.clear();

                                Navigator.of(context).pop();
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                    message: "Observação salva com sucesso",
                                  ),
                                );
                              } catch (e) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: "Erro ao salvar observação",
                                  ),
                                );
                                return;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: PaletaCores.backgroundWhiteSolid,
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Text(
                      widget.marcacao.hora ?? '',
                      style: Fonts.textStyleTituloHoras,
                    ),
                    SizedBox(height: 3),
                    BagdeDyaOfWeek(day: widget.marcacao.data ?? ''),
                  ],
                ),
                Spacer(),
                SvgPicture.asset(
                  'assets/icons/comprovante.svg',
                  height: 38,
                  width: 38,
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
