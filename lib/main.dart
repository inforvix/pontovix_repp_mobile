import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rep_p_mobile/src/database/DatabaseProvider.dart';
import 'package:rep_p_mobile/src/pages/login_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  if (kIsWeb || defaultTargetPlatform == TargetPlatform.android) {
    WidgetsFlutterBinding.ensureInitialized();
    await DatabaseProvider.database;
    tz.initializeTimeZones();
  }

  initializeDateFormatting('pt_BR', null).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REP-P INFORVIX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
