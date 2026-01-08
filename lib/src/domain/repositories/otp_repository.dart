import '../entities/otp_response.dart';

abstract class OtpRepository {
  /// Sends an OTP to the provided phone number
  Future<OtpResponse> sendOtp(String phoneNumber);

  /// Verifies the OTP code against the session ID
  Future<bool> verifyOtp(String sessionId, String code);
}
