void sayHello(String name) {
  print("Hello $name");
}

void execute(Function func) {
  func("Dart");
}

void main() {
  execute(sayHello);
}