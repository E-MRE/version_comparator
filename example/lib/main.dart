// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      body: VersionCompareWrapper(
        futureCallback: () async {
          await Future.delayed(const Duration(seconds: 5));
          return VersionComparator.instance.customCompare<MyVersionResponseModel>(
            parameterModel: _getParameter,
          );
        },
        dialogService: VersionComparator.instance.dialogService,
        child: _buildBody(),
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
    final result = await VersionComparator.instance.comparePlatformSpecific();

    _setLoading(false);
    _setResultMessage(result);
  }

  Future<void> customCompareVersion() async {
    _setLoading(true);
    final result = await VersionComparator.instance.customCompare<MyVersionResponseModel>(
      parameterModel: _getParameter,
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

  CustomVersionCompareParameterModel<MyVersionResponseModel> get _getParameter {
    return CustomVersionCompareParameterModel<MyVersionResponseModel>(
      parseModel: MyVersionResponseModel.empty(),
      currentAppVersion: 'YOUR_DOWNLOADED_APP_VERSION',
      versionConvertService: MyVersionConvertManager(),
      store: MyStoreModel(appId: 'YOUR_APP_BUNDLE_ID'),
    );
  }

  VersionResponseModel get _getResponseExample {
    return VersionResponseModel(
      appVersion: '1.0.0',
      storeVersion: '1.0.1',
      updateLink: 'https://wwww.google.com/',
    );
  }
}
