// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labartola/services/auth_service.dart';
import 'package:labartola/views/usuario/participante_view.dart';
import 'package:labartola/widgets/eventos.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class DashboardUsuarioView extends StatefulWidget {
  const DashboardUsuarioView({super.key});

  @override
  State<DashboardUsuarioView> createState() => _DashboardUsuarioViewState();
}

class _DashboardUsuarioViewState extends State<DashboardUsuarioView> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);
    final nombre = authProvider.usuario.nombre.split(' ');
    
    
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromRGBO(33, 32, 34, 1),
            appBar: AppBar(
              
              leadingWidth: 100,
              leading: GestureDetector(
                onTap: () {
Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ParticipanteView(
                  )),
        );
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          nombre[0],
                          style: GoogleFonts.quicksand(
                              color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              backgroundColor: Colors.black,
              elevation: 1,
              centerTitle: true,
              toolbarHeight: 60,
            ),
            body: Column(
              children: [
                
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                //   decoration: const BoxDecoration(color: Colors.black),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                      
                //       Row(
                //         children: [
                //           Container(
                //             padding: const EdgeInsets.all(3),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(100),
                //                 border:
                //                     Border.all(width: 1, color: Colors.white)),
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(100),
                //               child: const SizedBox(
                //                 width: 35,
                //                 height: 35,
                //                 child: Image(
                //         image: AssetImage('assets/images/forma-abstracta.png')
                //       )
                //               ),
                //             ),
                //           ),
                //           Container(
                //             margin: const EdgeInsets.only(left: 10),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   'Julio te ha invitado',
                //                   style: GoogleFonts.quicksand(
                //                       color: Colors.white, fontSize: 12),
                //                 ),
                //                 Text(
                //                   'Hora limite de entrada',
                //                   style: GoogleFonts.quicksand(
                //                       color: Colors.grey, fontSize: 11),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           Row(
                //             children: [
                //               const Icon(
                //                 Icons.calendar_month,
                //                 color: Colors.white,
                //                 size: 15,
                //               ),
                //               const SizedBox(
                //                 width: 4,
                //               ),
                //               Text(
                //                 '12/12/25',
                //                 style:
                //                     GoogleFonts.quicksand(color: Colors.white),
                //               ),
                //             ],
                //           ),
                //           const SizedBox(height: 2),
                //           Text(
                //             '10:00 PM',
                //             style: GoogleFonts.quicksand(
                //                 color: Colors.grey, fontSize: 11),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
          
          return await Provider.of<AuthService>(context, listen: false).obtenerEventos();
        },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Line Up',
                              style: GoogleFonts.quicksand(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 146,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => EventosWidget(
                              evento:authProvider.listaEventos[index], authService: authProvider,
                            ),
                            itemCount: authProvider.listaEventos.length,
                            separatorBuilder: (_, __) => const SizedBox(
                              width: 20,
                            ),
                          ),
                        ),
                  
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Expanded(child: Divider(color: Colors.white,)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                    'Mi entrada virtual',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.white, fontSize: 20),
                                  ),
                            ),
                                const Expanded(child: Divider(color: Colors.white,)),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            border: Border.all(
                                color: Colors.white.withOpacity(.1), width: 1),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Colors.white.withOpacity(.5), width: 2),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.white, width: 3),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/images/textura.jpeg',),fit: BoxFit.cover),
                                      color: Colors.black),
                                  child: PrettyQr(
                                    typeNumber: 3,
                                    elementColor: Colors.white,
                                    size: 150,
                                    data: authProvider.usuario.uid,
                                    errorCorrectLevel: QrErrorCorrectLevel.M,
                                    roundEdges: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(padding: const EdgeInsets.symmetric(horizontal: 25),child: Text(
                              'Amigos (${authProvider.listaAmigos.length})',
                              style: GoogleFonts.quicksand(
                                  color: Colors.white, fontSize: 20),
                            ),),
                  
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                  
                          showModalBottomSheet(context: context, builder: (context) {
                            final controller0 = TextEditingController();
                        return Wrap(
                          children: [
                            ListTile(
                              title: Text('Agregar amigo',style: GoogleFonts.quicksand(),),
                            ),
                            ListTile(
                              title: TextField(
                                controller: controller0,
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.quicksand(color:Colors.black,fontSize: 30),
                              ),
                            ),
                            ListTile(
                              title: ElevatedButton(onPressed: () async { 
                  
                                final mensaje = await authProvider.agregarAmigo(numero: controller0.text.trim());
                  
                                Navigator.pop(context);
                  
                                final snackBar = SnackBar(
                                      content:  Text(mensaje),
                                      action: SnackBarAction(
                                      onPressed: (){}, label: '',
                                        ),
                                      );
                  
                      
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          
                               },
                              child: Text("Agregar",style: GoogleFonts.quicksand(color: Colors.white),),
                                
                              ),
                            ),
                            
                          ],
                        );
                      });
                  
                        },
                        child: Container(margin: const EdgeInsets.only(right: 10),padding: const EdgeInsets.all(20),decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.white),borderRadius: BorderRadius.circular(100)
                        ),child: const Icon(Icons.add,color: Colors.white,)),
                      ),
                      Expanded(
                        child: 
                        SizedBox(
                          height: 106,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, int i) => AmigoAvatar(authProvider: authProvider, i: i,), 
                            itemCount: authProvider.listaAmigos.length, 
                            separatorBuilder: (_,__) => const SizedBox(width: 15,),),
                        ))
                    ],
                                  ),
                                ),
                              ],
                            )
                            ,const SizedBox(height: 50),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(vertical: 35),
                        //   child: Sparkline(
                        //     useCubicSmoothing: true,
                        //     fillMode: FillMode.below,
                        //     fillGradient: const LinearGradient(
                        //         begin: Alignment.topCenter,
                        //         end: Alignment.bottomCenter,
                        //         stops: [
                        //           .0,
                        //           1
                        //         ],
                        //         colors: [
                        //           Color.fromRGBO(0, 0, 0, 1),
                        //           Color.fromRGBO(38, 25, 35, 1),
                        //         ]),
                        //     cubicSmoothingFactor: 0.2,
                        //     pointColor: Colors.white,
                        //     data: data,
                        //     lineGradient: const LinearGradient(
                        //       begin: Alignment.centerLeft,
                        //       end: Alignment.centerRight,
                        //       colors: [
                        //         Color.fromRGBO(0, 0, 0, 1),
                        //         Color.fromRGBO(38, 25, 35, 1),
                        //       ],
                        //     ),
                        //     lineWidth: 3,
                        //     enableGridLines: true,
                        //     gridLineLabelPrecision: 6,
                        //     gridLinelabelPrefix: '\$ ',
                        //     gridLineWidth: 1,
                        //     sharpCorners: true,
                        //     gridLineLabelColor: Colors.white,
                        //     gridLineColor: const Color.fromRGBO(244, 27, 91, .1),
                        //     pointsMode: PointsMode.all,
                        //     pointSize: 7.0,
                        //     lineColor: const Color.fromRGBO(244, 27, 91, 1),
                        //   ),
                        // ),
                      ]),
                    ),
                  ),
                ),
              ],
            )));
  }
}

class AmigoAvatar extends StatelessWidget {
  const AmigoAvatar({
    super.key,
    required this.authProvider, required this.i,
  });

  final AuthService authProvider;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
                              GestureDetector(
                                onTap: (){
                                  if(authProvider.amigosEliminar){
                                    authProvider.cambiarEstadoEliminar();

                                  } 
                                },
                                onLongPress: (){
        // authProvider.cambiarEstadoEliminar();
      },
      behavior: HitTestBehavior.translucent,
                                child: Column(children: [Container(
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
                                  
                                ),const SizedBox(height: 10,),SizedBox(width: 85,child: Text(authProvider.listaAmigos[i].nombre,overflow: TextOverflow.ellipsis,style: GoogleFonts.quicksand(color:Colors.white),))]),
                              ),
                              Positioned(top: 0,right: 0,child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: authProvider.amigosEliminar ? 1 :0,
                                child: Container(decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100)
                                ),child: const Icon(Icons.remove,color: Colors.white,size: 30,)),
                              ))
                            ],
    );
  }
}




