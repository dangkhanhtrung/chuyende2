import 'package:flutter/material.dart';

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
      title: 'Demo UI',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: darkBlue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  bool isDesktop(double width) => width >= 900;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLarge = isDesktop(constraints.maxWidth);

        return Scaffold(
          appBar: isLarge
              ? null
              : AppBar(
                  title: const Text(
                    "Trang ví dụ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                ),

          drawer: isLarge ? null : _buildDrawer(context),

          body: Row(
            children: [
              // ✅ Sidebar desktop
              if (isLarge)
                SizedBox(
                  width: 260,
                  child: _buildDrawer(context),
                ),

              // ✅ Nội dung chính
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: _buildMainCard(),
                    ),
                  ),
                ),
              ),
            ],
          ),

          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text("Thêm"),
          ),
        );
      },
    );
  }

  // ================= Drawer =================
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            accountName: const Text("Khánh Trung"),
            accountEmail: const Text("example@email.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  "https://picsum.photos/200",
                  fit: BoxFit.cover,
                  width: 72,
                  height: 72,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.person, size: 40),
                ),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Trang chủ"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () => Navigator.pop(context),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Cài đặt"),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  // ================= Main Content =================
  Widget _buildMainCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueGrey.shade900,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flutter_dash, size: 60),
            SizedBox(height: 16),

            Text(
              "Ví dụ MaterialApp",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Đây là UI đã được nâng cấp responsive + chuẩn Material 3.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}