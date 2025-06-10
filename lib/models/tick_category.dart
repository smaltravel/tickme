import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/tick_category.g.dart';

@immutable
@JsonSerializable()
class TickCategoryModel {
  final String id;
  final String name;

  const TickCategoryModel({
    required this.id,
    required this.name,
  });

  //For JSON serialization / deserialization
  factory TickCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$TickCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TickCategoryModelToJson(this);
}
