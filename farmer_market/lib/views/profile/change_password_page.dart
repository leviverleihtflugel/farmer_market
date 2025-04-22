import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  Future<void> _sendPasswordResetEmail(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user?.email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kullanıcı e-postası alınamadı.')),
      );
      return;
    }

    try {
      // Türkçe e-posta gönderilmesi için dil ayarı
      FirebaseAuth.instance.setLanguageCode("tr");

      await FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('📬 Şifre sıfırlama e-postası gönderildi: ${user.email}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('⚠️ Hata oluştu: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Şifre Değiştir')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Şifreni sıfırlamak için e-posta adresine bir bağlantı gönderilecektir.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _sendPasswordResetEmail(context),
              icon: const Icon(Icons.email),
              label: const Text('E-posta Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
