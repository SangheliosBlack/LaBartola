import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labartola/models/evento.dart';
import 'package:labartola/models/reservacion.dart';
import 'package:labartola/services/auth_service.dart';
import 'package:provider/provider.dart';

class AgregarInvitadoView extends StatelessWidget {
  const AgregarInvitadoView({super.key, required this.reservacion, required this.evento});

  final Reservacion reservacion;

  final Evento evento;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Invitados (maximo 8)",style: GoogleFonts.quicksand(color:Colors.white),),
      ),
      backgroundColor: const Color.fromRGBO(33, 32, 34, 1),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) { 
          return GestureDetector(
            onTap: (){
              authProvider.agregarInvitadoMesa(evento: evento, reservacion: reservacion, usuario: authProvider.listaAmigos[index].idUsuario);
            },
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: reservacion.listaInvitados.contains(authProvider.listaAmigos[index].idUsuario)? 1 :.2 ,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
                color:  Colors.black,
                child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                                                  padding: const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(100),
                                                      border:
                                                          Border.all(width: 1, color: Colors.white)),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(100),
                                                    child: const SizedBox(
                                                      width:  60,
                                                      height: 60,
                                                      child: Image(
                                                                        image: AssetImage('assets/images/forma-abstracta.png')
                                                                      )
                                                    ),
                                                  ),
                                                  
                                                ),
                                                const SizedBox(width: 15,),
                                                 Expanded(
                                                   child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                       Text(authProvider.listaAmigos[index].nombre,overflow: TextOverflow.ellipsis,style: GoogleFonts.quicksand(color:Colors.white,fontSize: 15),),
                                                       Text("Amigo",style: GoogleFonts.quicksand(color:Colors.grey,fontSize: 13),),
                                                     ],
                                                   ),
                                                 ),
                        ],
                      ),
                    ),
                     Row(
                       children: [
                        const SizedBox(width: 10,),
                         Text(reservacion.listaInvitados.contains(authProvider.listaAmigos[index].idUsuario)? "Invitado" : "",style: GoogleFonts.quicksand(color:Colors.blue),),
                       ],
                     ),
                  ],
                ),
              ),
            ),
          );
         }, 
        itemCount: authProvider.listaAmigos.length, 
        separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 0,);},),
    );
  }
}