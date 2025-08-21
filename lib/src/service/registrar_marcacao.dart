import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rep_p_mobile/src/common/dados.dart';
import 'package:rep_p_mobile/src/model/marcacao.dart';

class MarcacaoApi {
  Future<http.Response> marcacaoToken(double lat, lon) async {
    final url = Uri.parse('${DadosGlobais.baseUrl}/marcacao/registraToken');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${DadosGlobais.token}'
    };

    final body = jsonEncode({
      'latitude': lat,
      'longitude': lon,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      DadosGlobais.marcacaoRegistrada = true;
      return response;
    } else {
      DadosGlobais.marcacaoRegistrada = false;
      throw Exception('Falha ao fazer login: ${response.statusCode}');
    }
  }

  Future<http.Response> justificarMarcacao(
      String nsr, cpf, hora, observacao) async {
    final url = Uri.parse('${DadosGlobais.baseUrl}/marcacao/observacao');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${DadosGlobais.token}'
    };

    final body = jsonEncode({
      'nsr': nsr,
      'cpf': cpf,
      'hora': hora,
      'observacao': observacao,
    });

    final response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      DadosGlobais.marcacaoRegistrada = true;
      return response;
    } else {
      DadosGlobais.marcacaoRegistrada = false;
      throw Exception('Falha ao fazer login: ${response.statusCode}');
    }
  }

  Future<http.Response> solicitarMarcacao(String data, hora, observacao) async {
    final url =
        Uri.parse('${DadosGlobais.baseUrl}/marcacao-solicitada/solicitar');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${DadosGlobais.token}'
    };

    final body = jsonEncode({
      'data': data,
      'hora': hora,
      'observacao': observacao,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      DadosGlobais.marcacaoRegistrada = true;
      return response;
    } else {
      DadosGlobais.marcacaoRegistrada = false;
      throw Exception('Falha ao fazer login: ${response.statusCode}');
    }
  }

  Future<List<GetMarcacoesModel>> buscarMarcacoesDia(String cpf) async {
    final url = Uri.parse('${DadosGlobais.baseUrl}/marcacao/dia/$cpf');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${DadosGlobais.token}'
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['marcacoes'] != null) {
        List<dynamic> marcacoesList = jsonResponse['marcacoes'];
        return marcacoesList
            .map((json) => GetMarcacoesModel.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception(
          'Falha ao buscar marcações do dia: ${response.statusCode}');
    }
  }

  Future<List<GetMarcacoesModel>> buscarMarcacoesPorPeriodo(
      String dataIni, dataFim, cpf) async {
    final url =
        Uri.parse('${DadosGlobais.baseUrl}/marcacao/$dataIni/$dataFim/$cpf');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${DadosGlobais.token}'
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['marcacoes'] != null) {
        List<dynamic> marcacoesList = jsonResponse['marcacoes'];
        return marcacoesList
            .map((json) => GetMarcacoesModel.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception(
          'Falha ao buscar marcações do dia: ${response.statusCode}');
    }
  }
}
