import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:labartola/global/enviroment.dart';
import 'package:labartola/models/amigo.dart';
import 'package:labartola/models/auth.dart';
import 'package:labartola/models/error.dart';
import 'package:labartola/models/evento.dart';
import 'package:labartola/models/mensaje_amigo.dart';
import 'package:labartola/models/reservacion.dart';
import 'package:labartola/models/usuario.dart';
import 'package:labartola/services/local_storage.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

enum TipoUsuario { cliente, vendedor, recarga, admin }

enum ButtonStatus { autenticando, disponible, pressed }

class AuthService with ChangeNotifier {
  ButtonStatus buttonStatus = ButtonStatus.disponible;
  AuthStatus authStatus = AuthStatus.checking;
  TipoUsuario tipoUsuario = TipoUsuario.cliente;

  late Usuario usuario;

  List<Evento> listaEventos = [];
  List<Amigo> listaAmigos = [];

  bool amigosEliminar = false;

  AuthService(){
    obtenerEventos();
    obetenerAmigos();
  }

  Future<bool> isLoggedIn() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final token = LocalStorage.prefs.getString('token');
      final resp = await http.get(
          Uri.parse('${Statics.apiUrl}/autentificacion/renovarCodigo'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': token ?? '',
          });
      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);

        usuario = loginResponse.usuario;

        await _guardarToken(loginResponse.token);
        await Future.delayed(const Duration(milliseconds: 750));
        return true;
      } else {
        logout();
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future logout() async {
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
    await LocalStorage.prefs.remove('token');
  }

  Future cambiarMetodoDePago({required int tipo}) async {
    if (tipo == 1) {
      usuario.cesta.efectivo = false;
    } else {
      usuario.cesta.efectivo = true;
    }
    notifyListeners();
  }

  Future<bool> logInCelular({required String numero}) async {
    final data = {
      'numero': numero.replaceAll(' ', ''),
    };
    try {
      final resp = await http.post(
          Uri.parse('${Statics.apiUrl}/autentificacion/iniciarUsuarioTelefono'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json',
          });
      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        usuario = loginResponse.usuario;
        await _guardarToken(loginResponse.token);
        await Future.delayed(const Duration(milliseconds: 750));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future register(String nombre, String email, String password, String numero,
      String passwordCheck, String dialCode) async {
    buttonStatus = ButtonStatus.autenticando;
    await Future.delayed(const Duration(milliseconds: 500));
    List<Errore> lista = [];
    final String superNumero = numero.replaceAll(RegExp(r' '), '');
    final data = {
      'nombre': nombre,
      'correo': email,
      'contrasena': password,
      'confirmar_contrasena': passwordCheck,
      'numero_celular': superNumero,
      'dialCode': dialCode,
    };

    try {
      final resp = await http.post(
          Uri.parse('${Statics.apiUrl}/autentificacion/nuevoUsuario'),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        usuario = loginResponse.usuario;
        await _guardarToken(
          loginResponse.token,
        );
        return lista;
      } else {
        final resErrores = errorResponseFromJson(resp.body);
        lista = resErrores.errores;
        return lista;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _guardarToken(String token) async {
    await LocalStorage.prefs.setString('token', token);
    authStatus = AuthStatus.authenticated;
    buttonStatus = ButtonStatus.disponible;
    notifyListeners();
  }

  obtenerEventos()async {

    try {
      final resp = await http.get(
        Uri.parse('${Statics.apiUrl}/mor/obtenerEventos'),
        headers: {'Content-Type': 'application/json'});

        final response = eventoFromJson(resp.body);


        if(resp.statusCode == 200){
          listaEventos = response;
          notifyListeners();
        }
      
    } catch (e) {
      debugPrint(e.toString());
    }    

  }

  agregarInvitadoMesa({required Evento evento,required Reservacion reservacion,required String usuario}) async {

    if(listaEventos[listaEventos.indexWhere((element) => element.id == evento.id)].reservaciones[listaEventos[listaEventos.indexWhere((element) => element.id == evento.id)].reservaciones.indexWhere((element) => element.id == reservacion.id)].listaInvitados.length<=7){

      if(listaEventos[listaEventos.indexWhere((element) => element.id == evento.id)].reservaciones[listaEventos[listaEventos.indexWhere((element) => element.id == evento.id)].reservaciones.indexWhere((element) => element.id == reservacion.id)].listaInvitados.contains(usuario)){
    try {

      final token = LocalStorage.prefs.getString('token');

      var data ={
        "reservacion":reservacion.id,
        "evento":evento.id,
        "usuario":usuario
      };

      final resp = await http.post(
        Uri.parse('${Statics.apiUrl}/mor/eliminarInvitado'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json','x-token': token ?? '',});

      if(resp.statusCode==200){

       listaEventos[listaEventos.indexWhere((element) => element.id == evento.id)].reservaciones[listaEventos[listaEventos.indexWhere((element) => element.id == evento.id)].reservaciones.indexWhere((element) => element.id == reservacion.id)].listaInvitados.removeWhere((element) => element==usuario);
      }

        

    } catch (e) {
      debugPrint(e.toString());
    }
       
      }else{


 try {

      final token = LocalStorage.prefs.getString('token');

      var data ={
        "reservacion":reservacion.id,
        "evento":evento.id,
        "usuario":usuario
      };

      final resp = await http.post(
        Uri.parse('${Statics.apiUrl}/mor/agregarInvitado'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json','x-token': token ?? '',});

      if(resp.statusCode==200){

      listaEventos[listaEventos.indexWhere((element) => element.id == evento.id)].reservaciones[listaEventos[listaEventos.indexWhere((element) => element.id == evento.id)].reservaciones.indexWhere((element) => element.id == reservacion.id)].listaInvitados.insert(0, usuario);
      
      }

        

    } catch (e) {
      debugPrint(e.toString());
    }


      }
    notifyListeners();
    }


  }

  Future<String> agregarAmigo({required String numero})async {

    var data = {
      "numero":numero
    };

    if(usuario.numeroCelular== numero ){

      return "Accion incorrecta";

    }

    if(listaAmigos.any((element) => element.celular == numero)){

      return "Amigo repetido";

    }

    

    try {
      final token = LocalStorage.prefs.getString('token');
      final resp = await http.post(
        Uri.parse('${Statics.apiUrl}/mor/agregarAmigo'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json','x-token': token ?? ''});
        final response = mensajeAmigoFromJson(resp.body);
        listaAmigos.insert(0,response.usuario);
        notifyListeners();
        return response.msg;
    } catch (e) {
      return "Error";
    }    

  }
  obetenerAmigos()async {

    try {

      final token = LocalStorage.prefs.getString('token');

      final resp = await http.post(
        Uri.parse('${Statics.apiUrl}/mor/obtenerListadoAmigos'),
        headers: {'Content-Type': 'application/json','x-token': token ?? '',});


        final amigosPre = amigoFromJson(resp.body);

        listaAmigos =  amigosPre;
        notifyListeners();

    } catch (e) {
      listaAmigos = [];
    }    

  }
  nuevaReserva({required String mesaId,required String evento}) async {  

    try {

      final token = LocalStorage.prefs.getString('token');

      var data ={
        "reservacion":mesaId,
        "evento":evento
      };

      final resp = await http.post(
        Uri.parse('${Statics.apiUrl}/mor/crearNuevaReserva'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json','x-token': token ?? '',});

      if(resp.statusCode==200){

    listaEventos[listaEventos.indexWhere((element) => element.id==evento)].reservaciones[listaEventos[listaEventos.indexWhere((element) => element.id==evento)].reservaciones.indexWhere((element) => element.id==mesaId)].administrador = usuario.uid;
    listaEventos[listaEventos.indexWhere((element) => element.id==evento)].reservaciones[listaEventos[listaEventos.indexWhere((element) => element.id==evento)].reservaciones.indexWhere((element) => element.id==mesaId)].listaInvitados.insert(0, usuario.uid);
    

    
    notifyListeners();
      }

        

    } catch (e) {
      debugPrint(e.toString());
    }

  }
  Reservacion queMesa({required String evento}){


    return listaEventos[listaEventos.indexWhere((element) => element.id==evento)].reservaciones.firstWhere((element) => element.listaInvitados.contains(usuario.uid));
    

  }
  bool revisarMesa2({required String evento,required String usuario}){


    if(listaEventos[listaEventos.indexWhere((element) => element.id==evento)].reservaciones.any((element) => element.listaInvitados.contains(usuario))){
      return true;
    }
    return false;

  }

  bool revisarMesa({required String evento}){


    if(listaEventos[listaEventos.indexWhere((element) => element.id==evento)].reservaciones.any((element) => element.listaInvitados.contains(usuario.uid))){
      return true;
    }
    return false;

  }
  

  agregarMesa()async {

      final data = {
      'mesa': "PREMIUM6",
    };    
       await http.post(
        Uri.parse('${Statics.apiUrl}/mor/crearNuevoMesa'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});
  }

  cambiarEstadoEliminar(){

    amigosEliminar = !amigosEliminar;

    notifyListeners();  

  }

}
