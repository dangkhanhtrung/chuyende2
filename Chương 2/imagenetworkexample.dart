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
              // ✅ Sidebar khi desktop
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
                      child: _buildImageCard(),
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

            // ✅ Fix lỗi ảnh mạng
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
            leading: const Icon(Icons.image),
            title: const Text("Ảnh"),
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

  // ================= Image Card =================
  Widget _buildImageCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4), // ✅ fix deprecated
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // ✅ Image với fallback
            Image.network(
              'https://picsum.photos/600/400',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 300,
                color: Colors.grey,
                child: const Center(
                  child: Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),

            // ✅ overlay gradient
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            // ✅ text overlay
            const Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                "Ảnh demo responsive",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}