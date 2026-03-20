import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class DataState {}

class Loading extends DataState {}

class Success extends DataState {
  int count = 0;
  
  Success(this.count);

}

class DataEvent {}

class Increment extends DataEvent {}

class CounterBloc extends Bloc<DataEvent, DataState> {

  int count = 0;

  @override
  DataState get initialState => Success(count);

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is Increment) {
      yield Loading();
      await Future.delayed(Duration(seconds: 1));
      count++;
      yield Success(count);
    }
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}


class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<CounterBloc, DataState>(
              builder: (context, state) {
                if (state is Success) {
                  return Text(
                    '${state.count}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else {
                  return new CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterBloc.add(Increment());
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}