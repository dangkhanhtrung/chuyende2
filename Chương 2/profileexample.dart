import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(ProfileAppExample());
}

class ProfileAppExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: const Text("Thông tin cá nhân")
        ),
        body: Profile(avatar: "https://i.imgur.com/EDIzAjb.png", fullName: "Nguyễn Văn A", age: 22, hobby: "Đá bóng",),
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

class Profile extends StatelessWidget {
  String avatar;
  String fullName;
  int age;
  String hobby;

  Profile({super.key, required this.avatar, required this.fullName, required this.age, required this.hobby });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text("Họ tên: $fullName", style: const TextStyle(fontSize: 22),),
            Text("Tuổi: $age", style: const TextStyle(fontSize: 22),),
            Text("Sở thích: $hobby", style: const TextStyle(fontSize: 22),),
          ],
        ),
        CircleAvatar(
          radius: 56,
          backgroundColor: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipOval(child: Image.network(avatar)),
          ),
        )
      ],
    );
  }

}