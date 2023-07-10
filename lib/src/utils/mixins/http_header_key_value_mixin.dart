mixin HttpHeaderKeyValueMixin {
  static const contentTypeKey = 'content-type';
  static const interfaceCodeKey = 'interface-code';
  static const applicationJsonValue = 'application/json';

  MapEntry<String, String> getApplicationJsonContentTypeEntry() =>
      const MapEntry<String, String>(contentTypeKey, applicationJsonValue);

  MapEntry<String, String> getInterfaceCodeEntry(String code) => MapEntry<String, String>(interfaceCodeKey, code);
}
