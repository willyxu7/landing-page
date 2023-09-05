import 'dart:convert';
import 'dart:typed_data';

class CreateTalentPoolContractRequest {
  late String type;
  late Uint8List? documentUrl;
  late Uint8List? signatureUrl;

  CreateTalentPoolContractRequest(
      {required this.type,
      required this.documentUrl,
      required this.signatureUrl});

  Map<String, dynamic> toMap() => {
    "type": type,
    "documentUrl": documentUrl != null ? base64.encode(documentUrl!) : "",
    "signatureUrl": signatureUrl != null ? base64.encode(signatureUrl!) : ""
  };

  String toJson() => jsonEncode(toMap());

}
