// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart' show MapperContainer;
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsdui/fsdui.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../../mappers/color_mapper.dart';
import '../../mappers/size_mapper.dart';
import '../../mappers/edge_insets_mapper.dart';
import 'url_strategy_stub.dart' if (dart.library.html) 'url_strategy_web.dart';

// conditional import for webview ------------------
import 'register_ios_or_android_webview.dart'
    if (dart.library.html) 'register_web_webview.dart';

/// this widget must enclose your MaterialApp, or CupertinoApp or WidgetsApp
/// so that the CAPIBloc becomes available to overlays, which are placed into
/// the app's overlay and not in your widget tree as you might have expected.
class FlutterContentApp extends StatefulWidget {
  final String appId;
  final String appName;
  final String title;

  // final SnippetName pageSnippetName;
  final MaterialAppThemeFunc materialAppThemeF;
  final FirebaseOptions? fbOptions;
  final bool useEmulator;
  final Map<String, void Function(BuildContext)>? namedVoidCallbacks;
  final bool hideStatusBar;
  final VoidCallback? onReadyF;
  final VoidCallback? alsoInitF;

  final RoutingConfig? routingConfig;
  final String? initialRoutePath;

  final VoidCallback? aboutUsNotSignedInF;
  final VoidCallback? aboutUsSignedInF;
  final VoidCallback? signedInWelcomeF;

  final Widget? home;

  // // --- globally available -----------------------------------------------------
  // static CAPIBloC? _singletonBloc;
  //
  // static CAPIBloC? get capiBloc {
  //   assert(
  //     _singletonBloc != null,
  //     "FlutterContentApp's CAPIBloc has not been initialized. Ensure FlutterContentApp is at the root of your widget tree and has completed its setup.",
  //   );
  //   return _singletonBloc!;
  // }

  // --- globally available -----------------------------------------------------

  // final IModelRepository? testModelRepo; // created in tests by a when(mockRepository.getCAPIModel(appName: appName...
  // final Widget? testWidget;

  // final bool localTestingFilePaths;

  const FlutterContentApp.router({
    super.key,
    required this.appId,
    required this.appName,
    this.title = '',
    required this.routingConfig,
    required this.initialRoutePath,
    this.home,
    required this.materialAppThemeF,
    this.fbOptions,
    this.useEmulator = false,
    this.hideStatusBar = true,
    // @visibleForTesting this.testModelRepo,
    // @visibleForTesting this.testWidget,
    this.onReadyF,
    this.alsoInitF,
    this.namedVoidCallbacks,
    this.aboutUsNotSignedInF,
    this.aboutUsSignedInF,
    this.signedInWelcomeF,
  });

  const FlutterContentApp({
    super.key,
    required this.appId,
    required this.appName,
    this.title = '',
    this.routingConfig,
    this.initialRoutePath,
    required this.home,
    required this.materialAppThemeF,
    this.fbOptions,
    this.useEmulator = false,
    this.hideStatusBar = true,
    // @visibleForTesting this.testModelRepo,
    // @visibleForTesting this.testWidget,
    this.onReadyF,
    this.alsoInitF,
    this.namedVoidCallbacks,
    this.aboutUsNotSignedInF,
    this.aboutUsSignedInF,
    this.signedInWelcomeF,
  });

  static FlutterContentAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<FlutterContentAppState>();

  // static bool escKeyPressedZFor3Secs = false;

  @override
  State<FlutterContentApp> createState() => FlutterContentAppState();
}

// Ticker available for use by Callouts; i.e. vsync: MaterialAppWrapper.of(context)
class FlutterContentAppState extends State<FlutterContentApp>
    with TickerProviderStateMixin {
  late Future<CAPIBloC?> fInitApp;
  int tapCount = 0;
  DateTime? lastTapTime;

  // YoutubePlayerController? ytController;

  @override
  void initState() {
    super.initState();

    // if (kReleaseMode) {
    //   // don't log anything below warning in production
    //   Logger.root.level = Level.WARNING;
    // }
    // Logger.root.onRecord.listen((record) {
    //   fco.logger.d('${record.level.name}: ${record.time}'
    //       '${record.loggerName}: ${record.message}');
    // });

    BrowserContextMenu.disableContextMenu();

    // Use PathUrlStrategy for removing # from URLs.
    setUrlStrategy(PathUrlStrategy());

    if (widget.hideStatusBar) {
      // fco.logger.i('hiding status bar');
      // https://medium.com/@mustafatahirhussein/these-quick-tips-will-surely-help-you-to-build-a-better-flutter-app-6db93c1095b6
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      );
    } else {
      fsdui.logger.i('going full screen');
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }

    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }

    // see conditional imports for web or mobile
    registerWebViewImplementation();

    // dart_mappable globals: color etc gets saved as hex in json
    MapperContainer.globals.use(ColorMapper());
    MapperContainer.globals.use(SizeMapper());
    MapperContainer.globals.use(EdgeInsetsMapper());

    fInitApp = _initApp();
  }

  @override
  void dispose() {
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
    super.dispose();
  }

  // init FlutterContent, which keeps a single CAPIBloC and multiple SnippetBloCs
  Future<CAPIBloC?> _initApp() async {
    fsdui.capiBloc = await fsdui.createCAPIBloC(
      appId: widget.appId,
      appName: widget.appName,
      fbOptions: widget.fbOptions,
      useEmulator: widget.useEmulator,
      routingConfig: widget.routingConfig,
      initialRoutePath: widget.initialRoutePath,
      aboutUsNotSignedInF: widget.aboutUsNotSignedInF,
      aboutUsSignedInF: widget.aboutUsSignedInF,
      signedInWelcomeF: widget.signedInWelcomeF,
    );
    widget.onReadyF?.call();
    SNode.hideAllTargetCovers();
    widget.alsoInitF?.call();
    return fsdui.capiBloc;
  }

  // ytController = YoutubePlayerController.fromVideoId(
  //   videoId: 'zWh3CShX_do',
  //   autoPlay: false,
  //   params: const YoutubePlayerParams(showFullscreenButton: true),
  // );

  @override
  Widget build(context) {
    return FutureBuilder<CAPIBloC?>(
      future: fInitApp,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return BlocProvider<CAPIBloC>(
            create: (BuildContext context) => snapshot.data!,
            child: BlocBuilder<CAPIBloC, CAPIState>(
              buildWhen: (prev, curr) =>
                  prev.themeModeIndex != curr.themeModeIndex,
              builder: (context, state) {
                ThemeMode themeMode =
                    ThemeMode.values[state.themeModeIndex ?? 1];
                return widget.routingConfig != null
                    ? MaterialApp.router(
                        // following line not valid for router;
                        // instead pass navigatorKey: fco.globalNavigatorKey
                        // to GoRouter.routingConfig()
                        routerConfig: fsdui.router,
                        localizationsDelegates: const [
                          GlobalMaterialLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          FlutterQuillLocalizations.delegate,
                        ],
                        themeMode: themeMode,
                        theme: widget.materialAppThemeF(),
                        darkTheme: ThemeData(
                          brightness: Brightness.light,
                          primarySwatch: Colors.purple,
                          // ... other dark theme properties
                          scaffoldBackgroundColor: Colors.black54,
                          // Example
                          textTheme: TextTheme(
                            bodyMedium: TextStyle(color: Colors.black87),
                          ),
                          appBarTheme: AppBarTheme(
                            backgroundColor: Colors.grey[850],
                          ),
                        ),
                        debugShowCheckedModeBanner: false,
                        title: widget.title,
                        scrollBehavior: const ConstantScrollBehavior(),
                      )
                    : MaterialApp(
                        navigatorKey: fsdui.globalNavigatorKey,
                        home: widget.home,
                        localizationsDelegates: const [
                          GlobalMaterialLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          FlutterQuillLocalizations.delegate,
                        ],
                        themeMode: themeMode,
                        theme: widget.materialAppThemeF(),
                        darkTheme: ThemeData(
                          brightness: Brightness.light,
                          primarySwatch: Colors.purple,
                          // ... other dark theme properties
                          scaffoldBackgroundColor: Colors.black54,
                          // Example
                          textTheme: TextTheme(
                            bodyMedium: TextStyle(color: Colors.black87),
                          ),
                          appBarTheme: AppBarTheme(
                            backgroundColor: Colors.grey[850],
                          ),
                        ),
                        debugShowCheckedModeBanner: false,
                        title: widget.title,
                        scrollBehavior: const ConstantScrollBehavior(),
                      );
              },
            ),
            // child: ValueListenableBuilder<ThemeMode>(
            //   valueListenable: fsdui.themeModeNotifier,
            //   builder: (context, currentMode, child) {
            //     return BlocBuilder<AuthBloc, AuthState>(
            //       buildWhen: (prev, curr) =>
            //       prev.user.status != curr.user.status,
            //       builder: (context, state) {
            //         return AnimatedSwitcher(
            //           duration: const Duration(milliseconds: 300),
            //           child: switch (state.user.status) {
            //             AuthStatus.authenticated => _signedInPage(currentMode),
            //             _ => MaterialApp(
            //               title: 'Sign In',
            //               debugShowCheckedModeBanner: false,
            //               theme: ThemeData(
            //                 colorSchemeSeed: Colors.indigo,
            //                 useMaterial3: true,
            //               ),
            //               home: LoginScreenPasswordless(appId: widget.appId, appName: widget.appName),
            //             ),
            //           },
            //         );
            //       },
            //     );
            //   },
            // ),
          );
        } else {
          return const Offstage();
        }
        // TESTING ONLY
      },
    );
  }

  // Widget _signedInPage(ThemeMode currentMode) {
  //   return widget.routingConfig != null
  //       ? MaterialApp.router(
  //           // following line not valid for router;
  //           // instead pass navigatorKey: fco.globalNavigatorKey
  //           // to GoRouter.routingConfig()
  //           routerConfig: fsdui.router,
  //           localizationsDelegates: const [
  //             GlobalMaterialLocalizations.delegate,
  //             GlobalCupertinoLocalizations.delegate,
  //             GlobalWidgetsLocalizations.delegate,
  //             FlutterQuillLocalizations.delegate,
  //           ],
  //           // theme: ThemeData.light(useMaterial3: true),
  //           // darkTheme: ThemeData.dark(useMaterial3: true),
  //           // themeMode: ThemeMode.system,
  //           themeMode: currentMode,
  //           theme: widget.materialAppThemeF(),
  //           darkTheme: ThemeData(
  //             brightness: Brightness.light,
  //             primarySwatch: Colors.purple,
  //             // ... other dark theme properties
  //             scaffoldBackgroundColor: Colors.black54,
  //             // Example
  //             textTheme: TextTheme(
  //               bodyMedium: TextStyle(color: Colors.black87),
  //             ),
  //             appBarTheme: AppBarTheme(backgroundColor: Colors.grey[850]),
  //           ),
  //           debugShowCheckedModeBanner: false,
  //           title: widget.title,
  //           scrollBehavior: const ConstantScrollBehavior(),
  //         )
  //       : MaterialApp(
  //           navigatorKey: fsdui.globalNavigatorKey,
  //           home: widget.home,
  //           localizationsDelegates: const [
  //             GlobalMaterialLocalizations.delegate,
  //             GlobalCupertinoLocalizations.delegate,
  //             GlobalWidgetsLocalizations.delegate,
  //             FlutterQuillLocalizations.delegate,
  //           ],
  //           themeMode: currentMode,
  //           theme: widget.materialAppThemeF(),
  //           darkTheme: ThemeData(
  //             brightness: Brightness.light,
  //             primarySwatch: Colors.purple,
  //             // ... other dark theme properties
  //             scaffoldBackgroundColor: Colors.black54,
  //             // Example
  //             textTheme: TextTheme(
  //               bodyMedium: TextStyle(color: Colors.black87),
  //             ),
  //             appBarTheme: AppBarTheme(backgroundColor: Colors.grey[850]),
  //           ),
  //           debugShowCheckedModeBanner: false,
  //           title: widget.title,
  //           scrollBehavior: const ConstantScrollBehavior(),
  //         );
  // }
}
