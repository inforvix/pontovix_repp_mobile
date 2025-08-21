// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rep_p_mobile/src/ui/cores.dart';
import 'package:rep_p_mobile/src/ui/fonts.dart';

class BagdeDyaOfWeek extends StatelessWidget {
   BagdeDyaOfWeek({
    required this.day,
    super.key,
  });
  
   String day;

  String formatarData(String dataOriginal) {
    DateTime dateTime = DateTime.parse(dataOriginal);
    DateFormat formatter = DateFormat("dd 'de' MMMM 'de' yyyy", 'pt_BR');
    return formatter.format(dateTime);
  }


  @override
  Widget build(BuildContext context) {
  day = formatarData(day);
    return Container(
      margin: EdgeInsets.all(2),
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: PaletaCores.backgroundBlue,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            day,
            style: Fonts.textStyleTituloEdit
                .copyWith(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }
}