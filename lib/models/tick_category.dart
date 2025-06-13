import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/tick_category.g.dart';

@immutable
@JsonSerializable()
class TickCategoryModel {
  final String id;
  final String name;

  @JsonKey(
    fromJson: _deserializeIcon,
    toJson: serializeIcon,
  )
  final IconData icon;

  const TickCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  //For JSON serialization / deserialization
  factory TickCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$TickCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TickCategoryModelToJson(this);

  static IconData _deserializeIcon(Map<String, dynamic> map) {
    final iconData = deserializeIcon(map, iconPack: IconPack.material);
    return iconData ?? const IconData(58287);
  }
}
