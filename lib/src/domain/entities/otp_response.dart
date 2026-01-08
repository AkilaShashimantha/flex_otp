class OtpResponse {
  final String sessionId;
  final String message;
  final bool isSuccess;

  OtpResponse({
    required this.sessionId, 
    required this.message, 
    this.isSuccess = true
  });
}