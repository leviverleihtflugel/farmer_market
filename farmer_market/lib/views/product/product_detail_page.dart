import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Detayı'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: textColor),
            ),
            const SizedBox(height: 12),
            Text(
              "${product.price.toStringAsFixed(2)} ₺",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: textColor),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.scale, size: 20),
                const SizedBox(width: 8),
                Text(
                  "Stok: ${product.stockKg} kg",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (product.description != null && product.description!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Açıklama:", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(product.description!, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            const SizedBox(height: 24),
            if (product.sellerPhone != null && product.sellerPhone!.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.phone, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    product.sellerPhone!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
