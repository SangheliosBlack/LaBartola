import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labartola/views/usuario/evento_view.dart';

class EventosWidget extends StatelessWidget {
  final int index;
  const EventosWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EventoView()),
        );
      }),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 1, color: Colors.white)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  color: const Color.fromRGBO(38, 25, 35, 1),
                  width: 100,
                  height: 100,
                  child: Image(
                    image: NetworkImage(index == 1
                        ? 'https://scontent.fagu2-1.fna.fbcdn.net/v/t39.30808-6/326225016_1632429903841482_1732220859570176532_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeEGQYvQq2z_b0UCo_OoKFTSN3eFNjahUrk3d4U2NqFSuVk9eOToE-jA4YOxgXQlRp3fKjMLKbmZlAAwttSbKxWP&_nc_ohc=bJRMmoA4Mw8AX-fn_SD&_nc_ht=scontent.fagu2-1.fna&oh=00_AfBFsv4F1mZ3wjN4HIq3Sjan0ooxE6OUh-lAdQpkKoPSTg&oe=641F27D3'
                        : 'https://scontent.fagu2-1.fna.fbcdn.net/v/t39.30808-6/334933149_911804583474372_7300728421868418012_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeEZaRVI_16fXMOws7AEJQRwWOlC88jUHWtY6ULzyNQda59R7jDgd8BtjQw2LLpMT4vLu77sCcXd98FA7TVt7yWN&_nc_ohc=ajTHNiApgjsAX_TV2Cx&_nc_ht=scontent.fagu2-1.fna&oh=00_AfAu9LiXGnSabvhS1sm84KRWBWh6eehXTWKA-JZOVxywmg&oe=641DA290'),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Text(
            index == 0 ? '25/03/2023' : '03/05/2023',
            style: GoogleFonts.quicksand(color: Colors.white),
          )
        ],
      ),
    );
  }
}
