Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return "Dữ liệu từ server";
}

void main() async {
  print("Bắt đầu");
  var data = await fetchData();
  print(data);
}