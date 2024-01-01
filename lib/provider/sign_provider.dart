// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:asl/data/sign_list.dart';
import 'package:asl/models/models.dart';

import '../utils/utils.dart';

part 'sign_provider.g.dart';

@riverpod
class SignProvider extends _$SignProvider {
  @override
  SignState build() {
    return SignState(
      listSigns: [],
      currentSign: null,
      currentMessage: '',
      timer: null,
    );
  }

  void generateListToMessage(String inputString) {
    state =
        state.copyWith(listSigns: [], currentSign: null, currentMessage: '');

    state = state.copyWith(
      listSigns: generateListToMessageUtil(listOnlySingAndNumbers, inputString),
      currentMessage: inputString,
    );
  }

  setCurrentMessage(String message) {
    state = state.copyWith(currentMessage: message);
  }

  setCurrentSign(Sign sign) {
    state = state.copyWith(currentSign: sign);
  }
}

/* @riverpod
class CurrentMessage extends _$CurrentMessage {
  @override
  String build() {
    return '';
  }

  setCurrentMessage(String message) {
    state = message;
  }
}

@riverpod
class CurrentSign extends _$CurrentSign {
  @override
  Sign? build() {
    return null;
  }
}
 */
class SignState {
  List<Sign> listSigns = [];
  Sign? currentSign;
  String currentMessage = '';
  Timer? timer;
  SignState({
    required this.listSigns,
    required this.currentSign,
    required this.currentMessage,
    required this.timer,
  });

  SignState copyWith({
    List<Sign>? listSigns,
    Sign? currentSign,
    String? currentMessage,
    Timer? timer,
  }) {
    return SignState(
      listSigns: listSigns ?? this.listSigns,
      currentSign: currentSign ?? this.currentSign,
      currentMessage: currentMessage ?? this.currentMessage,
      timer: timer ?? this.timer,
    );
  }
}
