import 'package:example/models/custom_error_message.dart';
import 'package:example/models/custom_info_message.dart';
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
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  String _versionResult = '';

  @override
  void initState() {
    super.initState();
    //Replace info messages with yours. It's optional.
    VersionComparator.instance.setInfoMessages(CustomInfoMessage());

    //Replace error messages with yours. It's optional.
    VersionComparator.instance.setErrorMessages(CustomErrorMessage());
  }

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
      appBar: AppBar(title: const Text('Version Comparator')),
      body: buildVersionCompareWithAlertDialog(),
    );
  }

  //App version compare with widget. It compares android, ios and huawei store versions.
  //Because we add huaweiId. It's so important to compare Huawei apps.
  //If you want to add huaweiId for compare your app with AppGallery. Otherwise it will return error.
  Widget buildVersionCompareWithWidget() {
    return AppVersionComparatorView.widget(
      errorPageBuilder: (_, error) => Center(child: Text(error)),
      onCompareSuccess: (data) => debugPrint('Success: ${data.storeVersion}'),
      outOfDateVersionPageBuilder: (_, error, data) =>
          _buildOutOfDateWidget(error, data),
      huaweiId: 'HUAWEI_APP_ID',
      child: _buildBody(),
    );
  }

  //App version compare with alertDialog. It compares android and ios.
  //Because huawei id is not set. If you run app in the huawei device than you will get error message.
  //Your app is published on the [PlayStore] or [AppStore] than you can pass huaweiId.
  Widget buildVersionCompareWithAlertDialog() {
    return AppVersionComparatorView.alertDialog(
      onCompareSuccess: (data) => debugPrint('Success: ${data.storeVersion}'),
      invalidVersionDialogContentBuilder: (context, message) =>
          Text('Error: $message'),
      child: _buildBody(),
    );
  }

  //Compare app version between local version and store version.
  Future<void> compareVersion() async {
    _setLoading(true);
    final result = await VersionComparator.instance.versionCompare();

    _setLoading(false);
    _setResultMessage(result);
  }

  //Compare app version between local version and store version.
  //If your app is published on the [AppGallery] than you can use this comparator.
  Future<void> compareVersionWithHuawei(String huaweiStoreId) async {
    _setLoading(true);
    final result = await VersionComparator.instance
        .versionCompareWithHuawei(huaweiId: huaweiStoreId);

    _setLoading(false);
    _setResultMessage(result);
  }

  //Custom app version comparator.
  Future<void> customCompareVersion() async {
    _setLoading(true);
    final result = await VersionComparator.instance.customCompare(
      localVersion: '1.0.0',
      store: MyStoreModel(appId: 'YOUR_APP_BUNDLE_ID'),
      customUpdateLink: (body) => 'YOU CAN ADD CUSTOM UPDATE LINK',
      onConvertVersion: (responseBody) {
        final result = MyVersionConvertManager()
            .convert(MyVersionResponseModel.fromResponse(responseBody));
        return result.data;
      },
    );

    _setLoading(false);
    _setResultMessage(result);
  }

  //App version out of date alert dialog function.
  Future<void> _showVersionDialog(VersionResponseModel versionResponseModel,
      {bool isRequired = false}) async {
    await VersionComparator.instance.showSimpleVersionDialog(
      context,
      versionResponseModel,
      isUpdateRequired: isRequired,
    );
  }

  Widget _buildOutOfDateWidget(String error, VersionResponseModel data) {
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
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Compare App Version'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async =>
                await _showVersionDialog(_getResponseExample),
            child: const Text('Show Alert Dialog'),
          ),
        ],
      ),
    );
  }

  void _setResultMessage(DataResult<VersionResponseModel> result) {
    if (result.isNotSuccess || result.data == null) {
      _setResult('Error: ${result.message}');
    } else if (result.data!.isAppVersionOld) {
      _setResultAndShowVersionDialog(
          'Error: App version is old. Please update', result.data!);
    } else {
      _setResult('Success: App version is up to date');
    }
  }

  Future<void> _setResultAndShowVersionDialog(
      String message, VersionResponseModel responseModel) async {
    _setResult(message);
    await _showVersionDialog(responseModel);
  }

  VersionResponseModel get _getResponseExample {
    return VersionResponseModel(
      localVersion: '1.0.0',
      storeVersion: '1.0.1',
      updateLink: 'https://wwww.google.com/',
    );
  }
}
