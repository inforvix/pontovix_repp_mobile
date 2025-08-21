import 'package:rep_p_mobile/src/common/funcoes_globais.dart';
import 'package:rep_p_mobile/src/model/marcacao.dart';
import 'package:rep_p_mobile/src/service/registrar_marcacao.dart';

class MarcacaoRepository {
  Future<void> registrarMarcacao(
      {required double latidude, required double longitude}) async {
    try {
      await MarcacaoApi().marcacaoToken(latidude, longitude);
    } catch (e) {
      print('Erro ao adicionar despesa: $e');
    }
  }

  Future<void> justificarMarcacao(
      {required String nsr, cpf, hora, observacao}) async {
    try {
      await MarcacaoApi().justificarMarcacao(nsr, cpf, hora, observacao);
    } catch (e) {
      print('Erro ao adicionar despesa: $e');
    }
  }

  Future<void> solicitarMarcacao(
      {required String data, hora, observacao}) async {
    try {
      data = FuncoesGlobais.formatarDataYYYYMMDD(data);
      await MarcacaoApi().solicitarMarcacao(data, hora, observacao);
    } catch (e) {
      print('Erro ao adicionar despesa: $e');
    }
  }

  Future<List<GetMarcacoesModel>> getMarcacoes(String cpf) async {
    try {
      return await MarcacaoApi().buscarMarcacoesDia(cpf);
    } catch (e) {
      throw Exception('Erro ao buscar marcações');
    }
  }

  Future<List<GetMarcacoesModel>> getMarcacoesPeriodo(
      String dataIni, dataFim, cpf) async {
    try {
      dataIni = FuncoesGlobais.formatarDataYYYYMMDD(dataIni);
      dataFim = FuncoesGlobais.formatarDataYYYYMMDD(dataFim);
      return await MarcacaoApi()
          .buscarMarcacoesPorPeriodo(dataIni, dataFim, cpf);
    } catch (e) {
      throw Exception('Erro ao buscar marcações');
    }
  }
}
