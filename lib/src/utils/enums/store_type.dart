enum StoreType {
  android('play.google.com', 'store/apps/details'),
  ios('itunes.apple.com', ''),
  huawei('', '');

  final String baseUrl;
  final String versionEndpoint;
  const StoreType(this.baseUrl, this.versionEndpoint);
}
