import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ParticipanteView extends StatelessWidget {
  const ParticipanteView({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          elevation: 0, backgroundColor: Colors.transparent, centerTitle: true),
      body: Container(
        height: 165,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 1, color: Colors.white)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 80,
                  height: 80,
                  child: Image(
                    image: NetworkImage(
                        'https://scontent.fagu2-1.fna.fbcdn.net/v/t39.30808-6/329349825_581028793575102_6527898272697218778_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeF5Lv2e6P-OKvAljp2WXNO4rQ_LRxEZP12tD8tHERk_XYLJi_zZ6HEJRdLv_MFHfcnONJAhqeXDYmo0d329EznM&_nc_ohc=VTPXrD_SKCcAX_DNrq_&_nc_ht=scontent.fagu2-1.fna&oh=00_AfAljy23UfDVzeqj8fdzcieSt_o31fM4dw3VviNPjLwUJA&oe=641E2143'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Julio Villagrana',
                  style:
                      GoogleFonts.quicksand(color: Colors.white, fontSize: 25),
                ),
                Text(
                  'MaquinaDeFuego',
                  style: GoogleFonts.quicksand(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
