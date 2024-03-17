import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRscannerScreen extends StatefulWidget {
  const QRscannerScreen({super.key});

  @override
  State<QRscannerScreen> createState() => _QRscannerScreenState();
}

class _QRscannerScreenState extends State<QRscannerScreen> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  String? _previousQRCode;
  final List<String> _scannedQRCodes = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "QRSafe",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 100,
              child: QRView(
                key: _qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text('Scan a QR code'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
      _controller.scannedDataStream.listen((scanData) {
        final scannedQRCode = scanData.code;
        if (scannedQRCode != _previousQRCode) {
          _saveAndSendQRCode(scannedQRCode!);
          print("Scanned QR Code: $scannedQRCode");
          _previousQRCode = scannedQRCode;
        }
      });
    });
  }

  Future<void> _saveAndSendQRCode(String qrCode) async {
    _scannedQRCodes.add(qrCode); // QR 코드 데이터 저장
    await _sendQRCodeToServer(qrCode); // 백엔드 서버로 QR 코드 데이터 전송
    await _showQRCodeDialog(qrCode); // QR 코드 팝업창 표시
  }

  Future<void> _showQRCodeDialog(String qrCode) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR 코드'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('스캔된 QR 코드: $qrCode'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendQRCodeToServer(String qrCode) async {
    final url = Uri.parse('');
    final response = await http.post(url, body: {'url': qrCode});

    if (response.statusCode == 200) {
      print('QR Code 안전성 검사 중..');
    } else {
      print('Network Error!');
      print('네트워크 연결을 확인하세요!');
    }
  }
}
