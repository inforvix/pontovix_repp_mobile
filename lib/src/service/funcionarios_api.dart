import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rep_p_mobile/src/common/dados.dart';
import 'package:rep_p_mobile/src/model/funcionario.dart';

class FuncionarioApi {
  Future<http.Response> loginFuncionario(
      LoginFuncionarioModel funcionario) async {
    final url = Uri.parse('${DadosGlobais.baseUrl}/funcionario/login');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(funcionario.toJson());

    print(
        'Fazendo requisição de login para URL: ${url.toString()} com corpo: $body');

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final responseBody = json.decode(response.body);

      DadosGlobais.token = responseBody['token'];
      DadosGlobais.cpfLogin = funcionario.cpf!;

      return response;
    } else {
      final responseBody = json.decode(response.body);
      throw Exception(
          'Falha ao fazer login: ${response.statusCode} - ${responseBody['message']}');
    }
  }
}
