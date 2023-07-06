
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labartola/provider/register_form_provider.dart';
import 'package:labartola/routes/router.dart';
import 'package:labartola/services/auth_service.dart';
import 'package:labartola/services/dial_service.dart';
import 'package:labartola/services/local_storage.dart';
import 'package:labartola/services/navigator.dart';
import 'package:labartola/views/layout/auth_layout.dart';
import 'package:labartola/views/layout/splash_layout.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocalStorage.configurePrefs();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          lazy: false, create: (_) => RegisterFromProvider()),
      ChangeNotifierProvider(lazy: false, create: (_) => AuthService()),
      ChangeNotifierProvider(lazy: false, create: (_) => Dial()),
    ], child: const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      navigatorKey: navigationService.navigatorKey,
      initialRoute: Flurorouter.rootRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Flurorouter.router.generator,
      builder: ((_, child) {
        final authProvider = Provider.of<AuthService>(context);
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) {
              return authProvider.authStatus == AuthStatus.checking
                  ? SplashLayout(
                      child: child!,
                    )
                  : AuthLayout(child: child!);
            })
          ],
        );
      }),
    );
  }
}
