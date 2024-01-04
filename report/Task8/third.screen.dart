import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState()
  {
    print('create state of new Screen');
    return _ThirdScreenState();
  }
}

class _ThirdScreenState extends State<ThirdScreen> {

  _ThirdScreenState() {
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
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
