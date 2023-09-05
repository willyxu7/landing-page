import 'dart:convert';
import 'dart:typed_data';

class CreateTalentPoolEnrollmentRequest {
  late Uint8List? bankAccountImage;
  late String bankAccountName;
  late String bankAccountNumber;
  late Uint8List? idCardImage;

  CreateTalentPoolEnrollmentRequest(
      {this.bankAccountImage,
      required this.bankAccountName,
      required this.bankAccountNumber,
      this.idCardImage});

  Map<String, dynamic> toMap() => {
        "bankAccountImage":
            bankAccountImage != null ? base64.encode(bankAccountImage!) : "",
        "bankAccountName": bankAccountName,
        "bankAccountNumber": bankAccountNumber,
        "idCard": idCardImage != null ? base64.encode(idCardImage!) : "",
      };

  String toJson() => jsonEncode(toMap());
}
