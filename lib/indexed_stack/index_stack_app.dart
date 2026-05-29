import 'package:flutter/material.dart';
import 'package:flutter_pro/indexed_stack/widgets/index_stack_example.dart';

class IndexedStackApp extends StatelessWidget {
  const IndexedStackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('IndexedStack Sample')),
        body: const IndexedStackExample(),
      ),
    );
  }
}
