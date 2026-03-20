import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MeterialAppExample());
}

class MeterialAppExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Trang ví dụ")
        ),
        body: Column(
          children: [
            Image.network('https://picsum.photos/seed/picsum/200/300'),
            Image.network('https://picsum.photos/seed/picsum/200/300')
          ]
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Phần đầu ngăn kéo'),
              ),
              ListTile(
                title: const Text('Mục 1'),
                onTap: () {
                  
                },
              ),
              ListTile(
                title: const Text('Mục 2'),
                onTap: () {
                  
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          tooltip: 'Tăng biến đếm',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}