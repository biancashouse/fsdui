import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/snodes/hotspots/widgets/hotspot_target_config_toolbar/hotspot_target_config_toolbar.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:web/web.dart' as web;

mixin NavMixin {
  /// Triggers a hard refresh of the current web page using the 'web' package.
  ///
  /// This is equivalent to the user pressing F5 or the browser's refresh button.
  /// This will only work on Flutter web. It has no effect on mobile or desktop.
  void refreshCurrentPage() {
    // kIsWeb is a compile-time constant that ensures this code
    // is only included in the web build.
    if (kIsWeb) {
      web.window.location.reload();
    } else {
      fsdui.logger.w(
        'refreshCurrentPage() was called on a non-web platform and will have no effect.',
      );
    }
  }

  Widget NavigationDD({
    Color pencilIconColor = Colors.white,
  }) => BlocBuilder<CAPIBloC, CAPIState>(
    builder: (context, state) {
      final dropdownItems = <DropdownMenuItem<String>>[];
      bool showPencil =
          !fsdui.canEditAnyContent() &&
          !fsdui.isArticleEditor() &&
          !fsdui.isGuestEditor();
      if (showPencil) {
        dropdownItems.add(
          _dropdownItemWithPI(
            value: 'sign-in-as-editor',
            child: Text('sign in as a Content editor'),
          ),
        );
        if (fsdui.canEditAnyContent()) {
          if (fsdui.router != null) {
            dropdownItems.add(
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
            );
          }
        }
        addBrightnessItem(dropdownItems);

        return PointerInterceptor(
          child: Theme(
            data: Theme.of(context).copyWith(hoverColor: Colors.transparent),
            child: DropdownButton<String>(
            // key: fco.authIconGK,
            items: dropdownItems,
            underline: Offstage(),
            focusColor: Colors.transparent,
            icon: PointerInterceptor(
              child: Icon(Icons.edit, color: pencilIconColor, size: 24),
            ),
            dropdownColor: Colors.white,
            onChanged: (value) {
              switch (value) {
                case 'sign-in-as-editor':
                  EditablePage.of(context)?.editorPasswordDialog();
                  fsdui.capiBloc.add(CAPIEvent.forceRefresh());
                  break;
                default:
                  if (fsdui.router != null) {
                    EditablePage.of(context)?.showPageNameDialog();
                  }
                  break;
              }
            },
          ),
          ),
        );
      } else {
        // signed in as super, article or guest editor
        dropdownItems.add(
          _dropdownItemWithPI(value: 'sign-out', child: _signOutBtn(context)),
        );
        if (fsdui.canEditAnyContent() && fsdui.router != null) {
          dropdownItems.add(
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
          );
        }
        if (!fsdui.isGuestEditor()) {
          for (String pagePath in fsdui.pageList) {
            // skip currentPath
            try {
              final String currentPath = GoRouterState.of(
                context,
              ).uri.toString();
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
        addBrightnessItem(dropdownItems);

        // wrap dd and its menu items with pointer interceptor
        return PointerInterceptor(
          child: Theme(
            data: Theme.of(context).copyWith(hoverColor: Colors.transparent),
            child: DropdownButton<String>(
              items: dropdownItems,
              underline: Offstage(),
              focusColor: Colors.transparent,
              icon: PointerInterceptor(
                child: Icon(Icons.more_vert, color: fsdui.canEditAnyContent() ? Colors.red : Colors.purpleAccent, size: 24),
              ),
              onChanged: (value) {
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
    },
  );

  void addBrightnessItem(dropdownItems) {
    dropdownItems.add(
      _dropdownItemWithPI(
        value: 'brightness',
        child: ValueListenableBuilder<ThemeMode>(
          valueListenable: fsdui.themeModeNotifier,
          builder: (context, currentMode, child) {
            String buttonText;
            ThemeMode nextMode;
            IconData buttonIcon;

            switch (currentMode) {
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
            return MenuItemButton(
              onPressed: () {
                fsdui.themeModeNotifier.value = nextMode;
              },
              leadingIcon: Icon(buttonIcon),
              child: Text(buttonText),
            );
          },
        ),
      ),
    );
  }

  Widget _signOutBtn(context) => TextButton(
    onPressed: () {
      if (!fsdui.anyPresent([HotspotTargetConfigToolbar.CID])) {
        fsdui.capiBloc.add(CAPIEvent.signedOut());
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
      context.go(pagePath);
      // something funny going on when not in prod mode
      if (false && kDebugMode) {
        fsdui.afterMsDelayDo(1000, () {
          fsdui.refreshCurrentPage();
        });
      }
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
                fsdui.capiBloc.add(CAPIEvent.forceRefresh());
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
        ],
      ),
    ),
  );

  DropdownMenuItem<String> _dropdownItemWithPI({
    required String value,
    required Widget child,
  }) => DropdownMenuItem<String>(
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
