// couldn't pass stateWidget:this (because _MyAppState is private) and
// ColorPage and CounterPage are in different files

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/core_state.dart';
import 'page/color_page.dart';
import 'page/counter_page.dart';
import 'widget/button_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static const String title = 'Inherited Widget';

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CoreState state = const CoreState();

  void incrementCounter() {
    final counter = state.counter + 1;
    final newState = state.copy(counter: counter);

    setState(() => state = newState);
  }

  void setColor(Color backgroundColor) {
    final newState = state.copy(backgroundColor: backgroundColor);

    setState(() => state = newState);
  }

  void setCounter(int counter) {
    final newState = state.copy(counter: counter);

    setState(() => state = newState);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MyApp.title,
        theme: ThemeData(
          scaffoldBackgroundColor: state.backgroundColor,
          primaryColor: Colors.white,
        ),
        home: MainPage(incrementCounter, setCounter, setColor, state.counter),
      );
}

class MainPage extends StatelessWidget {
  const MainPage(
    this.incrementCounter,
    this.setCounter,
    this.setColor,
    this.counter, {
    super.key,
  });

  final void Function() incrementCounter;
  final void Function(int) setCounter;
  final void Function(Color) setColor;
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$counter',
              style: const TextStyle(fontSize: 100),
            ),
            const SizedBox(height: 47),
            ButtonWidget(
              text: 'Change Color',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ColorPage(setColor),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Change Counter',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      CounterPage(setCounter, incrementCounter),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
