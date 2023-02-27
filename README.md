<h1 align="center">VersionComparator</h1>
<p align="center">
  <img src="https://user-images.githubusercontent.com/34197392/221657155-c98d1de3-ac8d-4c51-b1cd-b39cfdd3e739.png" width="250px">
</p>
<h2 align="center">Simple, Enjoyable & Customizable Comparator</h2></br>
A Flutter package for compare app version between store and local version.

- 🚀 Compare app version with all stores. (PlayStore, AppStore, AppGallery and Custom)
- ⚡ Customizable & Manageable
- ❤️ Simple, powerful, & manageable structure
- 🔒 Changeable error & info messages with yours.
- 🎈 Display AlertDialog or custom widgets when compare versions.


## App Version Compare Platforms

| Android | iOS | Huawei  | Custom |
|---------|-----|---------|--------|
|    ✔    |  ✔  |    ✔    |    ✔   |


<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Contents</summary>
  <ol>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#features">Features</a></li>
    <li><a href="#other-features">Other Features</a></li>
    <li><a href="#set-custom-messages">Set Custom Messages</a></li>
    <li><a href="#customization">Customization</a></li>
    <li><a href="#parameter-details">Parameter Details</a></li>
  </ol>
</details>

## Usage

Import `package:version_comparator/version_comparator.dart`, and use the widgets or features. That's all your need. You can compare with future operation or widget. Here is some simple comparator examples:

Compare with future operation:

```dart
import 'package:version_comparator/version_comparator.dart';

final response = await VersionComparator.instance.versionCompare();

print(response?.data?.toJson() ?? '-');

////////PRINT////////
//{
//  "localVersion":"1.0.0",
//  "storeVersion":"1.0.1",
//  "updateLink:"https://your_store_link.com,
//  "isAppVersionOld:"true
//}
```

Compare with widget:

```dart
import 'package:version_comparator/version_comparator.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: AppVersionComparatorView.widget(
        errorPageBuilder: (context, error) => Center(child: Text(error)),
        onCompareSuccess: (data) => debugPrint('Success: ${data.storeVersion}'),
        outOfDateVersionPageBuilder: (context, error, data) => _buildOutOfDateWidget(error, data),
        child: _buildBody(),
      ),
    );
  }
```

<table width=100% text-align="center">
	<thead>
		<td>
			<b>Version Compare with AlertDialog</b>
		</td>
		<td>
			<b>Version Compare with Widget</b>
		</td>
	</thead>
	<tr>
		<td>
			<img width="200" alt="code-one" align="center" src="https://user-images.githubusercontent.com/34197392/221685005-94318ff0-63c2-4e03-89a2-2150a44da75a.gif">
		</td>
		<td>
			<img src="https://user-images.githubusercontent.com/34197392/221682663-17a904dc-32d4-4dbd-bf5b-d90ced277b6c.gif" width="200" alt="Example Version Comparator Widget">
		</td>
	</tr>
</table>

## Features

There are many features for version compare. (VersionComparator widgets, future operations, alertDialog manager, custom version comparator).

### Platform Specific Compare:

```dart
import 'package:version_comparator/version_comparator.dart';

  Future<void> compareVersion() async {
    //set loading state
    _setLoading(true); 
    
    // get store and local version result
    final response = await VersionComparator.instance.versionCompare();

    //set loading state
    _setLoading(false);
    
    //display response
    print(result?.data?.toJson() ?? '-');
  }
```

### Custom Compare:

```dart
    await VersionComparator.instance.customCompare(
      localVersion: 'YOUR_APP_VERSION', //example: 1.0.0
      store: MyStoreModel(appId: 'YOUR_APP_BUNDLE_ID'), //example: com.example.app
      customUpdateLink: (body) => 'YOU CAN ADD CUSTOM UPDATE LINK', //example: https://pub.dev/
      
      //Convert store version and return it from response.body
      onConvertVersion: (responseBody) {
        final result = MyVersionConvertManager().convert(MyVersionResponseModel.fromResponse(responseBody));
        return result.data;
      },
    );
```

### Show Version Alert Dialog:

```dart
  await VersionComparator.instance.showSimpleVersionDialog(
      context,
      versionResponseModel,
      isUpdateRequired: isRequired,
  );
```
<p>
  <img src="https://user-images.githubusercontent.com/34197392/221686629-66ee8072-7908-45a7-abd6-ad75c367769c.png" width="200px">
</p>


### Platform Specific Compare Widget:

```dart
      AppVersionComparatorView.widget(
        errorPageBuilder: (context, error) => Center(child: Text(error)),
        onCompareSuccess: (data) => debugPrint('Success: ${data.storeVersion}'),
        outOfDateVersionPageBuilder: (context, error, data) => _buildOutOfDateWidget(error, data),
        child: _buildBody(),
      )
```
<p>
  <img src="https://user-images.githubusercontent.com/34197392/221682663-17a904dc-32d4-4dbd-bf5b-d90ced277b6c.gif" width="200">
</p>
      

### Platform Specific Compare AlertDialog:

```dart
      AppVersionComparatorView.alertDialog(
        onCompareSuccess: (data) => debugPrint('Success: ${data.storeVersion}'),
        onOutOfDateVersionError: (message, data) => debugPrint('Error: $message'),
        child: _buildBody(),
      )
```
			
<p>
  <img width="200" alt="code-one" align="center" src="https://user-images.githubusercontent.com/34197392/221685005-94318ff0-63c2-4e03-89a2-2150a44da75a.gif">
</p>


## Other Features

You can also use these features if you need:

```dart
//Gets bundle id
final bundleResult = await VersionComparator.instance.getBundleId();

//Gets current platform (Android, iOS, Huawei or Undefined)
final platformResult = await VersionComparator.instance.getPlatform();

//Gets current app version
final versionResult = await VersionComparator.instance.getCurrentAppVersion();
```

## Set Custom Messages

You can also customize package error and info messages with yours. It's so simple. If you want to change messages with yours just create a class and extend it from ```ComparatorErrorMessage```or ```ComparatorInfoMessage```. After that override messages with yours. And before using comparator set your custom message classes.

For set Comparator Error Message:

```dart
VersionComparator.instance.setErrorMessages(MyCustomErrorMessage());
```

For set Comparator Info Message:

```dart
VersionComparator.instance.setInfoMessages(MyCustomInfoMessage());
```

Don't forget. If you want to set a few messages use extends, for set all messages than use implements. Here is a simple example:


```dart
//set specific messages extend base class.
class MyCustomErrorMessage extends ComparatorErrorMessage{
  @override
  String get appNotFound => 'App not found in the store.';

  @override
  String get appVersionFetchError => 'app version info couldn\'t fetch.';
}
```

```dart
//For set all messages just implement base class like this
class ClassName implements ComparatorInfoMessage {
  @override
  String get checkVersionErrorDialogTitle => 'custom message;

  @override
  String get checkVersionLoadingMessage => 'custom message;
  
  //..//
}
```

## Customization

If you want to compare app version from another store, it's possible with custom compare methods. Just follow these steps.

### Create StoreModel

Custom compare method needs a store model. Don't forget your model must be extend from ```BaseStoreModel```.

```dart
class MyStoreModel extends BaseStoreModel{

  @override
  String get appId => 'YOUR_BUNDLE_ID_OR_APP_ID'; //for example: 'com.example.app'

  @override
  String get storeUrl => 'YOUR_CUSTOM_STORE_URL_WITH_ENDPOINT'; //for example: 'https://your-store.com/apps/details'

  @override
  String get versionQuery => 'QUERY_OF_STORE_URL_FOR_COMPARE'; //for example: 'appId=com.example.app&lang=en'
}
```

### Create An App Version Converter Function

Custom comparator sends request to store and gets json response. You must create an app version converter function. It's a simple android version converter example:

```dart
class MyVersionConvertManager extends VersionConvertService<MyVersionResponseModel> {
  @override
  DataResult<String> convert(EntityModel<MyVersionResponseModel> entity) {
    final firstMatch = RegExpHelper.androidVersionRegExp.firstMatch(entity.responseBody);

    return _checkRegExpVersion(firstMatch);
  }

  DataResult<String> _checkRegExpVersion(RegExpMatch? regExpMatch) {
    if (regExpMatch == null || regExpMatch.groupCount < 1) {
      return DataResult.error(message: 'Version not matched');
    }

    final version = regExpMatch.group(1);
    return version == null || version.isEmpty
        ? DataResult.error(message: 'Version not matched')
        : DataResult.success(data: version);
  }
}
```

### Set CustomComparator Parameters

After all just set parameters to custom comparator. For example:

```dart
  Future<DataResult<VersionResponseModel>> customCompareVersion() async {
    return await VersionComparator.instance.customCompare(
      localVersion: 'YOUR_APP_VERSION', 
      store: MyStoreModel(appId: 'YOUR_APP_BUNDLE_ID'),
      customUpdateLink: (body) => 'YOU CAN ADD CUSTOM UPDATE LINK (OPTIONAL)',
      onConvertVersion: (responseBody) {
        //Converter function. It returns app version from store.
        final result = MyVersionConvertManager().convert(MyVersionResponseModel.fromResponse(responseBody));
        return result.data;
      },
    );
  }
```

## Parameter Details

Import `package:version_comparator/version_comparator.dart`, and use the widgets or features.

If you don't want to manage Future operations and states just call `AppVersionComparatorView` or `CustomVersionComparatorView` widgets. These widgets manage getting store version and local version, states (loading, error and success) and comparing versions. Also these widgets has two modes (AlertDialog and Widget).

AlertDialog mode displays all state changes in the alert dialog, other mode displays on the widget tree.

Example of app version compare with Widget mode:

```dart
import 'package:version_comparator/version_comparator.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      //All changes will be display on the screen instead of child.
      body: AppVersionComparatorView.widget(
        //If your app id is different to current app than fill this parameter.
        //For example AppGallery (Huawei store) has different app id from app bundle id.
        customAppId: 'CUSTOM_APP_OR_BUNDLE_ID',
        //If any error happens (like socket exception) this builder calls. If this builder is null than it returns child widget.
        errorPageBuilder: (_, error) => Center(child: Text(error)),
        //When fetching data from store this text will be override. If you don't want to any text just pass empty or null.
        loadingText: 'Loading',
        isLoadingTextVisible: true,
        //If you want to required app version upgrade set true. 
        isUpdateRequired: true,
        //You can set loading widget size
        loadingWidgetSize: 36,
        //Custom loading widget
        loadingWidget: const CircularProgressIndicator(),
        //Its calling when version comparing (like null data)
        onCompareError: (message) => debugPrint(message),
        //Its calling when app is up to date.
        onCompareSuccess: (data) => debugPrint('Success: ${data.storeVersion}'),
        //Its calling when app is out of date.
        onOutOfDateVersionError: (message, data) => debugPrint(message),
        //When state changes this method calls
        onStateChanged: (state) => debugPrint('State is: ${state.runtimeType}'),
        //Your page or view.
        child: _buildBody(),
        //When app version is out of date you can set widget with this builder.
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
```

Example of app version compare with AlertDialog mode:

```dart
import 'package:version_comparator/version_comparator.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      //All changes will be display on the screen instead of child.
      body: AppVersionComparatorView.widget(
        //If your app id is different to current app than fill this parameter.
        //For example AppGallery (Huawei store) has different app id from app bundle id.
        huaweiAppId: 'HUAWEI_APP_STORE_ID',
        //If any error happens (like socket exception) this builder calls.
        invalidVersionDialogContentBuilder: (context, message) => Center(child: Text(message)),
        //When fetching data from store this text will be override. If you don't want to any text just pass empty or null.
        loadingText: 'Loading',
        isLoadingTextVisible: true,
        //If you want to required app version upgrade set true. 
        isUpdateRequired: true,
        //You can set loading widget size
        loadingWidgetSize: 36,
        //Custom loading widget
        loadingWidget: const CircularProgressIndicator(),
        //Sets alert cancel button visibility.
        isCancelActionVisible: true,
        //Sets dismissible of alert dialog.
        isDismissibleWhenGetDataError: true,
        //After pop alert dialog this method runs.
        onAfterPopDialog: (result) => debugPrint('alert pop'),
        //Its calling when version comparing (like null data)
        onCompareError: (message) => debugPrint(message),
        //Its calling when app is up to date.
        onCompareSuccess: (data) => debugPrint('Success: ${data.storeVersion}'),
        //Its calling when app is out of date.
        onOutOfDateVersionError: (message, data) => debugPrint(message),
        //When state changes this method calls
        onStateChanged: (state) => debugPrint('State is: ${state.runtimeType}'),
        //Your page or view.
        child: _buildBody(),
      ),
    );
  }
```

Example custom version compare with Widget mode:

```dart
import 'package:version_comparator/version_comparator.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      //All changes will be display on the screen instead of child.
      body: CustomVersionComparatorView.widget(
        //It calls Future method for custom version comparing.
        //You can set your custom Future method but it should be return DataResult<VersionResponseModel>.
        onVersionCompareCallback: () async => await VersionComparator.instance.versionCompare(),
        //If your app id is different to current app than fill this parameter.
        //For example AppGallery (Huawei store) has different app id from app bundle id.
        huaweiAppId: 'HUAWEI_APP_STORE_ID',
        //If any error happens (like socket exception) this builder calls. If this builder is null than it returns child widget.
        errorPageBuilder: (_, error) => Center(child: Text(error)),
        //When fetching data from store this text will be override. If you don't want to any text just pass empty or null.
        loadingText: 'Loading',
        isLoadingTextVisible: true,
        //If you want to required app version upgrade set true. 
        isUpdateRequired: true,
        //You can set loading widget size
        loadingWidgetSize: 36,
        //Custom loading widget
        loadingWidget: const CircularProgressIndicator(),
        //Its calling when version comparing (like null data)
        onCompareError: (message) => debugPrint(message),
        //Its calling when app is up to date.
        onCompareSuccess: (data) => debugPrint('Success: ${data.storeVersion}'),
        //Its calling when app is out of date.
        onOutOfDateVersionError: (message, data) => debugPrint(message),
        //When state changes this method calls
        onStateChanged: (state) => debugPrint('State is: ${state.runtimeType}'),
        //Your page or view.
        child: _buildBody(),
        //When app version is out of date you can set widget with this builder.
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
```

Example custom version compare with AlertDialog mode:

```dart
import 'package:version_comparator/version_comparator.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      //All changes will be display on the screen instead of child.
      body: CustomVersionComparatorView.widget(
        //It calls Future method for custom version comparing.
        //You can set your custom Future method but it should be return DataResult<VersionResponseModel>.
        onVersionCompareCallback: () async => await VersionComparator.instance.versionCompare(),
        //If your app id is different to current app than fill this parameter.
        //For example AppGallery (Huawei store) has different app id from app bundle id.
        huaweiAppId: 'HUAWEI_APP_STORE_ID',
        //If any error happens (like socket exception) this builder calls.
        invalidVersionDialogContentBuilder: (context, message) => Center(child: Text(message)),
        //When fetching data from store this text will be override. If you don't want to any text just pass empty or null.
        loadingText: 'Loading',
        isLoadingTextVisible: true,
        //If you want to required app version upgrade set true. 
        isUpdateRequired: true,
        //You can set loading widget size
        loadingWidgetSize: 36,
        //Custom loading widget
        loadingWidget: const CircularProgressIndicator(),
        //Sets alert cancel button visibility.
        isCancelActionVisible: true,
        //Sets dismissible of alert dialog.
        isDismissibleWhenGetDataError: true,
        //After pop alert dialog this method runs.
        onAfterPopDialog: (result) => debugPrint('alert pop'),
        //Its calling when version comparing (like null data)
        onCompareError: (message) => debugPrint(message),
        //Its calling when app is up to date.
        onCompareSuccess: (data) => debugPrint('Success: ${data.storeVersion}'),
        //Its calling when app is out of date.
        onOutOfDateVersionError: (message, data) => debugPrint(message),
        //When state changes this method calls
        onStateChanged: (state) => debugPrint('State is: ${state.runtimeType}'),
        //Your page or view.
        child: _buildBody(),
      ),
    );
  }
```
