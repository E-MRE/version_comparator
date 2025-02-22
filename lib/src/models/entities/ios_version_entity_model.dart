import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:version_comparator/src/utils/extensions/iterable_extension.dart';

import '../../utils/constants/constants.dart';
import 'entity_model.dart';

part 'ios_version_entity_model.g.dart';

@JsonSerializable()
class IosVersionEntityModel extends EntityModel<IosVersionEntityModel> {
  IosVersionEntityModel({this.resultCount, this.results, String? responseBody})
      : responseBody = responseBody ?? kEmpty;

  @override
  @JsonKey(includeFromJson: false)
  final String responseBody;

  final int? resultCount;
  final List<Map<String, dynamic>>? results;

  String get storeUrl {
    if (results == null || (results?.isEmpty ?? true)) return kEmpty;

    final item = results!
        .firstWhereOrNull((element) => element.containsKey('trackViewUrl'));
    if (item == null) return kEmpty;

    final url = item['trackViewUrl'];
    return url is String ? url : kEmpty;
  }

  String get storeVersion {
    if (results == null || (results?.isEmpty ?? true)) return kEmpty;

    final item =
        results!.firstWhereOrNull((element) => element.containsKey('version'));
    if (item == null) return kEmpty;

    final version = item['version'];
    return version is String ? version : kEmpty;
  }

  factory IosVersionEntityModel.fromResponse(String body) {
    final trimBody = body.replaceAll(kSpace, kEmpty);
    return _$IosVersionEntityModelFromJson(jsonDecode(trimBody));
  }

  @override
  IosVersionEntityModel fromJson(Map<String, dynamic> json) =>
      _$IosVersionEntityModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IosVersionEntityModelToJson(this);
}
