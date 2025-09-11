// ignore_for_file: invalid_annotation_target

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
  const factory TickCategoryModel({
    int? id,
    required String name,
    @JsonKey(
      fromJson: _deserializeIcon,
      toJson: serializeIcon,
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
}

IconPickerIcon _deserializeIcon(Map<String, dynamic> map) {
  return deserializeIcon(map) ?? unknownTickIcon;
}
