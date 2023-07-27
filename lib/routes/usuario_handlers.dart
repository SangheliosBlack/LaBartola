import 'package:fluro/fluro.dart';
import 'package:labartola/services/auth_service.dart';
import 'package:labartola/views/auth/login_celular.dart';
import 'package:labartola/views/usuario/dashboard_usuario.dart';
import 'package:provider/provider.dart';

class UsuarioHanlder {
  static Handler login = Handler(handlerFunc: ((context, parameters) {
    final authService = Provider.of<AuthService>(context!);

    if (authService.authStatus == AuthStatus.notAuthenticated) {
      return const AutentificarCelular();
    } else {
      return const DashboardUsuarioView();
    }
  }));
}
