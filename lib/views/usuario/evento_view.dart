
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as fechon;
import 'package:labartola/models/evento.dart';
import 'package:labartola/models/reservacion.dart';
import 'package:labartola/services/auth_service.dart';
import 'package:labartola/views/usuario/agregar_invitado.dart';
import 'package:labartola/views/usuario/dashboard_usuario.dart';
import 'package:labartola/views/usuario/mapa.dart';
import 'package:labartola/views/usuario/reservaciones_pro.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vector_math/vector_math_64.dart' as mathe ;


class EventoView extends StatefulWidget {
  final Evento evento;
  const EventoView({super.key, required this.evento});

  @override
  State<EventoView> createState() => _EventoViewState();
}

class _EventoViewState extends State<EventoView> {
  late AuthService authService;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    authService = Provider.of<AuthService>(context);
    PageController controller =
        PageController(viewportFraction: 1, initialPage: currentPage);
        
    return Scaffold(
      appBar: AppBar(
        actions: [
          authService.usuario.repartidor ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (){

                         Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>   ReservacionesPro(evento: widget.evento,)),
  );

            },
            child: Row(
              children: [
                Icon(Icons.calendar_month,color: Colors.white,),
            SizedBox(width: 10,)
              ],
            ),
          ):Container()
        ],
        backgroundColor: Colors.black,
        elevation: 5,
      ),
      backgroundColor: const Color.fromRGBO(33, 32, 34, 1),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            currentPage=0;
          });
          controller.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut);
          return await Provider.of<AuthService>(context, listen: false).obtenerEventos();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Stack(
              //   children: [
                  
              //     // SizedBox(
              //     //   height: 300,
              //     //   child: ClipPath(
              //     //     clipper: TrapeziumClipper(),
              //     //     child: const Image(image: AssetImage('assets/images/RFB.png'),fit: BoxFit.cover,),
              //     //   ),
              //     // ),
              //     // Container(
              //     //   height: 275,
              //     //   decoration: BoxDecoration(
              //     //       gradient: LinearGradient(
              //     //     stops: const [.4, 1],
              //     //     colors: [Colors.transparent, Colors.black.withOpacity(1)],
              //     //     begin: Alignment.topCenter,
              //     //     end: Alignment.bottomCenter,
              //     //   )),
              //     // ),
              //     Positioned(
              //       left: 25,
              //       top: 30,
              //       child: GestureDetector(
              //         onTap: (() {
              //           Navigator.pop(context);
              //         }),
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(100),
              //           child: BackdropFilter(
              //             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              //             child: Container(
              //               padding: const EdgeInsets.all(15),
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(100),
              //                   color:  Colors.white.withOpacity(.3)),
              //               child: const Center(
              //                 child: Icon(
              //                   Icons.arrow_back_ios_new_outlined,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              
              //   ],
              // ),
              Hero(tag: widget.evento.id,
              child:  Container(decoration: BoxDecoration(
                boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              spreadRadius: 5,
              blurRadius: 10.0,
              offset: const Offset(0, 10),
            ),

          ]
              ),child:  const ClipRRect(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),child: SizedBox(width: double.infinity,child: Image(image: AssetImage('assets/images/portada.png'),fit: BoxFit.cover))))),
              const SizedBox(
                height: 25,
              ),
              authService.revisarMesa(evento: widget.evento.id) ?
               authService.queMesa(evento: widget.evento.id).administrador == authService.usuario.uid ? Container() : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Builder(
                              builder: (context) {
                                final nombre = authService.queMesa(evento: widget.evento.id).nombreAdminstrador.split(' ');
                                return Text(
                                  '${nombre[0]} te ha invitado',
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white, fontSize: 18),
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ) :Container(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  const SimplePage()),
  );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ver Mapa Virtual",style: GoogleFonts.quicksand(color: Colors.white,fontSize: 20),),
                        Icon(Icons.map,color: Colors.white,size: 30,)
                      ],
                    ),
                  ),
                ),
              obtenerMesasLibres(reservaciones:  authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== widget.evento.id)].reservaciones, authService: authService).isNotEmpty ?  GestureDetector(
                onTap: authService.revisarMesa( evento: widget.evento.id)? null : (){
                  authService.nuevaReserva(mesaId: obtenerMesasLibres(reservaciones:  authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== widget.evento.id)].reservaciones, authService: authService)[currentPage].id, evento: widget.evento.id);
                },
                child: AnimatedOpacity(
                  duration:const Duration(milliseconds: 500),
                  opacity:  authService.revisarMesa( evento: widget.evento.id) ? 1 : obtenerMesasLibres(reservaciones:  authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== widget.evento.id)].reservaciones, authService: authService).isNotEmpty ? 1:.2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: Colors.white.withOpacity(.2)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          authService.revisarMesa( evento: widget.evento.id) ? "Mi reservacion" : 'Reservar  ${obtenerMesasLibres(reservaciones:  authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== widget.evento.id)].reservaciones, authService: authService).isNotEmpty ? obtenerMesasLibres(reservaciones:  authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== widget.evento.id)].reservaciones, authService: authService)[currentPage].mesaId : ""}',
                          style: GoogleFonts.quicksand(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ) : Container(),
              authService.revisarMesa(evento: widget.evento.id)?  Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
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
                              Column(
                                children: [
                                  Text("Consumo minimo",style: GoogleFonts.quicksand(color:Colors.blueGrey),),
                                  const SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      const Icon(Icons.attach_money,color: Colors.white,),
                                      Text(authService.queMesa(evento: widget.evento.id).consumoMinimo.toStringAsFixed(2),style: GoogleFonts.quicksand(color:Colors.white)),
                                      const SizedBox(width: 15,),
                                      const Icon(Icons.person,color: Colors.white,),
                                      Text("${authService.queMesa(evento: widget.evento.id).maximoPersonas}",style: GoogleFonts.quicksand(color:Colors.white)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(color: Colors.white,height: 1,),
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
                                child: Text(authService.queMesa(evento: widget.evento.id).mesaId,style: GoogleFonts.quicksand(color:Colors.white,fontSize: 20),),
                              ),
                              const SizedBox(width: 15,),
                              Expanded(
                                child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Text(authService.usuario.nombre,overflow: TextOverflow.ellipsis,style: GoogleFonts.quicksand(fontSize: 25,color: Colors.white),)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                             obtenerIcono(reservacion: authService.queMesa(evento: widget.evento.id) ),
                                            const SizedBox(width: 3,),
                                            Text(obtenerTitulo(reservacion:authService.queMesa(evento: widget.evento.id)),style: GoogleFonts.quicksand(color:Colors.white),),
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
              ) :
              AnimatedSize(
                duration: const Duration(milliseconds: 500),
                child:obtenerMesasLibres(reservaciones:  authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== widget.evento.id)].reservaciones, authService: authService).isNotEmpty? Container(
                  margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                    
                      SizedBox(
                            height: 158,
                            child: PageView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: controller,
                              onPageChanged: (int i){
                                setState(() {
                                  currentPage = i;
                                });
                              },
                              itemCount:obtenerMesasLibres(reservaciones:  authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== widget.evento.id)].reservaciones, authService: authService).length,
                              itemBuilder: (BuildContext context, int index) {
                    
                                return Column(
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
                                Text(obtenerMesasLibres(reservaciones: authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id==widget.evento.id)].reservaciones, authService: authService)[index].consumoMinimo.toStringAsFixed(2),style: GoogleFonts.quicksand(color:Colors.white)),
                                const SizedBox(width: 15,),
                                const Icon(Icons.person,color: Colors.white,),
                                Text("${obtenerMesasLibres(reservaciones: authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id==widget.evento.id)].reservaciones, authService: authService)[index].maximoPersonas}",style: GoogleFonts.quicksand(color:Colors.white)),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Divider(color: Colors.white,height: 1,),
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
                              child: Text(obtenerMesasLibres(reservaciones: authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id==widget.evento.id)].reservaciones, authService: authService)[index].mesaId,style: GoogleFonts.quicksand(color:Colors.white,fontSize: 20),),
                            ),
                            const SizedBox(width: 15,),
                            Expanded(
                              child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: Text(authService.usuario.nombre,overflow: TextOverflow.ellipsis,style: GoogleFonts.quicksand(fontSize: 25,color: Colors.white),)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                           obtenerIcono(reservacion:obtenerMesasLibres(reservaciones: authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id==widget.evento.id)].reservaciones, authService: authService)[index] ),
                                          const SizedBox(width: 3,),
                                          Text(obtenerTitulo(reservacion:obtenerMesasLibres(reservaciones: authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id==widget.evento.id)].reservaciones, authService: authService)[index] ),style: GoogleFonts.quicksand(color:Colors.white),),
                                        ],
                                      )
                                    ],
                              ),
                            ),
                    
                            
                          ],
                        ),
                      ),
                                  ],
                                );
                    
                                },
                            ),
                          ),
                      Text("*Valida hasta las 23:00*",style: GoogleFonts.quicksand(color:Colors.blue),),
                      Text("*Mesas disponibles ${  authService.revisarMesa( evento: widget.evento.id) ? "": obtenerMesasLibres(reservaciones: authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id==widget.evento.id)].reservaciones, authService: authService).length} * Consumo minimo \$",style: GoogleFonts.quicksand(color:Colors.blue),),

                          const SizedBox(height: 10,),
                          SmoothPageIndicator(
                        controller: controller,
                        onDotClicked: (index) {
                          setState(() {
          currentPage=index;
          });
          controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut);
                        },
                        count: obtenerMesasLibres(reservaciones:  authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== widget.evento.id)].reservaciones, authService: authService).length,
                        textDirection: TextDirection.ltr,
                        effect: ExpandingDotsEffect(
                          spacing: 2,
                          dotHeight: 2,
                          dotWidth:  (width-205)/50,
                          activeDotColor:
                              Theme.of(context).colorScheme.primary.withOpacity(1),
                          dotColor:
                              Theme.of(context).colorScheme.primary.withOpacity(.2),
                        ),
                      ),
                    ],
                  ),
                ) : const SizedBox(),
              ),
              const SizedBox(height: 15,),
              authService.revisarMesa( evento: widget.evento.id) && authService.queMesa(evento: widget.evento.id).administrador == authService.usuario.uid ?  Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black,
                  boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              spreadRadius: 5,
              blurRadius: 10.0,
              offset: const Offset(0, 10),
            ),

          ]
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                      children: [
                        Text("Mis invitados",style: GoogleFonts.quicksand(color: Colors.white),),
                        GestureDetector(behavior: HitTestBehavior.translucent,onTap: (){
                          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AgregarInvitadoView(reservacion: authService.queMesa(evento: widget.evento.id), evento: widget.evento,
                  )),
  );
                     
                        },child: const SizedBox(width: 30,child: Icon(Icons.edit_note,color: Colors.white,)))
                      ],
                    ),
                    const SizedBox(height: 20,),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){

                              Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  AgregarInvitadoView(reservacion: authService.queMesa(evento: widget.evento.id), evento: widget.evento,
                  )),
        );
                            },
                            child: DottedBorder(
                                                borderType: BorderType.Circle,
                                                color: Colors.white,
                                                strokeWidth: 1,
                                                radius: const Radius.circular(12),
                                                padding: const EdgeInsets.all(6),
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                  child: Container(
                            height: 55,
                            width:  55,
                            color: Colors.grey,
                            child: const Icon(Icons.add,color: Colors.white,),
                                                  ),
                                                  
                                                ),
                                                ),
                          ),
                      const SizedBox(width: 10),
                      Stack(
      children: [
                              Column(children: [Container(
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
                                
                              ),const SizedBox(height: 10,),SizedBox(width: 85,child: Text("Yo",textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,style: GoogleFonts.quicksand(color:Colors.white),))]),
                              
                              
                            ],
    ),
                        SizedBox(
                      height: 106,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, int i) => authService.revisarMesa2(evento:authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id == widget.evento.id)].id , usuario: authService.listaAmigos[i].idUsuario)  ?AmigoAvatar(authProvider: authService, i: i,) :Container(), 
                        itemCount: authService.listaAmigos.length, 
                        separatorBuilder: (_,__) => const SizedBox(width: 5,),),
                      )
                      
                        ],
                      ),
                    )
                  ],
                ),
              ) : Container(),
              obtenerMesasLibres(reservaciones:  authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== widget.evento.id)].reservaciones, authService: authService).isEmpty ? Text("Reservaciones agotadas",style: GoogleFonts.quicksand(color:Colors.grey),) : const SizedBox()
              ,Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Cover por persona ",style: GoogleFonts.quicksand(color: Colors.grey),),
                                Text("Consumo minimo \$ ",style: GoogleFonts.quicksand(color: Colors.grey),),
                              ],
                            ),
                            Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(47, 46, 48, 1),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Text(
                                    '\$ ${widget.evento.cover}.00',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                          ],
                        ),
                    const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Mor - The Experience Club',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.quicksand(
                                              color: Colors.white,  fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 19,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Line Up : ',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.grey),
                                        ),
                                        
                                        Expanded(
                                          child: Marquee(
                                    text: widget.evento.lineUp.join(" - "),

                                    style: GoogleFonts.quicksand(color: Colors.blue),
                                    scrollAxis: Axis.horizontal,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    blankSpace: 20.0,
                                    velocity: 100.0,
                                    pauseAfterRound: const Duration(seconds: 1),
                                    startPadding: 10.0,
                                    accelerationDuration: const Duration(seconds: 1),
                                    accelerationCurve: Curves.linear,
                                    decelerationDuration: const Duration(milliseconds: 500),
                                    decelerationCurve: Curves.easeOut,
                                  ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id == widget.evento.id)].fechaInicio.toLocal().day.toString(),
                                      style: GoogleFonts.quicksand(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      fechon.DateFormat.MMMM("es-MX").format(authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id == widget.evento.id)].fechaInicio).toUpperCase(),
                                      style: GoogleFonts.quicksand(
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fechon.DateFormat.EEEE("es-MX").format(authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id == widget.evento.id)].fechaInicio.toLocal()).toUpperCase(),
                                      style: GoogleFonts.quicksand(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '10:00 PM - 11:00 PM',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  text: '',
                                  style:
                                      GoogleFonts.quicksand(color: Colors.white),
                                  children:  <TextSpan>[
                                    const TextSpan(
                                        text: 'Acerca del evento',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            ' ${authService.listaEventos[authService.listaEventos.indexWhere((element) => element.id== widget.evento.id)].descripcion}',
                                        style: const TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
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

List<Reservacion>obtenerMesasLibres({required List<Reservacion> reservaciones,required AuthService authService}){

  List<Reservacion> reservacionesPre = [];

  for (var i = 0; i < reservaciones.length; i++) {
    
    if(reservaciones[i].administrador.isNotEmpty && reservaciones[i].listaInvitados.contains(authService.usuario.uid) ){
    reservacionesPre.insert(0, reservaciones[i]);

    }

    if(reservaciones[i].administrador.isEmpty ){
        reservacionesPre.insert(0, reservaciones[i]);

    }


  }

  return reservacionesPre;

}

class Mesa extends StatelessWidget {
  const Mesa({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        Positioned(
          top: 0,
          right: 40,
          child: Transform.rotate(
            angle: mathe.radians(35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5)),
                  height: 100,width: 30),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 40,
          child: Transform.rotate(
            angle: mathe.radians(-35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5)),
                  height: 100,width: 30),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5)),
                height: 30,width: 100),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top:5,left: 10,right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100)),
          height: 90,width: 90,child: Center(child: Text("M1",style: GoogleFonts.quicksand(color:Colors.black,fontSize: 25))) ,),
          
      ],
    );
  }
}

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    path.lineTo(size.width / 3.5, .0);
    path.lineTo(size.width, 400);
    path.lineTo(0.0, 400);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}
