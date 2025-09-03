// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tick_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TickCategoryModel _$TickCategoryModelFromJson(Map<String, dynamic> json) =>
    _TickCategoryModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      icon: _deserializeIcon(json['icon'] as Map<String, dynamic>),
      color: deserializeColor(json['color'] as String),
    );

Map<String, dynamic> _$TickCategoryModelToJson(_TickCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': serializeIcon(instance.icon),
      'color': serializeColor(instance.color),
    };
