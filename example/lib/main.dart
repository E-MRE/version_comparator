import 'package:flutter/material.dart';
import 'package:version_comparator/version_comparator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Version Comparator',
      home: MyHomePage(title: 'Example Page'),
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
  bool _isLoading = false;
  String _versionResult = '';

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _setResult(String message) {
    setState(() {
      _versionResult = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(_versionResult, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : () async => _compareVersion(),
              child: _isLoading ? const CircularProgressIndicator() : const Text('Compare App Version'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _compareVersion() async {
    _setLoading(true);
    final result = await VersionComparator.instance.comparePlatformSpecific();
    _setLoading(false);

    if (result.isNotSuccess || result.data == null) {
      _setResult('Error: ${result.message}');
    } else if (result.data!.isAppVersionOld) {
      _setResult('Error: App version is old. Please update');
    } else {
      _setResult('Success: App version is up to date');
    }
  }
}
