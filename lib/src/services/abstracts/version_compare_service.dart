import '../../models/entities/store/base_store_model.dart';
import '../../models/parameters/get_data_service_parameter_model.dart';
import '../../models/version_response_model.dart';
import '../../utils/constants/constants.dart';
import '../../utils/mixins/launch_url_mixin.dart';
import '../../utils/mixins/package_info_mixin.dart';
import '../../utils/results/data_result.dart';
import 'remote_data_service.dart';

abstract class VersionCompareService with PackageInfoMixin, LaunchUrlMixin {
  BaseStoreModel get store;
  RemoteDataService get dataService;

  Future<DataResult<VersionResponseModel>> getVersion(
      {Map<String, String>? customHeader});
}

abstract class VersionCompareByQueryService extends VersionCompareService {
  /// This function retrieves the store version by querying using custom parameters.
  /// It returns a Future that resolves to a DataResult containing the store version.
  /// Overall, this code asynchronously retrieves the current app version and
  /// then uses it as a parameter to query the store version with custom parameters.
  Future<DataResult<VersionResponseModel>> getVersionByQuery({
    required String? Function(String responseBody) onConvertVersion,
    String? Function(String responseBody)? customUpdateLink,
    Map<String, String>? customHeader,
  }) async {
    // Retrieve the current app version.
    final appVersionResult = await getCurrentAppVersion();
    // If the retrieval of the app version is not successful,
    // return a DataResult with an error message.
    if (appVersionResult.isNotSuccess)
      return DataResult.error(message: appVersionResult.message);

    // Call the getStoreVersionByQuery function with the following parameters:
    // - customHeader: The custom headers provided.
    // - onConvertVersion: The function to convert the response body to a version string.
    // - customUpdateLink: The optional function to provide a custom update link.
    // - localVersion: The app's current version, retrieved from appVersionResult.data.
    //   If appVersionResult.data is null, use the value of kEmpty.
    return getStoreVersionByQuery(
      customHeader: customHeader,
      onConvertVersion: onConvertVersion,
      customUpdateLink: customUpdateLink,
      localVersion: appVersionResult.data ?? kEmpty,
    );
  }

  /// This function retrieves the store version by querying using custom parameters.
  /// It returns a Future that resolves to a DataResult containing the store version.
  /// Overall, this code performs the query to retrieve the store version using the provided parameters,
  /// handles error conditions, and returns a DataResult with the version information.
  Future<DataResult<VersionResponseModel>> getStoreVersionByQuery({
    required String? Function(String responseBody) onConvertVersion,
    required String localVersion,
    String? Function(String responseBody)? customUpdateLink,
    Map<String, String>? customHeader,
  }) async {
    // Create a GetDataServiceParameterModel object with the following parameters:
    // - url: The store's URL.
    // - query: The version query for the store.
    // - header: The custom headers provided.
    final parameter = GetDataServiceParameterModel(
      url: store.storeUrl,
      query: store.versionQuery,
      header: customHeader,
    );

    // Call the getData() method of the dataService with the parameter object.
    // The response is stored in the 'response' variable.
    final response = await dataService.getData(parameter);

    // If the response is not successful or the data is null,
    // return a DataResult with an error message.
    if (response.isNotSuccess || response.data == null) {
      return DataResult.error(message: response.message);
    }

    // Call the onConvertVersion function with the response data.
    // The result is stored in the 'version' variable.
    final version = onConvertVersion.call(response.data!);

    // If the version is null or empty, return a DataResult with an error message.
    if (version == null || version.isEmpty) {
      return DataResult.error(message: kErrorMessage.versionResponseNull);
    }

    // Create a VersionResponseModel object with the following parameters:
    // - localVersion: The app's current version.
    // - storeVersion: The converted version obtained from the response.
    // - updateLink: The custom update link if available, otherwise the URL from the parameter object.
    return DataResult.success(
      data: VersionResponseModel(
        localVersion: localVersion,
        storeVersion: version,
        updateLink:
            customUpdateLink?.call(response.data!) ?? parameter.getUrl(),
      ),
    );
  }
}
