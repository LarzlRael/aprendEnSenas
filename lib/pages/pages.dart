import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:animate_do/animate_do.dart';

import 'package:asl/constants/constant.dart';
import 'package:asl/constants/key_value_names.dart';
import 'package:asl/customs_icons/custom_icons.dart';
import 'package:asl/customs_icons/sign_icons.dart';

import 'package:asl/data/games_data.dart';
import 'package:asl/data/sign_list.dart';
import 'package:asl/models/models.dart';
import 'package:asl/provider/ads_providers.dart';

import 'package:asl/provider/providers.dart';
import 'package:asl/provider/settings_provider.dart';
import 'package:asl/services/services.dart';
import 'package:asl/utils/utils.dart';
import 'package:asl/widgets/widgets.dart';
import 'package:collection/collection.dart';
import 'package:confetti/confetti.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pausable_timer/pausable_timer.dart';

part 'home_page.dart';

part 'letters_numbers/letter_and_numbers_page.dart';
part 'letters_numbers/letter_and_numbers_page_detail.dart';
part 'settings_page.dart';
part 'send_message_with_sign_page.dart';

part 'games/select_game_menu_page.dart';
part 'games/select_level_page.dart';
part 'games/test_your_memory_page.dart';
part 'games/word_in_sight_page.dart';
part 'games/guess_the_word_page.dart';
part 'games/test_flipping_cards_page.dart';
part 'games/match_image_game.dart';
part 'games/keyboard_sign_page.dart';
part 'games/flipping_card_game.dart';
part 'games/guess_the_word_keyboard.dart';
part 'games/game_over_screen.dart';

part 'welcome/welcome_page.dart';
part 'welcome/splash_screen_page.dart';

part 'test/test_page.dart';
part 'keyboard/keyboard_letters_page.dart';
