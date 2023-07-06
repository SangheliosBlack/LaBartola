import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labartola/widgets/participante.dart';

class EventoView extends StatelessWidget {
  const EventoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                const Image(
                  image: NetworkImage(
                      'https://scontent.fagu2-1.fna.fbcdn.net/v/t39.30808-6/334933149_911804583474372_7300728421868418012_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeEZaRVI_16fXMOws7AEJQRwWOlC88jUHWtY6ULzyNQda59R7jDgd8BtjQw2LLpMT4vLu77sCcXd98FA7TVt7yWN&_nc_ohc=ajTHNiApgjsAX_TV2Cx&_nc_ht=scontent.fagu2-1.fna&oh=00_AfAu9LiXGnSabvhS1sm84KRWBWh6eehXTWKA-JZOVxywmg&oe=641DA290'),
                  fit: BoxFit.cover,
                ),
                ClipPath(
                  clipper: TrapeziumClipper(),
                  child: Container(
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Image(image: AssetImage('assets/images/fondo2.jpg'))
                      ],
                    ),
                  ),
                ),
                // Container(
                //   height: 275,
                //   decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //     stops: const [.4, 1],
                //     colors: [Colors.transparent, Colors.black.withOpacity(1)],
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                //   )),
                // ),
                Positioned(
                  left: 25,
                  top: 30,
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white.withOpacity(.1)),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 25,
                  top: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white.withOpacity(.1)),
                        child: const Center(
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                  color: Color.fromRGBO(38, 25, 35, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    'Reservar',
                    style: GoogleFonts.quicksand(
                        color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'La Bartola Cantina Bar',
                                style: GoogleFonts.quicksand(
                                    color: Colors.white, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Invitado Especial ',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    '@DjArreguin',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(47, 46, 48, 1),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              '\$ 80.00',
                              style: GoogleFonts.quicksand(
                                  color: Colors.white, fontSize: 18),
                            ),
                          )
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
                                    '25',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Marzo',
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
                                    'Sabado',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '10:00 PM - END',
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
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'Acerca del evento',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          ' Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto.  Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto.',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Reservacion ( maximo 6 personas)',
                            style: GoogleFonts.quicksand(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 130,
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Participante(index: index),
                  separatorBuilder: (_, __) => Container(
                        width: 15,
                      ),
                  itemCount: 2),
            )
          ],
        ),
      ),
    );
  }
}

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width / 3.5, 0.0);
    path.lineTo(size.width, 400);
    path.lineTo(0.0, 400);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}
