// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signProviderHash() => r'729f1b9cd7639ef3e18292a335edae4fd8562805';

/// See also [SignProvider].
@ProviderFor(SignProvider)
final signProviderProvider =
    AutoDisposeNotifierProvider<SignProvider, List<Sign>>.internal(
  SignProvider.new,
  name: r'signProviderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SignProvider = AutoDisposeNotifier<List<Sign>>;
String _$currentMessageHash() => r'0a7e030d57b32e9e9bf89439daad41a9ef10b578';

/// See also [CurrentMessage].
@ProviderFor(CurrentMessage)
final currentMessageProvider =
    AutoDisposeNotifierProvider<CurrentMessage, String>.internal(
  CurrentMessage.new,
  name: r'currentMessageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentMessageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentMessage = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
