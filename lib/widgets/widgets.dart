import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:asl/data/sign_list.dart';
import 'package:asl/models/models.dart';
import 'package:asl/provider/ads_providers.dart';
import 'package:asl/provider/settings_provider.dart';
import 'package:asl/provider/sign_provider.dart';
import 'package:asl/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

part 'simple_text.dart';
part './cards/image_gallery.dart';
part './cards/image_switcher.dart';

part '/games/select_game_card.dart';
part '/games/page_view_sign_slider.dart';
part '/games/progres_linear_timer.dart';
part '/navigation/back_icon.dart';
part '/buttons/animated_play_button.dart';
part '/buttons/speech_button.dart';
part '/animation/scale_animation.dart';
part '/animation/shakingY_animation.dart';
part '/icons/colored_icon.dart';
part '/forms/send_message_input.dart';
part 'ads/banner_ad.dart';
