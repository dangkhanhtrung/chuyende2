void main() 
{
    var numbers = [1, 2, 3];
    var doubled = numbers.map((e) => e * 2).toList();

    print(doubled); // [2, 4, 6]
}