// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rep_p_mobile/src/pages/home/telas/consulta_marcacoes.dart';
import 'package:rep_p_mobile/src/pages/home/telas/justificar.dart';
import 'package:rep_p_mobile/src/pages/home/telas/solicitar_marcacao.dart';
import 'package:rep_p_mobile/src/pages/home/telas/tela_home.dart';
import 'package:rep_p_mobile/src/ui/cores.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  List telas = [
    SolicitarInclusaoMarcacao(),
    TelaRegistrarMarcacao(),
    ConsultaMarcacoesTelas(),
    JustificarPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletaCores.backgroundWhite,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.wysiwyg),
            title: Text("Solicitar"),
            selectedColor: PaletaCores.backgroundBlue,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.fingerprint),
            title: Text("Principal"),
            selectedColor: PaletaCores.backgroundBlue,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Buscar"),
            selectedColor: PaletaCores.backgroundBlue,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.file_copy_outlined),
            title: Text("Justificar"),
            selectedColor: PaletaCores.backgroundBlue,
          ),
        ],
      ),
      body: telas[_currentIndex],
    );
  }
}
