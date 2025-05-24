import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../product/add_product_page.dart';
import '../auth/login_page.dart';
import '../profile/profile_page.dart';
import '../../views/product/edit_product_page.dart';
import '../../views/product/product_detail_page.dart';
import '../../core/theme/theme_provider.dart';

class FarmerHomePage extends StatefulWidget {
  const FarmerHomePage({super.key});

  @override
  State<FarmerHomePage> createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  String searchQuery = '';
  String sortOption = 'Varsayılan';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Çiftçi Ürün Paneli'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            tooltip: 'Temayı Değiştir',
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ürün ara...',
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: sortOption,
                  dropdownColor: Theme.of(context).cardColor,
                  style: Theme.of(context).textTheme.bodyMedium,
                  items: const [
                    DropdownMenuItem(
                      value: 'Varsayılan',
                      child: Text('Varsayılan'),
                    ),
                    DropdownMenuItem(
                      value: 'Artan',
                      child: Text('Fiyat: Artan'),
                    ),
                    DropdownMenuItem(
                      value: 'Azalan',
                      child: Text('Fiyat: Azalan'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        sortOption = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Bir hata oluştu"));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<Product> products = snapshot.data!;

                if (searchQuery.isNotEmpty) {
                  products = products.where((p) => p.name.toLowerCase().contains(searchQuery)).toList();
                }

                if (sortOption == 'Artan') {
                  products.sort((a, b) => a.price.compareTo(b.price));
                } else if (sortOption == 'Azalan') {
                  products.sort((a, b) => b.price.compareTo(a.price));
                }

                if (products.isEmpty) {
                  return const Center(child: Text("Eşleşen ürün bulunamadı"));
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final p = products[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: p),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: p.imageUrl != null
                                    ? Image.network(
                                  p.imageUrl!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                                    : Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image_not_supported),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.name,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: textColor),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${p.price.toStringAsFixed(2)} ₺",
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Stok: ${p.stockKg} kg",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
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
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
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
