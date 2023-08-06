import 'package:flutter/material.dart';

import 'html.dart';
import 'syncfusion_flutter_xlsio.dart';

void main() {
  runApp(MaterialApp(
    title: 'Reporter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reporter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HtmlReportGenerator(),
              )),
              child: const Text('html'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SfXlsioReportGenerator(),
              )),
              child: const Text('syncfusion_flutter_xlsio'),
            ),
          ],
        ),
      ),
    );
  }
}
