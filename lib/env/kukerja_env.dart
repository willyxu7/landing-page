import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kukerja_web/env/env.dart';
import 'dart:html' as html;

class KukerjaEnv {
  static const String _appLink = Env.kukerjaAppLink;
  static const String _fbLink = Env.kukerjaFbLink;
  static const String _igLink = Env.kukerjaIgLink;
  static const String _ytLink = Env.kukerjaYtLink;
  static const String _kukerjaContactUsLink = Env.kukerjaContactUsLink;
  static const String _kukerjaWaLink = Env.kukerjaWaLink;
  static const String _freetalentWaLink = Env.freetalentWaLink;
  static const String _sultantWaLink = Env.sultanWaLink;
  static const String _recommendedWebLink = Env.recommendedWebLink;
  static const String _recommendedAndroidLink = Env.recommendedAndroidLink;

  static void launchKukerjaAppLink() async {
    // if (!await launch(_appLink)) throw 'Could not launch $_appLink';
    if (!await launchUrl(Uri.parse(_appLink))) {
      throw 'Could not launch $_appLink';
    }
  }

  static void launchKukerjaFbLink() async {
    if (!await launchUrl(Uri.parse(_fbLink))) throw 'Could not launch $_fbLink';
  }

  static void launchKukerjaIgLink() async {
    if (!await launchUrl(Uri.parse(_igLink))) throw 'Could not launch $_igLink';
  }

  static void launchKukerjaYtLink() async {
    if (!await launchUrl(Uri.parse(_ytLink))) throw 'Could not launch $_ytLink';
  }

  static void launchKukerjaContactUsLink() async {
    if (!await launchUrl(Uri.parse(_kukerjaContactUsLink))) {
      throw 'Could not launch $_kukerjaContactUsLink';
    }
  }

  static void launchKukerjaWaLink() async {
    if (!await launchUrl(Uri.parse(_kukerjaWaLink))) {
      throw 'Could not launch $_kukerjaWaLink';
    }
  }

  static void launchFreetalentWaLink() async {
    if (!await launchUrl(Uri.parse(_freetalentWaLink))) {
      throw 'Could not launch $_freetalentWaLink';
    }
  }

  static void launchSultanWaLink() async {
    if (!await launchUrl(Uri.parse(_sultantWaLink))) {
      throw 'Could not launch $_sultantWaLink';
    }
  }

  static void launchRecommendedWebLink() async {
    if (!await launchUrl(Uri.parse(_recommendedWebLink))) {
      throw 'Could not launch $_recommendedWebLink';
    }
  }

  static void launchRecommendedAndroidLink() async {
    if (!await launchUrl(Uri.parse(_recommendedAndroidLink))) {
      throw 'Could not launch $_recommendedAndroidLink';
    }
  }

  static void launchJobSeekerProfile(String profileLink) async {
    if (!await launchUrl(Uri.parse(profileLink))) {
      throw 'Could not launch $profileLink';
    }
  }

  static void launchPaymentSnap(String paymentSnapLink) async {
    // if (!await launch(
    //   paymentSnap,
    //   forceSafariVC: false,
    // )) throw 'Could not launch $paymentSnap';

    if (await canLaunch(paymentSnapLink)) {
      if (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.iOS) {
        html.window.location.href = paymentSnapLink;
        // js.context.callMethod('openLink', [paymentSnapLink, '_blank']);
      } else {
        await launchUrl(Uri.parse(paymentSnapLink));
      }
    } else {
      throw 'Could not launch $paymentSnapLink';
    }
  }
}
