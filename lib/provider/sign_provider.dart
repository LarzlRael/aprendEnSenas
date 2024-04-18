import 'dart:async';

import 'package:asl/constants/key_value_names.dart';
import 'package:asl/data/sign_list.dart';
import 'package:asl/models/models.dart';
import 'package:asl/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/utils.dart';

final signListProvider = [
  signStyle1,
  signStyle2,
  signStyle3,
  signStyle4,
];
final signProvider = StateNotifierProvider<SignNotifier, SignState>((ref) {
  return SignNotifier();
});

class SignNotifier extends StateNotifier<SignState> {
  final keyValueStorageService = KeyValueStorageServiceImpl();
  static final List<List<Sign>> signListProvider = [
    signStyle1,
    signStyle2,
    signStyle3,
    signStyle4,
  ];
  @override
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
        ) {
    asyncInit();
  }

  void asyncInit() async {
    final currentListIndex =
        await keyValueStorageService.getValue<int>(CURRENT_LIST_INDEX);

    state = state.copyWith(
      currentListIndex: currentListIndex ?? state.currentListIndex,
      currentListSing:
          signListProvider[currentListIndex ?? state.currentListIndex],
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

  void changeListSignIndex(int index) async {
    state = state.copyWith(
      currentListIndex: index,
      currentListSing: signListProvider[index],
    );
    await keyValueStorageService.setKeyValue<int>(CURRENT_LIST_INDEX, index);
  }

  void setListSignsToMessage(List<Sign> listSigns) {
    state = state.copyWith(listSigns: listSigns);
  }

  void setTimer(Timer timer) {
    state = state.copyWith(timer: timer);
  }
}

class SignState {
  final List<Sign> listSignsToMessage;
  final Sign? currentSign;
  final String currentMessage;
  final Timer? timer;
  final List<Sign> currentListSing;
  final int currentListIndex;
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
