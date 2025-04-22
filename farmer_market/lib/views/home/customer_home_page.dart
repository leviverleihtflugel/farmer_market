import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/product.dart';
import '../auth/login_page.dart';
import '../profile/profile_page.dart'; // 👈 Profil ekranı import edildi

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  Stream<List<Product>> getProducts() {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Product.fromMap(doc.data(), doc.id))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Profil',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Çıkış Yap',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Bir hata oluştu"));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;

          if (products.isEmpty) {
            return const Center(child: Text("Henüz ürün yok"));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return ListTile(
                title: Text(p.name),
                subtitle: Text("${p.price.toStringAsFixed(2)} ₺"),
              );
            },
          );
        },
      ),
    );
  }
}
