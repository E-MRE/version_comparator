import 'package:flutter/material.dart';
import 'package:version_comparator/version_comparator.dart';

import 'models/my_store_model.dart';
import 'models/my_version_response_model.dart';
import 'services/my_version_convert_manager.dart';

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
      body: PlatformSpecificVersionComparatorView.widget(
        errorPageBuilder: (_, error) => Center(child: Text(error)),
        loadingText: 'Loading',
        isUpdateRequired: true,
        loadingWidgetSize: 36,
        onCompareError: (message) => debugPrint(message),
        onCompareSuccess: (data) => debugPrint('Success: ${data.storeVersion}'),
        onOutOfDateVersionError: (message, data) => debugPrint(message),
        onStateChanged: (state) => debugPrint('State is: ${state.runtimeType}'),
        child: _buildBody(),
        outOfDateVersionPageBuilder: (_, error, data) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text('Out of date version: ${data.localVersion}'),
              Text('New version: ${data.storeVersion}'),
            ],
          );
        },
      ),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(_versionResult, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isLoading ? null : () async => customCompareVersion(),
            child: _isLoading ? const CircularProgressIndicator() : const Text('Compare App Version'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => await _showVersionDialog(_getResponseExample),
            child: const Text('Show Alert Dialog'),
          ),
        ],
      ),
    );
  }

  Future<void> compareVersion() async {
    _setLoading(true);
    final result = await VersionComparator.instance.platformSpecificCompare();

    _setLoading(false);
    _setResultMessage(result);
  }

  Future<void> customCompareVersion() async {
    _setLoading(true);
    final result = await VersionComparator.instance.customCompare(
      localVersion: '1.0.0',
      store: MyStoreModel(appId: 'YOUR_APP_BUNDLE_ID'),
      customUpdateLink: (body) => 'YOU CAN ADD CUSTOM UPDATE LINK',
      onConvertVersion: (responseBody) {
        final result = MyVersionConvertManager().convert(MyVersionResponseModel.fromResponse(responseBody));
        return result.data;
      },
    );

    _setLoading(false);
    _setResultMessage(result);
  }

  void _setResultMessage(DataResult<VersionResponseModel> result) {
    if (result.isNotSuccess || result.data == null) {
      _setResult('Error: ${result.message}');
    } else if (result.data!.isAppVersionOld) {
      _setResultAndShowVersionDialog('Error: App version is old. Please update', result.data!);
    } else {
      _setResult('Success: App version is up to date');
    }
  }

  Future<void> _setResultAndShowVersionDialog(String message, VersionResponseModel responseModel) async {
    _setResult(message);
    await _showVersionDialog(responseModel);
  }

  Future<void> _showVersionDialog(VersionResponseModel versionResponseModel, {bool isRequired = false}) async {
    await VersionComparator.instance.showSimpleVersionDialog(
      context,
      versionResponseModel,
      isUpdateRequired: isRequired,
    );
  }

  VersionResponseModel get _getResponseExample {
    return VersionResponseModel(
      localVersion: '1.0.0',
      storeVersion: '1.0.1',
      updateLink: 'https://wwww.google.com/',
    );
  }
}
