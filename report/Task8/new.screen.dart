import 'package:flutter/material.dart';
import 'package:stful_life_cycle/third.screen.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState()
  {
  print('create state of new Screen');
  return _NewScreenState();
}
}

class _NewScreenState extends State<NewScreen> {

  _NewScreenState() {
    print('constructor, mounted: $mounted');
  }

  @override
  void initState() {
    super.initState();
    print('initState, mounted: $mounted');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies, mounted: $mounted');
  }

  @override
  void setState(VoidCallback fn) {
    print('setState');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    print('build method');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("New Screen"),

         ElevatedButton(
           onPressed: () => Navigator.of(context).push(
             MaterialPageRoute(builder: (context) => const ThirdScreen()),
           ),

              child: const Text('Go Next'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate, mounted: $mounted');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose, mounted: $mounted');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('reassemble, mounted: $mounted');
  }
}
