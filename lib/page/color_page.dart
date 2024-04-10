import 'package:flutter/material.dart';
import '/main.dart';

class ColorPage extends StatelessWidget {
  const ColorPage(this.setColor, {super.key});

  final void Function(Color) setColor;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(MyApp.title),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Center(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MyColorButton(setColor, Colors.red),
                  MyColorButton(setColor, Colors.orange),
                  MyColorButton(setColor, Colors.greenAccent),
                  MyColorButton(setColor, Colors.indigo),
                ],
              ),
            ),
          ),
        ),
      );
}

class MyColorButton extends StatelessWidget {
  final Color color;
  final void Function(Color) setColor;

  const MyColorButton(this.setColor, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color, elevation: 0),
        onPressed: () {
          setColor(color);
          Navigator.pop(context);
        },
        child: Container(height: 100),
      ),
    );
  }
}
