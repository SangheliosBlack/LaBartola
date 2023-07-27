import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labartola/views/usuario/participante_view.dart';

class Participante extends StatelessWidget {
  const Participante({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ParticipanteView(
                  )),
        );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 7),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 1, color: Colors.white)),
            child: SizedBox(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Image(
                  image: NetworkImage(
                      'https://scontent.fagu2-1.fna.fbcdn.net/v/t39.30808-6/304850340_5497225080343195_4848020560504729708_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHWfEJEK28N4jDHU4kGV5xl9WTZfw5EfXn1ZNl_DkR9eaQnx604MsJ8DeVaJLztB5vO09VZ_7KPGa-u7CHiNH3I&_nc_ohc=9c0wZMpXZCkAX9q7oVq&_nc_ht=scontent.fagu2-1.fna&oh=00_AfAawUHkAZbjKLA_73dztqXEklS4HZj3ukDWlDspdqVgTw&oe=641EC7CF'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            'Luis',
            style: GoogleFonts.quicksand(
              color: Colors.white,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
