
import 'package:flutter/material.dart';
import 'package:labartola/services/auth_service.dart';
import 'package:provider/provider.dart';

class SplashLayout extends StatelessWidget {
  const SplashLayout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: FutureBuilder(
            future: checkLoginState(context),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Container(
                  width: width,
                  decoration: const BoxDecoration(
                    
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    border: Border.all(
                        width: 1, color: const Color.fromRGBO(47, 46, 48, .1))),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(
                          width: 2, color: const Color.fromRGBO(47, 46, 48, .5))),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        border: Border.all(
                            width: 3, color: const Color.fromRGBO(47, 46, 48, 1))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: const SizedBox(
                          height: 250,
                          width: 250,
                          child: Image(
                            image: AssetImage('assets/images/mor.jpeg'),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
                  );
            }),
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final isAutenticado = await authService.isLoggedIn();

    if (isAutenticado) {}
  }
}
