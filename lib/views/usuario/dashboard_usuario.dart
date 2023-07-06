import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labartola/packages/sparkline.dart';
import 'package:labartola/views/usuario/grupo.dart';
import 'package:labartola/widgets/consumo.dart';
import 'package:labartola/widgets/eventos.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class DashboardUsuarioView extends StatelessWidget {
  const DashboardUsuarioView({super.key});

  @override
  Widget build(BuildContext context) {
    var data = [
      980.56,
      500.00,
      750.45,
      1900.45,
      98.78,
      2400.54,
      780.00,
    ];
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leadingWidth: 150,
              actions: const [
                Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 25,
                )
              ],
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GrupoView()),
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
                          'Julio Villagrana',
                          style: GoogleFonts.quicksand(
                              color: Colors.white, fontSize: 13),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'MaquinaDeFuego',
                          style: GoogleFonts.quicksand(
                              color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(
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
              centerTitle: true,
              toolbarHeight: 60,
              title: const SizedBox(
                  width: 90,
                  height: 90,
                  child: Image(image: AssetImage('assets/images/logo2.jpeg'))),
            ),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: 35,
                                height: 35,
                                child: Image(
                                    image: NetworkImage(
                                        'https://scontent.fagu2-1.fna.fbcdn.net/v/t39.30808-6/329349825_581028793575102_6527898272697218778_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeF5Lv2e6P-OKvAljp2WXNO4rQ_LRxEZP12tD8tHERk_XYLJi_zZ6HEJRdLv_MFHfcnONJAhqeXDYmo0d329EznM&_nc_ohc=VTPXrD_SKCcAX_DNrq_&_nc_ht=scontent.fagu2-1.fna&oh=00_AfAljy23UfDVzeqj8fdzcieSt_o31fM4dw3VviNPjLwUJA&oe=641E2143')),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Julio te invito a su reservacion',
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white, fontSize: 12),
                                ),
                                Text(
                                  'Hora limite de entrada',
                                  style: GoogleFonts.quicksand(
                                      color: Colors.grey, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 15,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '12/12/25',
                                style:
                                    GoogleFonts.quicksand(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text(
                            '10:00 PM',
                            style: GoogleFonts.quicksand(
                                color: Colors.grey, fontSize: 11),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
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
                            'Proximos eventos...',
                            style: GoogleFonts.quicksand(
                                color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 140,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => EventosWidget(
                            index: index,
                          ),
                          itemCount: 2,
                          separatorBuilder: (_, __) => const SizedBox(
                            width: 20,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      Container(
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
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(38, 25, 35, 1)),
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
                        ),
                      ),
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
              ],
            )));
  }
}
