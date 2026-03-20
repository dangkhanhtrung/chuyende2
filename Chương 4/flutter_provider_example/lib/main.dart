import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

// ================= PROVIDER =================
class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

// ================= APP =================
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

// ================= HOME =================
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text('Counter App'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: const _CounterCard(),
          ),
        ),
      ),

      floatingActionButton: const _FancyFAB(),
    );
  }
}

// ================= CARD =================
class _CounterCard extends StatelessWidget {
  const _CounterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'You have pushed the button:',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),
          Count(),
        ],
      ),
    );
  }
}

// ================= COUNT =================
class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = context.watch<Counter>().count;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: Text(
        '$count',
        key: ValueKey(count),
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

// ================= FAB =================
class _FancyFAB extends StatefulWidget {
  const _FancyFAB();

  @override
  State<_FancyFAB> createState() => _FancyFABState();
}

class _FancyFABState extends State<_FancyFAB> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.9),
      onTapUp: (_) {
        setState(() => scale = 1);
        context.read<Counter>().increment();
      },
      onTapCancel: () => setState(() => scale = 1),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.6),
                blurRadius: 15,
                spreadRadius: 1,
              )
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Icon(Icons.add, size: 28),
          ),
        ),
      ),
    );
  }
}