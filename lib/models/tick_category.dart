import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/tick_category.g.dart';

const unknownTickCategory = TickCategoryModel(
  id: 'unknown',
  name: 'Unknown',
  icon: Icons.question_mark,
  color: Colors.grey,
);

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

  @JsonKey(
    fromJson: _deserializeColor,
    toJson: serializeColor,
  )
  final Color color;

  const TickCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  //For JSON serialization / deserialization
  factory TickCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$TickCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TickCategoryModelToJson(this);

  static IconData _deserializeIcon(Map<String, dynamic> map) {
    final iconData = deserializeIcon(map, iconPack: IconPack.material);
    return iconData ?? const IconData(58287);
  }

  static Color _deserializeColor(String hexColor) {
    return Color(int.parse(hexColor, radix: 16));
  }

  static String serializeColor(Color color) {
    return color.toARGB32().toRadixString(16).padLeft(8, '0');
  }
}
