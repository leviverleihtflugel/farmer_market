import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home/customer_home_page.dart';
import '../home/farmer_home_page.dart';
import 'login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          final user = snapshot.data!;
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                return const LoginPage();
              }

              final data = userSnapshot.data!.data() as Map<String, dynamic>;
              final role = data['role'];

              if (role == 'farmer') {
                return const FarmerHomePage();
              } else if (role == 'customer') {
                return const CustomerHomePage();
              } else {
                return const LoginPage();
              }
            },
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
