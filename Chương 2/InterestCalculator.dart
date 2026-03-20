import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interest Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const InterestPage(),
    );
  }
}

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  final moneyController = TextEditingController();
  final interestController = TextEditingController();

  int year = 0;
  String error = '';

  @override
  void dispose() {
    moneyController.dispose();
    interestController.dispose();
    super.dispose();
  }

  void calculateYear() {
    setState(() {
      error = '';

      final interest = double.tryParse(interestController.text);

      if (interest == null || interest <= 0) {
        error = 'Vui lòng nhập lãi suất hợp lệ (> 0)';
        year = 0;
        return;
      }

      year = (72 / interest).round(); // Rule of 72
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Máy tính lãi suất",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Tính thời gian tiền tăng gấp đôi",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Số tiền
                    TextField(
                      controller: moneyController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Số tiền',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Lãi suất
                    TextField(
                      controller: interestController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Lãi suất (%)',
                        prefixIcon: Icon(Icons.percent),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Error
                    if (error.isNotEmpty)
                      Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                      ),

                    const SizedBox(height: 10),

                    // Result
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: year > 0
                          ? Text(
                              "⏳ Số năm để gấp đôi: $year năm",
                              key: ValueKey(year),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            )
                          : const SizedBox(),
                    ),

                    const SizedBox(height: 20),

                    // Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: calculateYear,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        child: const Text("Tính toán"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}