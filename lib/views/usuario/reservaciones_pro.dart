import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labartola/models/evento.dart';
import 'package:labartola/models/reservacion.dart';
import 'package:labartola/services/auth_service.dart';
import 'package:provider/provider.dart';

class ReservacionesPro extends StatelessWidget {
  const ReservacionesPro({super.key, required this.evento});
  final Evento evento;


  @override
  Widget build(BuildContext context) {
     final  authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color.fromRGBO(33, 32, 34, 1),
      body: SizedBox(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
                            physics: const BouncingScrollPhysics(),
                            itemCount: authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== evento.id)].reservaciones.length,
                            itemBuilder: (BuildContext context, int index) {
                  
                              var mesa = authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id==evento.id)].reservaciones[index];

                              return Opacity(
                                opacity: mesa.nombreAdminstrador.isEmpty ? .2 : 1,
                                child: Column(
                                  children: [
                                    Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                                    decoration: const BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                const Icon(Icons.schedule,color: Colors.white,),
                                const SizedBox(width: 10),
                                Text("10:00 PM",style: GoogleFonts.quicksand(color:Colors.white),)
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                const Icon(Icons.attach_money,color: Colors.white,),
                                Text(mesa.consumoMinimo.toStringAsFixed(2),style: GoogleFonts.quicksand(color:Colors.white)),
                                const SizedBox(width: 15,),
                                const Icon(Icons.person,color: Colors.white,),
                                Text("${mesa.maximoPersonas}",style: GoogleFonts.quicksand(color:Colors.white)),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(color: Colors.white,height: 1,),
                                                  Container(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),width: double.infinity,decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(.2),
                                                  ),child: Row(
                                                    children: [
                                                      Text("Numero celular:    ",style: GoogleFonts.quicksand(color:Colors.grey),),
                                                      Text(mesa.numeroAdminstrador,style: GoogleFonts.quicksand(color:Colors.white,fontSize: 20),),
                                                    ],
                                                  )),
                                    Container(
                                                    padding: const EdgeInsets.all(15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black.withOpacity(.2),
                                                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsets.all(15),
                                                          decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)
                                                          ),
                                                          child: Text(mesa.mesaId,style: GoogleFonts.quicksand(color:Colors.white,fontSize: 20),),
                                                        ),
                                                        const SizedBox(width: 15,),
                                                        Expanded(
                                                          child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: Text(mesa.nombreAdminstrador,overflow: TextOverflow.ellipsis,style: GoogleFonts.quicksand(fontSize: 25,color: Colors.white),)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                           obtenerIcono(reservacion:mesa),
                                          const SizedBox(width: 3,),
                                          Text(obtenerTitulo(reservacion: mesa),style: GoogleFonts.quicksand(color:Colors.white),),
                                        ],
                                      )
                                    ],
                                                          ),
                                                        ),
                                                
                                                        
                                                      ],
                                                    ),
                                                  ),
                                  ],
                                ),
                              );
                  
                              }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 15,); },
                          ),
                        ),
    );
  }

  String obtenerTitulo({required Reservacion reservacion }){

  if(reservacion.regular){
    return "Mesa Regular";
  }else if(reservacion.regularMesa){
    return "Mesa Regular Bancos";
  }else if(reservacion.vip){
    return "Mesa VIP";
  }else{
    return "Mesa Premium";
  }

}
  Icon obtenerIcono({required Reservacion reservacion}){

  if(reservacion.regular){
    return const Icon(Icons.star_half,color: Colors.white);
  }else if(reservacion.regularMesa){
    return const Icon(Icons.star,color: Colors.white);
  }else if(reservacion.vip){
    return const Icon(Icons.hotel_class,color: Colors.white);
  }else{
    return const Icon(Icons.diamond,color: Colors.white);
  }
}
}