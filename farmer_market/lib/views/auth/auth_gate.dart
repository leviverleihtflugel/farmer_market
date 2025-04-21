import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home/customer_home_page.dart';
import '../home/farmer_home_page.dart';
import '../auth/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<Widget> _getHomeForUser(User user) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final role = doc.data()?['role'];

      if (role == 'farmer') {
        return const FarmerHomePage();
      } else if (role == 'customer') {
        return const CustomerHomePage();
      } else {
        return const LoginPage(); // bilinmeyen rol fallback
      }
    } catch (e) {
      debugPrint("AuthGate role fetch error: $e");
      return const LoginPage(); // hata durumunda girişe yönlendir
    }
  }

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

        final user = snapshot.data;

        if (user != null) {
          return FutureBuilder<Widget>(
            future: _getHomeForUser(user),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (roleSnapshot.hasData) {
                return roleSnapshot.data!;
              } else {
                return const LoginPage(); // fallback
              }
            },
          );
        } else {
          return const LoginPage(); // oturum yok
        }
      },
    );
  }
}
