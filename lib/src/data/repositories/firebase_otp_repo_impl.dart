import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/otp_response.dart';
import '../../domain/repositories/otp_repository.dart';

class FirebaseOtpRepositoryImpl implements OtpRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // This variable stores the verification ID needed to confirm the OTP
  String? _verificationId;

  @override
  Future<OtpResponse> sendOtp(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        // Triggered when SMS is successfully sent
        codeSent: (String verId, int? resendToken) {
          _verificationId = verId;
        },
        // Triggered if there is an error (e.g., wrong phone format)
        verificationFailed: (FirebaseAuthException e) {
          throw e;
        },
        // Triggered for automatic code retrieval (Android only)
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verId) {
          _verificationId = verId;
        },
        timeout: const Duration(seconds: 60),
      );

      return OtpResponse(
        sessionId: "FIREBASE_PENDING",
        message: "OTP sent successfully to $phoneNumber",
      );
    } catch (e) {
      return OtpResponse(
        sessionId: "",
        message: "Firebase Error: ${e.toString()}",
        isSuccess: false,
      );
    }
  }

  @override
  Future<bool> verifyOtp(String sessionId, String code) async {
    try {
      if (_verificationId == null) return false;

      // Create a credential using the code the user typed
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );

      // Sign in the user with that credential
      await _auth.signInWithCredential(credential);
      return true; // If sign-in succeeds, OTP is valid
    } catch (e) {
      print("Verification failed: $e");
      return false;
    }
  }
}