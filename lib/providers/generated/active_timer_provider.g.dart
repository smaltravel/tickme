// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../active_timer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$elapsedTimeHash() => r'6340ca64908bc1d437e9e383919fc7acc53720f8';

/// See also [elapsedTime].
@ProviderFor(elapsedTime)
final elapsedTimeProvider = AutoDisposeStreamProvider<Duration>.internal(
  elapsedTime,
  name: r'elapsedTimeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$elapsedTimeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ElapsedTimeRef = AutoDisposeStreamProviderRef<Duration>;
String _$activeTickHash() => r'276ffefbec0c6c90a67ea14d4b2261c1f53bab09';

/// See also [ActiveTick].
@ProviderFor(ActiveTick)
final activeTickProvider =
    NotifierProvider<ActiveTick, ActiveTimerModel?>.internal(
  ActiveTick.new,
  name: r'activeTickProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$activeTickHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ActiveTick = Notifier<ActiveTimerModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
