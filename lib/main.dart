import 'package:ffi_gen_demo/cm_headphone_manager_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FFI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final provider = CMHeadPhoneManagerProvider();

  @override
  void initState() {
    provider.getInstance();
    super.initState();
  }

  void _initDataCollection() {
    provider.startDeviceMotionUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<double>(
              stream: provider.getAttitudeY(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == 0.0) {
                    return const CircularProgressIndicator();
                  }

                  return Text(
                    'Quaternion Y: ${snapshot.data}',
                    style: const TextStyle(fontSize: 24),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _initDataCollection,
        tooltip: 'Get Data',
        child: const Icon(Icons.add),
      ),
    );
  }
}
