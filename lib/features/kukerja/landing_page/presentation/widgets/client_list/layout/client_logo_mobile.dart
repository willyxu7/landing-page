import 'package:flutter/material.dart';

import 'client_logo.dart';

class ClientLogoMobile extends StatelessWidget {
  final List<ClientLogo> clientLogos;

  const ClientLogoMobile({required this.clientLogos, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<SizedBox> logos = [];

    for (ClientLogo clientLogo in clientLogos) {
      SizedBox logo = SizedBox(
          child: Image.asset(clientLogo.imagePath,
            width: screenSize.width * 0.3,
          ));

      logos.add(logo);
      logos.add(const SizedBox(width: 4));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: logos,
    );
  }
}
