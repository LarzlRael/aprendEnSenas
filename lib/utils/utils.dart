import 'dart:io';
import 'dart:math';

import 'package:asl/constants/enviroments.dart';
import 'package:asl/data/sign_list.dart';
import 'package:asl/models/models.dart';
import 'package:asl/services/services.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diacritic/diacritic.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'text_utils.dart';
part 'games_utils.dart';
part 'send_message_utils.dart';
part 'gammes_classes.dart';
part 'flipping_cards_utils.dart';
part 'shared_preferences_utils.dart';
part 'drag_and_drop_game_utils.dart';
part 'sounds_and_image_utils.dart';
part 'firebase_utils.dart';
part 'arrays_utils.dart';
part 'system_utils.dart';
