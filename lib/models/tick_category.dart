// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tickme/common/utils/colors.dart';

part 'generated/tick_category.freezed.dart';
part 'generated/tick_category.g.dart';

const unknownTickCategory = TickCategoryModel(
  id: null,
  name: 'Unknown',
  icon: unknownTickIcon,
  color: Colors.grey,
);

const unknownTickIcon = IconPickerIcon(
  name: 'unknown',
  data: Icons.question_mark,
  pack: IconPack.material,
);

@freezed
abstract class TickCategoryModel with _$TickCategoryModel {
  const TickCategoryModel._();

  const factory TickCategoryModel({
    int? id,
    required String name,
    @JsonKey(
      fromJson: _deserializeIcon,
      toJson: _serializeIcon,
    )
    required IconPickerIcon icon,
    @JsonKey(
      fromJson: deserializeColor,
      toJson: serializeColor,
    )
    required Color color,
  }) = _TickCategoryModel;

  //For JSON serialization / deserialization
  factory TickCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$TickCategoryModelFromJson(json);

  factory TickCategoryModel.fromRow({
    required int id,
    required String name,
    required String icon,
    required String color,
  }) =>
      TickCategoryModel(
        id: id,
        name: name,
        icon: deserializeIcon(jsonDecode(icon)) ?? unknownTickIcon,
        color: deserializeColor(color),
      );

  String get iconString => _serializeIcon(icon);
  String get colorString => serializeColor(color);
}

IconPickerIcon _deserializeIcon(String jsonMap) {
  return deserializeIcon(jsonDecode(jsonMap) as Map<String, dynamic>) ??
      unknownTickIcon;
}

String _serializeIcon(IconPickerIcon icon) {
  return jsonEncode(serializeIcon(icon));
}

@drift.UseRowClass(TickCategoryModel, constructor: 'fromRow')
class TickCategories extends drift.Table {
  drift.IntColumn get id => integer().autoIncrement()();
  drift.TextColumn get name => text().unique()();
  drift.TextColumn get icon => text()();
  drift.TextColumn get color => text()();
}
