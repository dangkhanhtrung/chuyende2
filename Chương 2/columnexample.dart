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
      title: 'Demo App',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trang ví dụ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // Drawer đẹp hơn
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              accountName: const Text("Khánh Trung"),
              accountEmail: const Text("example@email.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/300',
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trang chủ'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Cài đặt'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Thông tin'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // Body responsive
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2;

          if (constraints.maxWidth > 900) {
            crossAxisCount = 4; // desktop
          } else if (constraints.maxWidth > 600) {
            crossAxisCount = 3; // tablet
          }

          return Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        'https://picsum.photos/300/400?random=$index',
                        fit: BoxFit.cover,
                      ),

                      // overlay gradient
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),

                      // text
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Text(
                          "Ảnh ${index + 1}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),

      // FAB đẹp hơn
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text("Thêm"),
      ),
    );
  }
}