import 'package:fluro/fluro.dart';
import 'package:labartola/routes/usuario_handlers.dart';

class Flurorouter {

  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  static void configureRoutes() {

    router.define(rootRoute,
        handler: UsuarioHanlder.login,
        transitionDuration: const Duration(milliseconds: 400),
        transitionType: TransitionType.native);

  }
}
 