// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../tick_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TickCategoryModel _$TickCategoryModelFromJson(Map<String, dynamic> json) =>
    TickCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: TickCategoryModel._deserializeIcon(
          json['icon'] as Map<String, dynamic>),
      color: TickCategoryModel._deserializeColor(json['color'] as String),
    );

Map<String, dynamic> _$TickCategoryModelToJson(TickCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': serializeIcon(instance.icon),
      'color': TickCategoryModel.serializeColor(instance.color),
    };
