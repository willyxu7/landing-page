import 'package:flutter/material.dart';
import 'package:kukerja_web/core/widgets/heading_1.dart';
import 'package:kukerja_web/core/widgets/heading_4.dart';
import 'package:kukerja_web/core/widgets/large_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/not-found.png",
                width: 700,
                height: 400,
              ),
              const Heading1(
                text: "Oops! Nothing was found.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Heading4(
                text: "Error code: 404",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LargeButton(
                      text: "Go To Home",
                      onPress: () => QR.to("/")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
