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
              ? null // desktop không cần appbar
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
              // ✅ Sidebar cho desktop
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
                      child: _buildCard(),
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

            // ✅ FIX lỗi NetworkImage
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  "https://picsum.photos/200", // URL ổn định hơn
                  fit: BoxFit.cover,
                  width: 72,
                  height: 72,

                  // fallback nếu lỗi
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 40);
                  },
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
            leading: const Icon(Icons.settings),
            title: const Text("Cài đặt"),
            onTap: () => Navigator.pop(context),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Thông tin"),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  // ================= Card =================
  Widget _buildCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        gradient: LinearGradient(
          colors: [
            Colors.blue.shade700,
            Colors.blue.shade400,
          ],
        ),

        // ✅ FIX withOpacity deprecated
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.dashboard, size: 50),
            const SizedBox(height: 12),

            const Text(
              "Dashboard Card",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "UI đã được nâng cấp responsive + fix lỗi ảnh + chuẩn Flutter mới.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black.withValues(alpha: 0.25),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: const Text("Hành động"),
            )
          ],
        ),
      ),
    );
  }
}