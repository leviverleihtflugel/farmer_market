import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isSaving = false;

  Future<void> _addProduct() async {
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text.trim()) ?? 0.0;

    if (name.isEmpty || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Geçerli bir ürün adı ve fiyat girin.')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      await FirebaseFirestore.instance.collection('products').add({
        'name': name,
        'price': price,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Ürün başarıyla eklendi!')),
      );

      Navigator.pop(context);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('⚠️ Hata oluştu: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yeni Ürün Ekle')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ürün Adı',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_bag),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Fiyat (₺)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                icon: _isSaving
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
                    : const Icon(Icons.save),
                label: Text(_isSaving ? 'Kaydediliyor...' : 'Ürünü Kaydet'),
                onPressed: _isSaving ? null : _addProduct,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
