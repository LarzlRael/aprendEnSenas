import 'package:asl/models/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:asl/pages/pages.dart';

final appRouter = GoRouter(
  initialLocation: '/splash_screen_page',
  /* refreshListenable: goRouterNotifier, */
  routes: [
    ///* Primera pantalla
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/splash_screen_page',
      builder: (context, state) => SplashScreenPage(),
    ),
    GoRoute(
      path: '/welcome_page',
      builder: (context, state) => WelcomePage(),
    ),
    GoRoute(
        path: LetterAndNumbersPage.routeName,
        builder: (context, state) => LetterAndNumbersPage(),
        routes: [
          GoRoute(
              path: ':letter',
              builder: (context, state) {
                final letter = state.params['letter'];
                return LetterAndNumbersPageDetail(signChar: letter!);
              }),
        ]),

    GoRoute(
        path: SendMessageWithSignPage.routeName,
        builder: (_, __) => const SendMessageWithSignPage(),
        routes: [
          GoRoute(
            path: ':phrase',
            builder: (_, state) {
              final phrase = state.params['phrase'];
              return SendMessageWithSignPage(
                phrase: phrase,
              );
            },
          ),
        ]),
    GoRoute(
        path: '/select_game_menu_page',
        builder: (_, __) => SelectGameMenuPage()),
    GoRoute(
        path: '/select_level_page/:gameTitle/:gameDestinty',
        builder: (_, state) {
          final gameTitle = state.params['gameTitle'];
          final gameDestinty = state.params['gameDestinty'];
          final iconGame = state.extra as IconData;
          return SelectLevelPage(
            gameTitle: gameTitle!,
            gameRouteDestinyPage: gameDestinty,
            iconGame: iconGame,
          );
        }),
    GoRoute(
      path: '/settings_page',
      builder: (_, __) => const SettingsPage(),
    ),

    GoRoute(
      path: '/games',
      builder: (_, __) => const SelectGameMenuPage(),
      routes: [
        GoRoute(
          path: 'test_your_memory_page',
          builder: (_, state) {
            final level = state.extra as Level;
            return TestYourMemoryPage(
              level: level,
            );
          },
        ),
        GoRoute(
          path: 'word_in_sight_page',
          builder: (_, __) => const WordInSightPage(),
        ),
        GoRoute(
          path: 'guess_the_word_page',
          builder: (_, __) => const GuessTheWordPage(),
        ),
        GoRoute(
          path: 'flipping_cards_page',
          builder: (_, state) {
            final level = state.extra as Level;
            return FlippingCardGame(
              level: level,
            );
          },
        ),
        GoRoute(
          path: 'drag_and_drop_game',
          builder: (_, state) => MatchImageGame(),
        ),
      ],
    ),
  ],
);
