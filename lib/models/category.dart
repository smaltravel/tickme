import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/category.g.dart';

@immutable
@JsonSerializable()
class Category {
  final String id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  //For JSON serialization / deserialization
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
