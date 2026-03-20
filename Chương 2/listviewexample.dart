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
              if (isLarge)
                SizedBox(
                  width: 260,
                  child: _buildDrawer(context),
                ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: _buildResponsiveList(constraints.maxWidth),
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
            leading: const Icon(Icons.image),
            title: const Text("Gallery"),
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

  // ================= Responsive List =================
  Widget _buildResponsiveList(double width) {
    int crossAxisCount = 1;

    if (width > 900) {
      crossAxisCount = 4;
    } else if (width > 600) {
      crossAxisCount = 2;
    }

    return GridView.builder(
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return _buildImageCard(index);
      },
    );
  }

  // ================= Card =================
  Widget _buildImageCard(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(
              'https://picsum.photos/300/400?random=$index',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey,
                child: const Center(
                  child: Icon(Icons.broken_image, size: 40),
                ),
              ),
            ),

            // overlay
            Container(
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

            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Text(
                "Ảnh ${index + 1}",
                style: const TextStyle(
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