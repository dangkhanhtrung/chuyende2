import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

// ================= STATE =================
abstract class DataState {}

class Loading extends DataState {}

class Success extends DataState {
  final int count;
  Success(this.count);
}

// ================= EVENT =================
abstract class DataEvent {}

class Increment extends DataEvent {}

// ================= BLOC =================
class CounterBloc extends Bloc<DataEvent, DataState> {
  int count = 0;

  CounterBloc() : super(Success(0)) {
    on<Increment>((event, emit) async {
      emit(Loading());
      await Future.delayed(const Duration(milliseconds: 600));
      count++;
      emit(Success(count));
    });
  }
}

// ================= APP =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc Counter',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: const MyHomePage(),
      ),
    );
  }
}

// ================= HOME =================
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CounterBloc>();

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text("Bloc Counter"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: const _CounterCard(),
          ),
        ),
      ),

      floatingActionButton: _FancyFAB(
        onTap: () => bloc.add(Increment()),
      ),
    );
  }
}

// ================= CARD =================
class _CounterCard extends StatelessWidget {
  const _CounterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 25,
            offset: const Offset(0, 15),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Counter value",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 20),

          // ===== BLOC BUILDER =====
          BlocBuilder<CounterBloc, DataState>(
            builder: (context, state) {
              if (state is Loading) {
                return const SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is Success) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    '${state.count}',
                    key: ValueKey(state.count),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

// ================= FAB =================
class _FancyFAB extends StatefulWidget {
  final VoidCallback onTap;

  const _FancyFAB({required this.onTap});

  @override
  State<_FancyFAB> createState() => _FancyFABState();
}

class _FancyFABState extends State<_FancyFAB> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.9),
      onTapUp: (_) {
        setState(() => scale = 1);
        widget.onTap();
      },
      onTapCancel: () => setState(() => scale = 1),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.6),
                blurRadius: 20,
              )
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Icon(Icons.add, size: 28),
          ),
        ),
      ),
    );
  }
}