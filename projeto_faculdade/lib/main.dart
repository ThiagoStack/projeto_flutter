// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/providers/task_provider.dart';
import 'app/providers/user_provider.dart';
import 'app/shared/background_container.dart';
import 'app/pages/login_page/login_page.dart';

/// INTEGRANTES
// Lucca Serra de Melo Reis
// Ra:1272116626

// Thiago nunes da cruz lucas
// RA: 722421909

// Kaliane Vitoria Oliveira Baccetti 
// RA: 823156445

// José Antônio Lucas Júnior 
// RA: 722421785

// Bismarck Gabriel da Silva
// RA: 1352321373

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'), // Adiciona suporte para português do Brasil
        ],
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent, 
        ),
        home: const LoginPage(),
      ),
    );
  }
}
