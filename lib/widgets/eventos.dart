import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:labartola/models/evento.dart';
import 'package:labartola/services/auth_service.dart';
import 'package:labartola/views/usuario/evento_view.dart';

class EventosWidget extends StatelessWidget {
  final Evento evento;
  const EventosWidget({super.key, required this.evento, required this.authService});
  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (() {
        if(authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== evento.id)].disponible){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  EventoView(evento: evento)),
        );
        }else{

          final snackBar = SnackBar(
            backgroundColor: Colors.black,
            content: Text('Proximamente!',style: GoogleFonts.quicksand(color: Colors.white,fontSize: 20),),
            action: SnackBarAction(
              label: '',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
          
        }
      }),
      child: Opacity(
        opacity: authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== evento.id)].disponible ? 1: .2,
        child: Hero(
          tag: evento.id,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(
                  5
                ),
                decoration: BoxDecoration(
                   boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(.05),
            blurRadius: 3.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: const Offset(
              0, // Move to right 5  horizontally
              0, // Move to bottom 5 Vertically
            ),
          )
            ],
                  borderRadius: BorderRadius.circular(15),border: Border.all(width: 1,color: Colors.white.withOpacity(.1))
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                  decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    children: [
                      Text(DateFormat.MMMM("es-MX").format(evento.fechaInicio.toLocal()).toUpperCase() ,style: GoogleFonts.quicksand(color: Colors.grey),),
                      const SizedBox(height: 10,),
                      Text(evento.fechaInicio.toLocal().day.toString(),style: GoogleFonts.quicksand(color: Colors.white,fontSize: 30),),
                    const SizedBox(height: 10,),
                      Text(DateFormat.E("es-MX").format(evento.fechaInicio.toLocal()).toUpperCase(),style: GoogleFonts.quicksand(color: Colors.grey),),
              
                    ],
                  )
                ),
              ),
               Positioned(top: -5,left: -5,child: Icon(Icons.bookmark,size: 35,color: authService.revisarMesa(evento: evento.id) ? Colors.yellow : Colors.transparent))
            ],
          ),
        ),
      ),
    );
  }
}
