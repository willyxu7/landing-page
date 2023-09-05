class BankResponse {
  late bool success;
  late List<String> banks;

  BankResponse({required this.success, required this.banks});

  factory BankResponse.fromMap(Map<String, dynamic> response) => BankResponse(
      success: response["success"], banks: List<String>.from(response["list"]));
}
