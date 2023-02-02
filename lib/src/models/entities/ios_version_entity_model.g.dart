// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ios_version_entity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IosVersionEntityModel _$IosVersionEntityModelFromJson(
        Map<String, dynamic> json) =>
    IosVersionEntityModel(
      resultCount: json['resultCount'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$IosVersionEntityModelToJson(
        IosVersionEntityModel instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'results': instance.results,
    };
