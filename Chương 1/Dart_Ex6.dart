class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void introduce() {
    print("Xin chào, tôi là $name, $age tuổi");
  }
}

void main() {
  var p = Person("Trung", 22);
  p.introduce();
}