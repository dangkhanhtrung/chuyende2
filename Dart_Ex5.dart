String? name; // có thể null

void main() {
  print(name?.length); // không crash
}