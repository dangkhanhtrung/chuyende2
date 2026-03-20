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
      title: 'Profile App',
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
                    "Thông tin cá nhân",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                ),

          drawer: isLarge ? null : _buildDrawer(context),

          body: Row(
            children: [
              // Sidebar desktop
              if (isLarge)
                SizedBox(
                  width: 260,
                  child: _buildDrawer(context),
                ),

              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Profile(
                        avatar: "https://i.imgur.com/EDIzAjb.png",
                        fullName: "Nguyễn Văn A",
                        age: 22,
                        hobby: "Đá bóng",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            label: const Text("Chỉnh sửa"),
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
            leading: const Icon(Icons.person),
            title: const Text("Hồ sơ"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Cài đặt"),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// ================= Profile =================
class Profile extends StatelessWidget {
  final String avatar;
  final String fullName;
  final int age;
  final String hobby;

  const Profile({
    super.key,
    required this.avatar,
    required this.fullName,
    required this.age,
    required this.hobby,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: isWide
                ? Row(
                    children: [
                      _buildAvatar(),
                      const SizedBox(width: 24),
                      Expanded(child: _buildInfo()),
                    ],
                  )
                : Column(
                    children: [
                      _buildAvatar(),
                      const SizedBox(height: 16),
                      _buildInfo(),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.white,
      child: ClipOval(
        child: Image.network(
          avatar,
          width: 110,
          height: 110,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.person, size: 50),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fullName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text("Tuổi: $age", style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 6),
        Text("Sở thích: $hobby", style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}