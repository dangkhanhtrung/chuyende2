import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

const Color darkBlue = Color(0xFF12202F);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Config',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: darkBlue,
      ),
      home: const EventConfigPage(),
    );
  }
}

class EventConfigPage extends StatefulWidget {
  const EventConfigPage({super.key});

  @override
  State<EventConfigPage> createState() => _EventConfigPageState();
}

class _EventConfigPageState extends State<EventConfigPage> {
  bool enableNotification = false;
  int notifyBefore = 10;
  TimeOfDay eventTime = const TimeOfDay(hour: 18, minute: 0);
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      enableNotification = prefs.getBool('enable') ?? false;
      notifyBefore = prefs.getInt('before') ?? 10;
      nameController.text = prefs.getString('name') ?? '';
      final hour = prefs.getInt('hour') ?? 18;
      final minute = prefs.getInt('minute') ?? 0;
      eventTime = TimeOfDay(hour: hour, minute: minute);
    });
  }

  Future<void> _saveConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enable', enableNotification);
    await prefs.setInt('before', notifyBefore);
    await prefs.setString('name', nameController.text);
    await prefs.setInt('hour', eventTime.hour);
    await prefs.setInt('minute', eventTime.minute);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Đã lưu cấu hình")),
    );
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: eventTime,
    );
    if (picked != null) {
      setState(() => eventTime = picked);
    }
  }

  bool isDesktop(double width) => width >= 700;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = isDesktop(constraints.maxWidth);

        return Scaffold(
          appBar: AppBar(
            title: const Text("Cấu hình sự kiện"),
            centerTitle: true,
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Thiết lập thông báo",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),

                        // Toggle
                        SwitchListTile(
                          title: const Text("Bật thông báo"),
                          value: enableNotification,
                          onChanged: (v) =>
                              setState(() => enableNotification = v),
                        ),

                        // Event name
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Tên sự kiện",
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Time picker
                        ListTile(
                          title: const Text("Giờ sự kiện"),
                          subtitle: Text(eventTime.format(context)),
                          trailing: const Icon(Icons.access_time),
                          onTap: _pickTime,
                        ),

                        const SizedBox(height: 10),

                        // Slider
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Báo trước: $notifyBefore phút"),
                            Slider(
                              min: 1,
                              max: 60,
                              divisions: 59,
                              value: notifyBefore.toDouble(),
                              onChanged: (v) =>
                                  setState(() => notifyBefore = v.toInt()),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _saveConfig,
                            icon: const Icon(Icons.save),
                            label: const Text("Lưu cấu hình"),
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
      },
    );
  }
}