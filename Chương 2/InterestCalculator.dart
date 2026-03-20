class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  State<StatefulWidget> createState() => InterestState();
}

class InterestState extends State<InterestPage> {
  int money = 0;
  int year = 0;
  final moneyController = TextEditingController();
  final interestController = TextEditingController();

  @override
  void dispose() {
    moneyController.dispose();
    interestController.dispose();
    super.dispose();
  }

  void calculateYear() {
    setState(() {
      year = 72 ~/ int.parse(interestController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Máy tính lãi suất", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(6), child: Text("Số tiền", style: TextStyle(fontSize: 22),),),
                Expanded(child: TextField(
                  controller: moneyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập vào số tiền',
                ),))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(6), child: Text("Lãi suất", style: TextStyle(fontSize: 22),),),
                Expanded(child: TextField(
                  controller: interestController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập vào lãi suất',
                ),))
              ],
            ),
            Row(
              children: [
                Padding(padding: const EdgeInsets.all(6), child: Text("Số năm để số tiền tăng gấp đôi: $year", style: const TextStyle(fontSize: 22),),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () { calculateYear(); },
                  child: const Text('Tính toán'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}