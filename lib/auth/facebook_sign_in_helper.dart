import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInHelper {
  static Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow with email and public_profile permissions
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );
      if (result.status != LoginStatus.success) {
        // The user cancelled or there was an error
        return null;
      }

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      // Sign in to Firebase with the Facebook credential
      return await FirebaseAuth.instance.signInWithCredential(
        facebookAuthCredential,
      );
    } catch (e) {
      print('Facebook sign-in error: $e');
      return null;
    }
  }
}
