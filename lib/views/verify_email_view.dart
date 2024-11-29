import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verify Email'),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user?.emailVerified ?? false) {
              return const Text("Email already verified");
            } else {
              return Column(
                children: [
                  const Text("Please verify your email"),
                  TextButton(
                    onPressed: () async {
                      await user?.sendEmailVerification();
                    },
                    child: const Text('Send email verification'),
                  )
                ],
              );
            }
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
