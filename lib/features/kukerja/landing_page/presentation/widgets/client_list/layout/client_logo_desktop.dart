import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/client_list/layout/client_logo.dart';
import 'package:flutter/material.dart';

class ClientLogoDesktop extends StatefulWidget {
  final List<ClientLogo> clientLogos;

  const ClientLogoDesktop({required this.clientLogos, Key? key})
      : super(key: key);

  @override
  State<ClientLogoDesktop> createState() => _ClientLogoDesktopState();
}

class _ClientLogoDesktopState extends State<ClientLogoDesktop> {
  final List<SizedBox> _logos = [];

  @override
  Widget build(BuildContext context) {
    for (ClientLogo clientLogo in widget.clientLogos) {
      SizedBox logo = SizedBox(child: Image.asset(clientLogo.imagePath));

      _logos.add(logo);
      _logos.add(SizedBox(width: SizeConfig.blockSizeHorizontal * 2));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _logos,
    );
  }
}
