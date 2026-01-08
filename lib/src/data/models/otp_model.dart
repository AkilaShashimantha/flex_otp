import '../../domain/entities/otp_response.dart';

class OtpModel extends OtpResponse {
  OtpModel({required super.sessionId, required super.message, super.isSuccess});

  // Converts JSON from your SMS API to our Entity
  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      sessionId: json['request_id'] ?? '',
      message: json['status'] ?? 'Success',
      isSuccess: json['code'] == '200',
    );
  }
}