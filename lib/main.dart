// import 'package:flutter/material.dart';
// import 'package:qrcode_stability_checker/screens/qr_code.dart';
// import 'package:qrcode_stability_checker/screens/splash_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }



// 팝업창

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Flutter code sample for [Dialog].

void main() => runApp(const DialogExampleApp());

class DialogExampleApp extends StatelessWidget {
  const DialogExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Dialog Sample')),
        body: const Center(
          child: DialogExample(),
        ),
      ),
    );
  }
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.zero,
              // ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('응 팝업이야'),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            final url = Uri.parse(
                              'https://deku.posstree.com/en/',
                            );
                          },
                          child: const Text('Open'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: const Text('Show Dialog'),
        ),
      ],
    );
  }
}
