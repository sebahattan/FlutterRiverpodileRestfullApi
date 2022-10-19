import 'package:flutter/material.dart';
import 'package:flutter_api/view/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Grock.navigationKey,//sayfa degıstırmek ıcın
      scaffoldMessengerKey: Grock.scaffoldMessengerKey,
      title: 'Material App',
      home:HomePage(),
    );
  }
}
