import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/active_timer.freezed.dart';
part 'generated/active_timer.g.dart';

@freezed
abstract class ActiveTimerModel with _$ActiveTimerModel {
  const factory ActiveTimerModel({
    required String categoryId,
    required DateTime start,
  }) = _ActiveTimerModel;

  //For JSON serialization / deserialization
  factory ActiveTimerModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveTimerModelFromJson(json);
}
