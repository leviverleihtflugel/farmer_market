import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/product.dart';
import '../product/add_product_page.dart';
import '../auth/login_page.dart';
import '../profile/profile_page.dart';
import '../../views/product/edit_product_page.dart';

class FarmerHomePage extends StatelessWidget {
  const FarmerHomePage({super.key});

  Stream<List<Product>> getProducts() {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Product.fromMap(doc.data(), doc.id))
        .toList());
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Çiftçi Ürün Paneli'),
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
            onPressed: () => _signOut(context),
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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      tooltip: 'Düzenle',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProductPage(
                              productId: p.id,
                              initialName: p.name,
                              initialPrice: p.price,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Sil',
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Ürünü Sil'),
                            content: const Text('Bu ürünü silmek istediğinizden emin misiniz?'),
                            actions: [
                              TextButton(
                                child: const Text('İptal'),
                                onPressed: () => Navigator.pop(context, false),
                              ),
                              TextButton(
                                child: const Text('Sil'),
                                onPressed: () => Navigator.pop(context, true),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          await FirebaseFirestore.instance
                              .collection('products')
                              .doc(p.id)
                              .delete();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
