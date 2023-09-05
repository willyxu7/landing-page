import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kukerja_web/core/domain/entities/education_qualification.dart';
import 'package:kukerja_web/core/domain/entities/salary_type.dart';

class FormUtil {
  static const List<String> days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];

  static const List<String> genders = ["Pria", "Wanita"];

  static const List<String> ages = ['Max 35 tahun', 'Max 40 tahun', 'Bebas'];

  static List<EducationQualification> educationQualifications = [
    EducationQualification(
        title: "Min. SMA",
        values: ['SMA', 'SMK', 'D1', 'D2', 'D3', 'D4', 'S1', 'S2', 'S3']),
    EducationQualification(
        title: "Min. Diploma",
        values: ['D1', 'D2', 'D3', 'D4', 'S1', 'S2', 'S3']),
    EducationQualification(title: "Bebas", values: null),
  ];

  static List<SalaryType> salaryTypes = [
    SalaryType(label: "Per Jam", value: "Jam"),
    SalaryType(label: "Per Hari", value: "Hari"),
    SalaryType(label: "Per Bulan", value: "Bulan")
  ];

  static bool isEditForm(String? indexWidget) {
    return indexWidget != null;
  }

  static bool isImageLessThanOneMb(int? fileLengthInBytes) {
    if (fileLengthInBytes != null) {
      num megaByteNumerator = pow(1024, 2);

      var fileInMegaByte = fileLengthInBytes / megaByteNumerator;

      if (fileInMegaByte <= 1) {
        return true;
      }

      return false;
    }

    return true;
  }

  static String removeFirstZeroPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1);
    }

    return phoneNumber;
  }

  static Future<ConfirmationResult> authFirebaseByPhoneNumber(
      String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    return await auth.signInWithPhoneNumber(
        phoneNumber,
        RecaptchaVerifier(
            onError: (error) => print("Error"),
            onExpired: () => print("expired")));
  }

  static Future<String?> confirmOTP(
      ConfirmationResult confirmationResult, String otpCode) async {
    try {
      var userCredential = await confirmationResult.confirm(otpCode);

      String? idToken = await userCredential.user?.getIdToken();

      return idToken;
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static void showToast(BuildContext context,
      [String message = "Masih ada kolom yang belum terisi!"]) {
    Flushbar(
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      message: message,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
