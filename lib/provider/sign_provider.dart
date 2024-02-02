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
      listSignsToMessage: [],
      currentSign: null,
      currentMessage: '',
      timer: null,
      currentListSing: signStyle1,
    );
  }

  String replaceSpaceByPlus() {
    return state.currentMessage.replaceAll(' ', '%20');
  }

  void generateListToMessage(String inputString) {
    state =
        state.copyWith(listSigns: [], currentSign: null, currentMessage: '');

    state = state.copyWith(
      listSigns: generateListToMessageUtil(signStyle1, inputString),
      currentMessage: inputString,
    );
  }

  void setCurrentMessage(String message) {
    state = state.copyWith(currentMessage: message);
  }

  void setCurrentSign(Sign sign) {
    state = state.copyWith(currentSign: sign);
  }
}

class SignState {
  List<Sign> listSignsToMessage = [];
  Sign? currentSign;
  String currentMessage = '';
  Timer? timer;
  List<Sign> currentListSing = [];
  SignState({
    required this.listSignsToMessage,
    required this.currentSign,
    required this.currentMessage,
    required this.timer,
    required this.currentListSing,
  });

  SignState copyWith({
    List<Sign>? listSigns,
    Sign? currentSign,
    String? currentMessage,
    Timer? timer,
    List<Sign>? currentListSing,
  }) {
    return SignState(
      listSignsToMessage: listSigns ?? this.listSignsToMessage,
      currentSign: currentSign ?? this.currentSign,
      currentMessage: currentMessage ?? this.currentMessage,
      timer: timer ?? this.timer,
      currentListSing: currentListSing ?? this.currentListSing,
    );
  }
}
