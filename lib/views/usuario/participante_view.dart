// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labartola/services/auth_service.dart';
import 'package:labartola/views/usuario/dashboard_usuario.dart';
import 'package:provider/provider.dart';

class ParticipanteView extends StatelessWidget {
  const ParticipanteView({super.key});


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(33, 32, 34, 1),
      appBar: AppBar(
          elevation: 0, backgroundColor: Colors.transparent, centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 165,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 80,
                      height: 80,
                      padding: const EdgeInsets.all(10),
                      child: const Image(
                        image: AssetImage('assets/images/forma-abstracta.png')
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              authProvider.usuario.nombre,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  GoogleFonts.quicksand(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                      Text(
                             "Usuario" ,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  GoogleFonts.quicksand(color: Colors.grey, fontSize: 17),
                            )
                    ],
                  ),
                ),
                
              ],
            ),
          ),
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
                      return Wrap(
                        children: [
                          ListTile(
                            title: Text('Agregar amigo',style: GoogleFonts.quicksand(),),
                          ),
                          ListTile(
                            title: TextField(
                              keyboardType: TextInputType.phone,
                              style: GoogleFonts.quicksand(color:Colors.black,fontSize: 30),
                            ),
                          ),
                          ListTile(
                            title: Text("Agregar",style: GoogleFonts.quicksand(color: Colors.white),),
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
          ),
          const Spacer(),
          GestureDetector(
            onTap: (){
              authProvider.logout();
              Navigator.pop(context);
            },
            child: Container(width: double.infinity,margin: const EdgeInsets.all(25),padding: const EdgeInsets.all(15),decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25)
            ),child: Center(child: Text("Cerrar sesion",style: GoogleFonts.quicksand(color:Colors.white,fontSize: 20),))),
          )
        ],
      ),
    );
  }
}
