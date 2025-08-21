// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rep_p_mobile/src/common/dados.dart';
import 'package:rep_p_mobile/src/model/marcacao.dart';
import 'package:rep_p_mobile/src/repositories/marcacao.dart';
import 'package:rep_p_mobile/src/ui/cores.dart';
import 'package:rep_p_mobile/src/ui/fonts.dart';
import 'package:rep_p_mobile/src/ui/widgets/button.dart';
import 'package:rep_p_mobile/src/ui/widgets/comprovante.dart';
import 'package:rep_p_mobile/src/ui/widgets/edit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ConsultaMarcacoesTelas extends StatefulWidget {
  const ConsultaMarcacoesTelas({
    super.key,
  });

  @override
  State<ConsultaMarcacoesTelas> createState() => _ConsultaMarcacoesTelasState();
}

List<GetMarcacoesModel> marcacoes = [];
bool solicitouBusca = false;

class _ConsultaMarcacoesTelasState extends State<ConsultaMarcacoesTelas> {
  TextEditingController dataInicioController = TextEditingController();
  TextEditingController dataFimController = TextEditingController();

  Future<void> buscarMarcacoes() async {
    try {
      List<GetMarcacoesModel> resultado = await MarcacaoRepository()
          .getMarcacoesPeriodo(dataInicioController.text,
              dataFimController.text, DadosGlobais.cpfLogin);

      setState(() {
        marcacoes = resultado;
        solicitouBusca = true;
      });
    } catch (e) {
      print('Erro ao buscar marcações: $e');
    }
  }

  //dataInicioController.text =  '${DateTime.now().day - 3}/${DateTime.now().month}/${DateTime.now().year}';

  @override
  Widget build(BuildContext context) {
    DateTime dataAtual = DateTime.now();
    DateTime dataInicio = dataAtual.subtract(Duration(days: 3));

    String formatarData(DateTime data) {
      return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
    }

    if (!solicitouBusca) {
      dataInicioController.text = formatarData(dataInicio);
      dataFimController.text = formatarData(dataAtual);
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: PaletaCores.backgroundWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Selecione o Periodo',
              style: Fonts.textStyleTituloEdit,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EditData(
                controller: dataInicioController,
                titulo: 'Data Inicio',
              ),
              EditData(
                controller: dataFimController,
                titulo: 'Data Fim',
              ),
            ],
          ),
          Center(
            child: ButtonPrimaryInforvix(
              titulo: 'Consultar Marcações',
              funcao: () async {
                if (dataInicioController.text != '' &&
                    dataFimController.text != '') {
                  await buscarMarcacoes();

                  if (marcacoes.isEmpty) {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.info(
                        message: "Não existem marcações no periodo selecionado",
                      ),
                    );
                  }
                } else {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message: "Favor selecionar o periodo",
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: marcacoes.length,
              itemBuilder: (context, index) {
                return ComprovanteWidget(marcacao: marcacoes[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
