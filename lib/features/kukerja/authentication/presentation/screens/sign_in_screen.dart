import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/utils/company_information_util.dart';
import 'package:kukerja_web/core/widgets/heading_2.dart';
import 'package:kukerja_web/core/widgets/horizontal_or_line.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/core/widgets/small_outline_button.dart';
import 'package:kukerja_web/features/kukerja/landing_page/style/app_color.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SignInScreen extends StatelessWidget {
  static const String route = "/sign-in";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SizedBox(
        child: Row(
          children: [
            if(!ResponsiveWidget.isSmallScreen(context)) Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(color: AppColor.primary),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/john-hey.png",
                          fit: BoxFit.fitWidth, width: 320),
                      const SizedBox(height: 60),
                      SizedBox(
                        width: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Heading2(
                              textColor: Colors.white,
                              text: "Selamat Datang di Kukerja",
                            ),
                            const SizedBox(height: 20),
                            RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: CompanyInformationUtil
                                            .secondaryFontFamily),
                                    text: "Bergabung Bersama \n",
                                    children: [
                                      TextSpan(
                                          text: "20000+ ",
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: "Pekerja Terdaftar \n"),
                                      TextSpan(text: "dan Lebih dari \n"),
                                      TextSpan(
                                          text: "1800+ ",
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: "Lowongan Kerja Tersedia"),
                                    ]))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 48.0, vertical: 16.0),
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Center(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Image.asset(
                                      "assets/images/kukerja_logo.png",
                                      fit: BoxFit.fitWidth,
                                      width: 240),
                                ),
                                onTap: () => QR.to("/"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                          child: Column(
                        children: [
                          SmallButton(
                            text: "Cari Pekerjaan?",
                            onPressed: () => QR.to("/sign-in/job-seeker"),
                            buttonSize: const Size.fromHeight(50),
                          ),
                          const SizedBox(height: 20),
                          HorizontalOrLine(
                            label: "atau",
                            thickness: 1,
                            textColor: AppColor.primary,
                            color: AppColor.primary.withOpacity(0.3),
                          ),
                          const SizedBox(height: 20),
                          SmallOutlineButton(
                            fontSize: 16,
                            text: "Sedang Cari Karyawan?",
                            onPressed: () => QR.to("/sign-in/employer"),
                            buttonSize: const Size.fromHeight(50),
                            borderColor: AppColor.secondary,
                            primaryColor: AppColor.secondary,
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
