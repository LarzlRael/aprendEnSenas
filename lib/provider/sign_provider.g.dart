// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signProviderHash() => r'd60bca49490cc9f271bb88b740a31c9f21b3d373';

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
