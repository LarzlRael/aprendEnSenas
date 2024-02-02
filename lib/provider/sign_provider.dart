import 'dart:async';

import 'package:asl/data/sign_list.dart';
import 'package:asl/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/utils.dart';

final signListProvider = [
  signStyle1,
  signStyle2,
  signStyle3,
];
final signProvider = StateNotifierProvider<SignNotifier, SignState>((ref) {
  return SignNotifier();
});

class SignNotifier extends StateNotifier<SignState> {
  SignNotifier()
      : super(
          SignState(
            listSignsToMessage: [],
            currentSign: null,
            currentMessage: '',
            timer: null,
            currentListIndex: 0,
            currentListSing: signListProvider[0],
          ),
        );

  @override
  SignState build() {
    return SignState(
      listSignsToMessage: [],
      currentSign: null,
      currentMessage: '',
      timer: null,
      currentListIndex: 0,
      currentListSing: signListProvider[0],
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

  void changeListSignIndex(int index) {
    state = state.copyWith(
      currentListIndex: index,
      currentListSing: signListProvider[index],
    );
  }
}

class SignState {
  List<Sign> listSignsToMessage = [];
  Sign? currentSign;
  String currentMessage = '';
  Timer? timer;
  List<Sign> currentListSing = [];
  int currentListIndex = 0;
  SignState({
    required this.listSignsToMessage,
    required this.currentSign,
    required this.currentMessage,
    required this.timer,
    required this.currentListSing,
    required this.currentListIndex,
  });

  SignState copyWith({
    List<Sign>? listSigns,
    Sign? currentSign,
    String? currentMessage,
    Timer? timer,
    List<Sign>? currentListSing,
    int? currentListIndex,
  }) {
    return SignState(
      listSignsToMessage: listSigns ?? this.listSignsToMessage,
      currentSign: currentSign ?? this.currentSign,
      currentMessage: currentMessage ?? this.currentMessage,
      timer: timer ?? this.timer,
      currentListSing: currentListSing ?? this.currentListSing,
      currentListIndex: currentListIndex ?? this.currentListIndex,
    );
  }
}
