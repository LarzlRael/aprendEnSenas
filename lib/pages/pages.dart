import 'dart:developer';

import 'package:asl/data/games_data.dart';
import 'package:asl/data/sign_list.dart';
import 'package:asl/models/models.dart';
import 'package:asl/provider/providers.dart';
import 'package:asl/utils/utils.dart';
import 'package:asl/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
part 'home_page.dart';

part 'letter_and_numbers_page.dart';
part 'letter_and_numbers_page_detail.dart';
part 'send_message_with_sign_page.dart';
part 'games/select_game_menu_page.dart';
part 'games/select_difficulty_page.dart';
part 'games/test_your_memory_page.dart';
part 'games/word_in_sight_page.dart';
