// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mask/mask/mask.dart';
import 'package:rep_p_mobile/src/ui/cores.dart';
import 'package:rep_p_mobile/src/ui/fonts.dart';

class EditInforvixSenha extends StatefulWidget {
  const EditInforvixSenha({
    super.key,
    required this.controller,
    required this.titulo,
    required this.hint,
  });

  final TextEditingController controller;
  final String titulo;
  final String hint;

  @override
  State<EditInforvixSenha> createState() => _EditInforvixSenhaState();
}

class _EditInforvixSenhaState extends State<EditInforvixSenha> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      width: MediaQuery.sizeOf(context).width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titulo,
            style: Fonts.textStyleTituloEdit,
          ),
          Spacer(),
          Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: PaletaCores.backgroundWhiteSolid,
              border: Border.all(
                width: 1,
                color: PaletaCores.cinza,
              ),
            ),
            child: TextFormField(
              obscureText: hidePassword,
              controller: widget.controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PaletaCores.backgroundBlue),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: widget.hint,
                prefixIcon: Icon(Icons.key),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                        print(hidePassword);
                      });
                    },
                    icon: Icon(Icons.remove_red_eye_outlined)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditInforvixCPF extends StatelessWidget {
  const EditInforvixCPF({
    super.key,
    required this.controller,
    required this.titulo,
    required this.hint,
  });

  final TextEditingController controller;
  final String titulo;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      width: MediaQuery.sizeOf(context).width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: Fonts.textStyleTituloEdit,
          ),
          Spacer(),
          Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: PaletaCores.backgroundWhiteSolid,
              border: Border.all(
                width: 1,
                color: PaletaCores.cinza,
              ),
            ),
            child: TextFormField(
              inputFormatters: [Mask.cpf()],
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PaletaCores.backgroundBlue),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: hint,
                prefixIcon: Icon(Icons.person_2_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditData extends StatelessWidget {
  const EditData({
    super.key,
    required this.controller,
    required this.titulo,
  });

  final TextEditingController controller;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 160,
      child: TextField(
        controller: controller,
        inputFormatters: [Mask.date()],
        decoration: InputDecoration(
          hintText: '17/08/2024',
          labelText: titulo,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: IconButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (pickedDate != null) {
                String formattedDate =
                    '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}';
                controller.text = formattedDate;
              }
            },
            icon: Icon(Icons.date_range_outlined),
            color: PaletaCores.backgroundBlue,
          ),
        ),
      ),
    );
  }
}

class EditHora extends StatelessWidget {
  const EditHora({
    super.key,
    required this.controller,
    required this.titulo,
  });

  final TextEditingController controller;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 160,
      child: TextField(
        controller: controller,
        inputFormatters: [Mask.date()],
        decoration: InputDecoration(
          hintText: '08:00',
          labelText: titulo,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: IconButton(
            onPressed: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child!,
                  );
                },
              );

              if (pickedTime != null) {
                final String formattedTime =
                    '${pickedTime.hour.toString().padLeft(2, '0')}:'
                    '${pickedTime.minute.toString().padLeft(2, '0')}:00';

                controller.text = formattedTime;
              }
            },
            icon: Icon(Icons.timer_outlined),
            color: PaletaCores.backgroundBlue,
          ),
        ),
      ),
    );
  }
}
