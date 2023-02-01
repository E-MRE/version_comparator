enum ErrorMessage {
  appNotFound(1, 'App isn\' found in the store. Please check your bundle and try again.'),
  appVersionFetchError(2, 'Downloaded app version can\'t fetch.'),
  appBundleIdFetchError(3, 'Downloaded app bundle id can\'t fetch.'),
  versionNotMatch(4, 'Version information is not found in the response'),
  notLaunchUrl(5, 'Url can\'t launch');

  final int code;
  final String message;
  const ErrorMessage(this.code, this.message);
}
