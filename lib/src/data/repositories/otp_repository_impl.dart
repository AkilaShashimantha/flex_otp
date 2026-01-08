import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/otp_repository.dart';
import '../../domain/entities/otp_response.dart';

class FirebaseOtpRepositoryImpl implements OtpRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  @override
  Future<OtpResponse> sendOtp(String phoneNumber) async {
    try {
      // Firebase uses a completion logic rather than a direct return
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-resolution (Android only)
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw e;
        },
        codeSent: (String verId, int? resendToken) {
          _verificationId = verId;
        },
        codeAutoRetrievalTimeout: (String verId) {
          _verificationId = verId;
        },
      );
      
      return OtpResponse(
        sessionId: "PENDING", // Firebase handles the ID internally
        message: "OTP sent via Firebase to $phoneNumber",
      );
    } catch (e) {
      return OtpResponse(sessionId: "", message: e.toString(), isSuccess: false);
    }
  }

  @override
  Future<bool> verifyOtp(String sessionId, String code) async {
    try {
      if (_verificationId == null) return false;
      
      // Create a credential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );

      // Sign in the user
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }
}