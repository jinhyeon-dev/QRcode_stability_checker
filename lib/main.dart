import 'package:flutter/material.dart';
import 'package:qrcode_stability_checker/screens/qr_code.dart';
import 'package:qrcode_stability_checker/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QRscannerScreen(),
    );
  }
}
