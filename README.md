A Flutter package for compare app version between store and local version.

## App Version Compare Platforms

| Android | iOS | Huawei  | Custom |
|---------|-----|---------|--------|
|    ✔    |  ✔  |    ✔    |    ✔   |








<!-- ## Features
TODO: List what your package can do. Maybe include images, gifs, or videos. 
-->


## Usage

Import `package:version_comparator/version_comparator.dart`, and use the widgets or features.

If you don't want to manage Future operations and states just call `PlatformSpecificVersionComparatorView` or `CustomVersionComparatorView` widgets. These widgets manage getting store version and local version, states (loading, error and success) and comparing versions. Also these widgets has two modes (AlertDialog and Widget).

AlertDialog mode displays all state changes in the alert dialog, other mode displays on the widget tree.

Example PlatformSpecific version compare with Widget mode:

```dart
import 'package:mobile_scanner/mobile_scanner.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      //All changes will be display on the screen instead of child.
      body: PlatformSpecificVersionComparatorView.widget(
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

Example PlatformSpecific version compare with AlertDialog mode:

```dart
import 'package:mobile_scanner/mobile_scanner.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      //All changes will be display on the screen instead of child.
      body: PlatformSpecificVersionComparatorView.widget(
        //If your app id is different to current app than fill this parameter.
        //For example AppGallery (Huawei store) has different app id from app bundle id.
        customAppId: 'CUSTOM_APP_OR_BUNDLE_ID',
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
import 'package:mobile_scanner/mobile_scanner.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      //All changes will be display on the screen instead of child.
      body: CustomVersionComparatorView.widget(
        //It calls Future method for custom version comparing.
        //You can set your custom Future method but it should be return DataResult<VersionResponseModel>.
        onVersionCompareCallback: () async => await VersionComparator.instance.platformSpecificCompare(),
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

Example custom version compare with AlertDialog mode:

```dart
import 'package:mobile_scanner/mobile_scanner.dart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      //All changes will be display on the screen instead of child.
      body: CustomVersionComparatorView.widget(
        //It calls Future method for custom version comparing.
        //You can set your custom Future method but it should be return DataResult<VersionResponseModel>.
        onVersionCompareCallback: () async => await VersionComparator.instance.platformSpecificCompare(),
        //If your app id is different to current app than fill this parameter.
        //For example AppGallery (Huawei store) has different app id from app bundle id.
        customAppId: 'CUSTOM_APP_OR_BUNDLE_ID',
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

