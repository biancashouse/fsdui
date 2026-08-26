import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/snodes/hotspots/widgets/hotspot_target_config_toolbar/hotspot_target_config_toolbar.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'web_util_stub.dart' if (dart.library.html) 'web_util_web.dart';

mixin NavMixin {
  // final GlobalKey _userIconGK = GlobalKey();

  /// Triggers a hard refresh of the current web page using the 'web' package.
  ///
  /// This is equivalent to the user pressing F5 or the browser's refresh button.
  /// This will only work on Flutter web. It has no effect on mobile or desktop.
  void refreshCurrentPage() {
    // kIsWeb is a compile-time constant that ensures this code
    // is only included in the web build.
    if (kIsWeb) {
      reloadPage();
    } else {
      fsdui.logger.w(
        'refreshCurrentPage() was called on a non-web platform and will have no effect.',
      );
    }
  }

  Widget NavigationDD({
    Color pencilIconColor = Colors.white,
    String? appVersion,
    GlobalKey? gk,
  }) => BlocBuilder<CAPIBloC, CAPIState>(
    builder: (context, state) {
      bool showPencil = !(state.verified ?? false);
      return showPencil
          ? _dropdownButtonNotSignedIn(
              gk,
              context,
              state,
              pencilIconColor,
              appVersion,
            )
          : _dropdownButtonSignedIn(context, state, appVersion);
    },
  );

  Widget _dropdownButtonNotSignedIn(
    GlobalKey? gk,
    BuildContext context,
    CAPIState state,
    Color pencilIconColor,
    String? appVersion,
  ) {
    List<PopupMenuEntry<String>> dropdownItems = [
      _dropdownItemWithPI(
        value: 'sign-in',
        child: MenuItemButton(
          onPressed: () {
            String? gcrServerUrl = fsdui.gcrServerUrl;
            if (gcrServerUrl != null) {
              fsdui.showPasswordlessSignIn(
                // onSignedInF: (vea) {
                //   fsdui.capiBloc.add(TokenConfirmed(ea: vea, token: ));
                //   fsdui.dismissAll();
                // },
              );
            }
            Navigator.pop(context);
          },
          // leadingIcon: Icon(
          //   Icons.verified_user,
          //   key: _userIconGK,
          //   size: 26,
          //   color: Colors.green,
          // ),
          child: Text('sign in'),
        ),
      ),

      _aboutUsItem(context, state),

      if (fsdui.canEditAnyContent() && fsdui.router != null)
        _dropdownItemWithPI(
          value: 'create-editable-page',
          child: RichText(
            text: TextSpan(
              text: 'create your own ',
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                  text: 'editable',
                  style: TextStyle(color: Colors.purpleAccent),
                ),
                TextSpan(text: ' page'),
              ],
            ),
          ),
        ),
    ];

    _addBrightnessItem(context, state, dropdownItems);
    _addVersionItem(appVersion, dropdownItems);

    return PointerInterceptor(
      child: Theme(
        data: Theme.of(context).copyWith(hoverColor: Colors.transparent),
        child: PopupMenuButton<String>(
          // key: fco.authIconGK,
          itemBuilder: (context) => dropdownItems,
          icon: PointerInterceptor(
            child: Icon(key: gk, Icons.edit, color: pencilIconColor, size: 24),
          ),
          color: Colors.white,
          onSelected: (value) {
            if (fsdui.router != null) {
              EditablePage.of(context)?.showPageNameDialog();
            }
          },
        ),
      ),
    );
  }

  Widget _dropdownButtonSignedIn(
    BuildContext context,
    CAPIState state,
    String? appVersion,
  ) {
    List<PopupMenuEntry<String>> dropdownItems = [
      // signed in as super, article or guest editor
      // if (!(state.isSignedInAsNormalUser ?? false))
      _dropdownItemWithPI(value: 'sign-out', child: _signOutBtn(context)),
      _aboutUsItem(context, state),

      if (fsdui.canEditAnyContent() && fsdui.router != null)
        _dropdownItemWithPI(
          value: 'create-editable-page',
          child: RichText(
            text: TextSpan(
              text: 'create an ',
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                  text: 'editable',
                  style: TextStyle(color: Colors.purpleAccent),
                ),
                TextSpan(text: ' page'),
              ],
            ),
          ),
        ),
    ];

    if (!fsdui.isGuestEditor() && !state.isSignedInAsNormalUser()) {
      for (String pagePath in fsdui.pageList) {
        // skip currentPath
        try {
          final String currentPath = GoRouterState.of(context).uri.toString();
          if (pagePath != currentPath) {
            String sandboxIndicator =
                (fsdui.appInfo.anonymousUserEditablePages.contains(pagePath))
                ? ' *'
                : "";
            dropdownItems.add(
              _dropdownItemWithPI(
                value: pagePath,
                child: _pageNavBtn(context, pagePath, sandboxIndicator),
              ),
            );
          }
        } catch (e) {
          print(e);
        }
      }
    }

    _addBrightnessItem(context, state, dropdownItems);
    _addVersionItem(appVersion, dropdownItems);

    return PointerInterceptor(
      child: Theme(
        data: Theme.of(context).copyWith(hoverColor: Colors.transparent),
        child: PopupMenuButton<String>(
          itemBuilder: (context) => dropdownItems,
          icon: PointerInterceptor(
            child: (state.verified ?? false) && !state.isSignedInAsNormalUser()
                ? Icon(
                    Icons.more_vert,
                    color: fsdui.canEditAnyContent()
                        ? Colors.red
                        : Colors.purpleAccent,
                    size: 24,
                  )
                : Tooltip(
                    message: 'signed in as ${state.ea}',
                    child: Icon(
                      Icons.verified_user,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
          ),
          color: Colors.white,
          onSelected: (value) {
            if (fsdui.router != null) {
              switch (value) {
                case 'create-editable-page':
                  EditablePage.of(context)?.showPageNameDialog();
                  break;
                default:
                  break;
              }
            }
          },
        ),
      ),
    );
  }

  PopupMenuItem<String> _aboutUsItem(BuildContext context, CAPIState state) =>
      _dropdownItemWithPI(
        value: 'about-us',
        child: MenuItemButton(
          onPressed: () {
            Navigator.pop(context);
            // context.go('/about-us');
            if (state.isNotSignedIn()) {
              fsdui.aboutUsNotSignedInF?.call();
            } else {
              fsdui.aboutUsSignedInF?.call();
            }
          },
          child: Text('about us'),
        ),
      );

  void _addBrightnessItem(
    BuildContext context,
    CAPIState state,
    dropdownItems,
  ) {
    String buttonText;
    ThemeMode nextMode;
    IconData buttonIcon;

    switch (ThemeMode.values[state.themeModeIndex ?? 1]) {
      case ThemeMode.light:
        buttonText = 'Switch to Dark Mode';
        nextMode = ThemeMode.dark;
        buttonIcon = Icons.brightness_3; // Moon icon
        break;
      case ThemeMode.dark:
        buttonText = 'Switch to System Theme';
        nextMode = ThemeMode.system;
        buttonIcon = Icons.brightness_auto; // Auto icon
        break;
      // case ThemeMode.system:
      default: // Treat system as default, cycle to light
        buttonText = 'Switch to Light Mode';
        nextMode = ThemeMode.light;
        buttonIcon = Icons.brightness_7; // Sun icon
        break;
    }

    dropdownItems.add(
      _dropdownItemWithPI(
        value: 'brightness',
        child: MenuItemButton(
          onPressed: () {
            fsdui.capiBloc.add(SetThemeMode(themeMode: nextMode));
            Navigator.pop(context);
          },
          leadingIcon: Icon(buttonIcon),
          child: Text(buttonText),
        ),
      ),
    );
  }

  Widget _signOutBtn(context) => TextButton(
    onPressed: () {
      if (!fsdui.anyPresent([HotspotTargetConfigToolbar.CID])) {
        fsdui.capiBloc.add(SignOutRequested());
        Navigator.pop(context);
      }
    },
    child: fsdui.coloredText('Sign Out', color: Colors.red),
  );

  Widget _pageNavBtn(
    BuildContext context,
    String pagePath,
    String sandboxIndicator,
  ) => GestureDetector(
    onTap: () {
      Navigator.pop(context);
      context.go(pagePath);
      // something funny going on when not in prod mode
      // if (false && kDebugMode) {
      //   fsdui.afterMsDelayDo(1000, () {
      //     fsdui.refreshCurrentPage();
      //   });
      // }
    },
    child: SizedBox(
      width: 400,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'goto ',
                style: TextStyle(color: Colors.grey),
                children: <TextSpan>[
                  TextSpan(
                    text: '$pagePath$sandboxIndicator',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // if (pagePath != '/') Spacer(),
          if (pagePath != '/')
            IconButton(
              onPressed: () async {
                fsdui.appInfo.snippetNames.remove(pagePath);
                // because dart_mappable creates jsarrays
                var potentiallyUnmodifiablePages =
                    fsdui.appInfo.anonymousUserEditablePages;
                List<String> modifiablePages = List.from(
                  potentiallyUnmodifiablePages,
                );
                modifiablePages.remove(pagePath);
                fsdui.appInfo = fsdui.appInfo.copyWith(
                  anonymousUserEditablePages: modifiablePages,
                );
                fsdui.deleteSubRoute(path: pagePath);
                context.pop();
                await fsdui.modelRepo.saveAppInfo();
                await fsdui.modelRepo.deleteSnippet(pagePath);
                fsdui.appInfo.removeFromCache(pagePath);
                fsdui.capiBloc.add(ForceRefresh());
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
        ],
      ),
    ),
  );

  void _addVersionItem(String? appVersion, List<PopupMenuEntry<String>> items) {
    if (appVersion == null || appVersion.isEmpty) return;
    items.add(
      _dropdownItemWithPI(
        value: 'version',
        child: Text(
          'v$appVersion',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }

  PopupMenuItem<String> _dropdownItemWithPI({
    required String value,
    required Widget child,
  }) => PopupMenuItem<String>(
    value: value,
    child: PointerInterceptor(child: child),
  );

  // Widget _pageNavBtnOLD(context, String pagePath) => Row(
  //   mainAxisSize: MainAxisSize.max,
  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   children: [
  //     TextButton(
  //       onPressed: () {
  //         context.replace(pagePath);
  //       },
  //       child: Text(pagePath),
  //     ),
  //     if (pagePath != '/')
  //       IconButton(
  //         onPressed: () async {
  //           fco.appInfo.snippetNames.remove(pagePath);
  //           fco.deleteSubRoute(path: pagePath);
  //           await fco.modelRepo.saveAppInfo();
  //           await fco.modelRepo.deleteSnippet(pagePath);
  //           SnippetInfoModel.removeFromCache(pagePath);
  //         },
  //         icon: Icon(Icons.delete, color: Colors.red),
  //       ),
  //   ],
  // );
}
