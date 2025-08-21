import 'package:intl/intl.dart';

class FuncoesGlobais {
  static formatarDataYYYYMMDD(String dataOriginal) {
    DateFormat formatadorOriginal = DateFormat("dd/MM/yyyy");
    DateTime dataConvertida = formatadorOriginal.parse(dataOriginal);

    DateFormat formatadorNovo = DateFormat("yyyy-MM-dd");
    String dataFormatada = formatadorNovo.format(dataConvertida);
    return dataFormatada;
  }

  static String somenteNumeros(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }
}
