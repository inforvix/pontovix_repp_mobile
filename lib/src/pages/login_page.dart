// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:rep_p_mobile/src/common/dados.dart';
import 'package:rep_p_mobile/src/common/funcoes_globais.dart';
import 'package:rep_p_mobile/src/repositories/funcionarios_repository.dart';
import 'package:rep_p_mobile/src/pages/home/home_page.dart';
import 'package:rep_p_mobile/src/ui/cores.dart';
import 'package:rep_p_mobile/src/ui/widgets/button.dart';
import 'package:rep_p_mobile/src/ui/widgets/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController cpfController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarLoginSalvo();
  }

  Future<void> _carregarLoginSalvo() async {
    final prefs = await SharedPreferences.getInstance();
    String? cpfSalvo = prefs.getString('cpf_login');
    if (cpfSalvo != null) {
      setState(() {
        cpfController.text = cpfSalvo;
      });
    }
  }

  Future<void> _salvarLogin(String cpf) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cpf_login', cpf);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 230,
              color: PaletaCores.backgroundBlue,
              child: Image.asset(
                'assets/images/logo_pontovix.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 180),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 180,
                decoration: BoxDecoration(
                  color: PaletaCores.backgroundWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    EditInforvixCPF(
                      controller: cpfController,
                      titulo: 'Login',
                      hint: 'Informe seu login',
                    ),
                    SizedBox(height: 40),
                    EditInforvixSenha(
                      controller: senhaController,
                      titulo: 'Senha',
                      hint: 'Informe sua senha',
                    ),
                    SizedBox(height: 20),
                    Spacer(),
                    ButtonPrimaryInforvix(
                      titulo: 'Entrar',
                      funcao: () async {
                        if (cpfController.text.isEmpty ||
                            senhaController.text.isEmpty) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: "Preencha todos os campos",
                            ),
                          );
                          return;
                        }

                        await FuncionarioRepository().login(
                          cpf:
                              FuncoesGlobais.somenteNumeros(cpfController.text),
                          senha: senhaController.text,
                        );

                        if (DadosGlobais.token != '') {
                          await _salvarLogin(cpfController.text);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        } else {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: "Usuario ou senha invalidos",
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Spacer(),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: PaletaCores.backgroundWhiteSolid,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                  'assets/images/logo_inforvix.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
