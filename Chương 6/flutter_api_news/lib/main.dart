import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

const Color darkBlue = Color(0xFF0F172A);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bản tin Bìm Bịp',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: darkBlue,
      ),
      home: const NewsPage(),
    );
  }
}

// ================= API =================
class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://69bd5ea82bc2a25b22ae63f0.mockapi.io/api",
    ),
  );

  Future<List<dynamic>> getPosts() async {
    final res = await dio.get("/post");
    return res.data;
  }

  Future<Map<String, dynamic>> getPostDetail(String id) async {
    final res = await dio.get("/post/$id");
    return res.data;
  }
}

// ================= PAGE =================
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final api = ApiService();
  List posts = [];
  bool loading = true;

  final categories = ["Tất cả", "Chứng khoán", "Crypto", "Vĩ mô", "Doanh nghiệp"];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    final data = await api.getPosts();
    setState(() {
      posts = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final featured = posts.isNotEmpty ? posts.first : null;
    final list = posts.length > 1 ? posts.sublist(1) : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Trà đá EAUT"),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: fetch,
        child: ListView(
          children: [
            // ================= CATEGORY =================
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: categories.length,
                itemBuilder: (_, i) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: i == 0 ? Colors.blue : Colors.blueGrey.shade800,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(categories[i]),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // ================= FEATURED =================
            if (featured != null)
              GestureDetector(
                onTap: () => _openDetail(featured["id"]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            featured["image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        featured["title"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 10),

            // ================= LIST =================
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (_, i) {
                final p = list[i];
                return _NewsItem(post: p, onTap: () => _openDetail(p["id"]));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewsDetailPage(id: id),
      ),
    );
  }
}

// ================= ITEM =================
class _NewsItem extends StatelessWidget {
  final Map post;
  final VoidCallback onTap;

  const _NewsItem({required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 110,
                height: 80,
                child: Image.network(
                  post["image"],
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post["title"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    post["summary"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ================= DETAIL =================
class NewsDetailPage extends StatefulWidget {
  final String id;

  const NewsDetailPage({super.key, required this.id});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final api = ApiService();
  Map? post;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    final data = await api.getPostDetail(widget.id);
    setState(() {
      post = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = post?["title"] ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                post!["image"],
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              post!["summary"],
              style: TextStyle(color: Colors.grey.shade400),
            ),
            const SizedBox(height: 12),
            Text(
              post!["content"],
              style: const TextStyle(height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}