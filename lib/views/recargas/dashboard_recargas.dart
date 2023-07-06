import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labartola/global/enviroment.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class DashBoardRecargasView extends StatelessWidget {
  const DashBoardRecargasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Recargar a usuario',
          style: GoogleFonts.quicksand(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 110,
              height: 110,
              margin: const EdgeInsets.only(top: 20, bottom: 5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      width: 1, color: const Color.fromRGBO(244, 27, 91, .1))),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                        width: 1,
                        color: const Color.fromRGBO(244, 27, 91, .4))),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 1,
                          color: const Color.fromRGBO(244, 27, 91, 1))),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 1, color: Colors.white)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                          image: NetworkImage(
                              'https://scontent.fagu2-1.fna.fbcdn.net/v/t39.30808-6/329349825_581028793575102_6527898272697218778_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeF5Lv2e6P-OKvAljp2WXNO4rQ_LRxEZP12tD8tHERk_XYLJi_zZ6HEJRdLv_MFHfcnONJAhqeXDYmo0d329EznM&_nc_ohc=VTPXrD_SKCcAX_DNrq_&_nc_ht=scontent.fagu2-1.fna&oh=00_AfBFlZEYIVk1aXEELD6lxv52AAgeJDmYCCMdcat33iIifg&oe=641C2703')),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Julio Villagrana',
              style: GoogleFonts.quicksand(color: Colors.white),
            ),
            const SizedBox(height: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pulsera sincronizada',
                  style: GoogleFonts.quicksand(
                      color: const Color.fromRGBO(250, 180, 4, 1), fontSize: 12),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.sync,
                  color: Colors.white,
                  size: 12,
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: const Color.fromRGBO(244, 27, 91, 1),
                          width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(244, 27, 91, 1),
                                width: 1),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/fondo.jpg'),
                                fit: BoxFit.cover)),
                        child: PrettyQr(
                          typeNumber: 3,
                          elementColor: Colors.white,
                          size: 150,
                          data: 'https://www.google.ru',
                          errorCorrectLevel: QrErrorCorrectLevel.M,
                          roundEdges: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 1,
                            color: Color.fromRGBO(
                                250, 180, 4, index == 2 ? .4 : 0))),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                Color.fromRGBO(250, 180, 4, index == 2 ? 1 : 0),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1,
                                color: Color.fromRGBO(
                                    250, 180, 4, index == 2 ? 1 : 0))),
                        padding:
                            const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        child: Text(
                          '\$ ${Statics.listaRecargas[index]['cantidad'].toString()}',
                          style: GoogleFonts.quicksand(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: Statics.listaRecargas.length,
                separatorBuilder: (_, __) => const SizedBox(
                  width: 10,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                      width: 1, color: const Color.fromRGBO(244, 27, 91, .5))),
              child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(244, 27, 91, 1),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      'Confirmar',
                      style: GoogleFonts.quicksand(color: Colors.white),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
