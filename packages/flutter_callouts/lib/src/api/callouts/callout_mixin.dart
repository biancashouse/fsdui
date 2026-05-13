import 'dart:async' show Timer;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'package:flutter_callouts/src/api/callouts/overlay_entry_list.dart';
import 'package:flutter_callouts/src/api/repositionable_overlay_content.dart';
import 'package:flutter_callouts/src/debouncer/throttler.dart';

mixin CalloutMixin {
  static const int separationAnimationMs = 500;

  /// A widget that displays a customizable callout box, capable of pointing to
  /// a target widget or being positioned absolutely on the screen.
  ///
  /// Callouts are highly configurable, supporting different pointer styles,
  /// colors, and behaviors. They can be interactive, draggable, and resizable.
  ///
  ///
  /// In the image above:
  /// - The **green bubble** callout points to a target widget.
  /// - The **yellow callout** demonstrates pointing to an element within another widget.
  /// - The **dark blue callout** shows an absolutely positioned callout without a pointer.
  ///
  /// To create a simple callout, provide a [child] and a [target].

  // assumption: at least 1 build has been executed; after initState

  // #begin
  Future<void> showOverlay({
    // ZoomerState? zoomer, // if callout needs access to the zoomer
    required CalloutConfig calloutConfig,
    required Widget calloutContent,
    GlobalKey? targetGK,
    bool ensureLowestOverlay = false,
    int removeAfterMs = 0,
    VoidCallback? onReadyF,
    // Target? configurableTarget,
    bool skipWidthConstraintWarning = false,
    bool skipHeightConstraintWarning = false,
    bool wrapInPointerInterceptor = false,
    CalloutConfig? callout2Follow,
    bool skipOnScreenCheck = false,
    bool isHotspotCallout = false,
    bool skipAnimation = false,
  }) async
  // #end
  {
    // print('showOverlay: ${calloutConfig.cId}');

    if (await fca.alreadyGotit(calloutConfig.cId)) return;

    if (anyPresent([calloutConfig.cId])) return;

    // if ((calloutConfig.calloutW ?? 0) < 0) {
    //   fca.logger.w('negative width ?');
    // }

    if (removeAfterMs > 0) {
      // print('removeAfterMS: $removeAfterMs');
      calloutConfig.removalTimer = Timer(
        Duration(milliseconds: removeAfterMs),
        () {
          dismiss(calloutConfig.cId);
        },
      );
    }

    // has a barrier means allow escape to dismiss
    if (calloutConfig.barrier != null) {
      fca.registerKeystrokeHandler(calloutConfig.cId, (k) {
        if (k.logicalKey == LogicalKeyboardKey.escape) {
          fca.dismiss(calloutConfig.cId);
          fca.hide(calloutConfig.cId);
        }
        return false;
      });
    }

    // possibly measure callout content using target gk
    if ((calloutConfig.initialCalloutW == null ||
        calloutConfig.initialCalloutH == null)) {
      Rect contentRect = await fca.measureWidgetRect(widget: calloutContent);
      calloutConfig.initialCalloutW = calloutConfig.calloutW =
          contentRect.width;
      calloutConfig.initialCalloutH = calloutConfig.calloutH =
          contentRect.height;
      // fca.logger.i('measured content size: ${contentRect.toString()}');
    }

    // // no alignments nor pos not provided, centre on screen
    // if (calloutConfig.initialTargetAlignment == null &&
    //     calloutConfig.initialCalloutAlignment == null &&
    //     calloutConfig.initialCalloutPos == null) {
    //   calloutConfig.targetAlignment = Alignment.center;
    //   calloutConfig.calloutAlignment = Alignment.center;
    //   calloutConfig.initialCalloutPos = Offset(
    //     fca.scrW / 2 - calloutConfig.initialCalloutW! / 2,
    //     fca.scrH / 2 - calloutConfig.initialCalloutH! / 2,
    //   );
    // }

    OverlayEntry oEntry = _createOverlay(
      calloutConfig,
      calloutContent,
      targetGK,
      ensureLowestOverlay,
      wrapInPointerInterceptor,
      skipOnScreenCheck,
      isHotspotCallout,
    ); // will be null if target not present

    // if a notifer was passed in, means inside another overlay, so the target would change as the overlay gets moved or resized
    // ValueNotifier<int>(0).addListener(() {
    //   print("\n\ntime to update the target\n\n");
    //   fca.afterNextBuildDo(() => oEntry.markNeedsBuild());
    // });
    // if (calloutConfig.scrollControllerName != null) {
    //   NamedScrollController? namedSC = NamedScrollController.instance(
    //     calloutConfig.scrollControllerName!,
    //   );
    //   print('add listener: ${namedSC?.name}');

    // print('hasClients: ${namedSC?.hasClients}');
    // print('hasListeners: ${namedSC?.hasListeners}');
    // }

    // if a target is supplied, and its inside a scrollable, listen
    if (targetGK != null) {
      var cc = targetGK.currentContext;
      if (cc != null && cc.mounted) {
        calloutConfig.scrollConfig = fca
            .findAncestorScrollControllerAndDirection(cc);
        calloutConfig.scrollConfig?.controller?.addListener(() {
          // allow to follow scroll - using throttler is optional
          final throttler = Throttler(delayMs: 100);
          final throttleScroll = false;
          if (throttleScroll) {
            throttler.run(
              action: () {
                oEntry.markNeedsBuild();
              },
            );
          } else {
            oEntry.markNeedsBuild();
            calloutConfig.movedOrResizedNotifier?.value++;
          }
        });
      }
    }

    if (calloutConfig.notToast && !skipAnimation) {
      if (isHotspotCallout) {
        // fca.logger.i('_possiblyAnimateAlignmentScale');
        _possiblyAnimateAlignmentScale(calloutConfig, onReadyF, removeAfterMs);
      } else if (calloutConfig.initialCalloutPos == null) {
        // fca.logger.i('_possiblyAnimateSeparation');
        _possiblyAnimateSeparation(calloutConfig, onReadyF, removeAfterMs);
      } else {
        onReadyF?.call();
      }
    } else if (!skipAnimation) {
      // fca.logger.i('_possiblyAnimateToastPos');
      _possiblyAnimateToastPos(calloutConfig, onReadyF);
    } else {
      calloutConfig.setPos(
        _finalOffsetFromGravity(
          calloutConfig.gravity!,
          calloutConfig.calloutW!,
          calloutConfig.calloutH!,
        ),
      );
      onReadyF?.call();
    }

    // possibly follow another callout (our target inside another callout)
    callout2Follow?.movedOrResizedNotifier?.addListener(() {
      refresh(calloutConfig.cId);
    });

    // possibly animating appearance of callout
  }

  OverlayEntry _createOverlay(
    // ZoomerState? zoomer,
    CalloutConfig calloutConfig,
    Widget boxContent,
    GlobalKey? targetGK,
    bool ensureLowestOverlay,
    bool wrapInPointerInterceptor,
    bool skipOnScreenCheck,
    bool isHotspotCallout,
  ) {
    // print('createOverlay');
    // in the event that finalSeparation specified, ensure initial callout at zero separation
    double? savedFinalSeparation = calloutConfig.finalSeparation;
    if ((calloutConfig.finalSeparation ?? 0.0) > 0.0) {
      calloutConfig.setSeparation(0.0);
    }

    // if (calloutConfig.cId == 'blue') {
    //   print('x');
    // }

    Rect? targetRect;
    targetRect = targetGK?.globalPaintBounds(
      skipWidthConstraintWarning: calloutConfig.calloutW != null,
      skipHeightConstraintWarning: calloutConfig.calloutH != null,
    );

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (BuildContext ctx) {
        // print('\n\nOverlayEntry.builder\n\n');
        // FCA.initWithContext(ctx);
        // fca.logger.i('...');
        // fca.logger.i("${calloutConfig.cId} OverlayEntry.builder...");
        // fca.logger.i('...');
        // if (calloutConfig.cId == 'root'){
        //   fca.logger.i('root');
        // }

        // var scrSize = fca.scrSize;

        // if no callout size specified, use screen dimension
        if (calloutConfig.initialCalloutW == null &&
            calloutConfig.initialCalloutH == null &&
            calloutConfig.initialCalloutPos == null) {
          calloutConfig.initialCalloutW = fca.scrW;
          calloutConfig.initialCalloutH = fca.scrH;
        }

        // if a target specified, measure it

        final possiblyMovedTargetRect = targetGK?.globalPaintBounds(
          skipWidthConstraintWarning: calloutConfig.calloutW != null,
          skipHeightConstraintWarning: calloutConfig.calloutH != null,
        );
        if (possiblyMovedTargetRect != null &&
            possiblyMovedTargetRect != targetRect) {
          targetRect = possiblyMovedTargetRect;
        }

        if (targetRect == null) {
          // for toast targetGK will be null, and we have to use the gravity to get a rect
          calloutConfig.initialCalloutPos ??= Offset(
            fca.scrW / 2 - calloutConfig.initialCalloutW! / 2,
            fca.scrH / 2 - calloutConfig.initialCalloutH! / 2,
          );
          targetRect = calloutConfig.translateRectForScroll(
            Rect.fromLTWH(
              calloutConfig.initialCalloutPos!.dx,
              calloutConfig.initialCalloutPos!.dy,
              calloutConfig.initialCalloutW!,
              calloutConfig.initialCalloutH!,
            ),
          );
        }

        OE? oeObj = findOE(calloutConfig.cId);
        if ((calloutConfig.calloutW ?? 0) <= 0) {
          fca.logger.i(
            'calloutW:${calloutConfig.calloutW} !!!  (cId:${calloutConfig.cId}',
          );
        }
        return Visibility(
          visible: oeObj == null || !oeObj.isHidden,
          child: calloutConfig.oeContentWidget(
            targetRect: targetRect!,
            calloutContentF: (_) => RepositionableOverlayContent(
              reshowF: () {
                fca.dismiss(calloutConfig.cId);
                showOverlay(
                  calloutConfig: calloutConfig,
                  calloutContent: boxContent,
                  targetGK: targetGK,
                  ensureLowestOverlay: ensureLowestOverlay,
                );
              },
              child: boxContent,
            ),
            rebuildF: () {
              // print('rebuildF: ${calloutConfig.cId}');
              // callout')
              entry.markNeedsBuild();
            },
            wrapInPointerInterceptor: wrapInPointerInterceptor,
            skipOnScreenCheck: skipOnScreenCheck,
          ),
        );
      },
    );

    calloutConfig.finalSeparation = savedFinalSeparation;
    OverlayEntry? lowestOverlay;
    int? pos;
    if (ensureLowestOverlay) {
      final result = lowestEntry();
      pos = result.$1;
      lowestOverlay = result.$2;
    }

    // fca.afterNextBuildDo(() {
    fca.overlayState?.insert(entry, below: lowestOverlay);
    // });

    // // animate separation just once
    //     if (calloutConfig.finalSeparation > 0.0) {
    //       var rootContext = FCallouts().rootContext;
    //       if (rootContext != null) {
    //         var zoomer = Zoomer.of(rootContext);
    //         if (zoomer != null) {
    //           AnimationController animationController = AnimationController(
    //             duration: const Duration(milliseconds: 1),
    //             vsync: calloutConfig.vsync!,
    //           );
    //           Tween<double> tween =
    //               Tween<double>(begin: 0.0, end: calloutConfig.finalSeparation);
    //           Animation<double> animation = tween.animate(animationController);
    //           animation.addListener(() => calloutConfig.setSeparation(
    //               animation.value, () => entry.markNeedsBuild()));
    //           calloutConfig.setRebuildCallback(() {
    //             entry.markNeedsBuild();
    //           });
    //           animationController.forward().whenComplete(() {
    //             calloutConfig.finishedAnimatingSeparation();
    //           });
    //         }
    //       }
    //     }
    OE.registerOE(
      OE(entry: entry, calloutConfig: calloutConfig, isHidden: false),
      before: pos,
    );
    // print('_createOverlay() - created entry');
    return entry;
  }

  Future<void> _possiblyAnimateSeparation(
    CalloutConfig calloutConfig,
    VoidCallback? onReadyF,
    int? removeAfterMs,
  ) async {
    if ((calloutConfig.finalSeparation ?? 0.0) > 0.0) {
      // print(
      //   'entered _possiblyAnimateSeparation, finalSep is ${calloutConfig.finalSeparation}',
      // );
      // animate separation, top or left
      AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: calloutConfig,
      );
      Tween<double> tween = Tween<double>(
        begin: 0,
        end: calloutConfig.finalSeparation,
      );
      Animation<double> animation = tween.animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      );
      double prevSep = -1;
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // print('animation completed');
          calloutConfig.finishedAnimatingSeparation();
          animationController.dispose();
        }
      });
      animation.addListener(() {
        // fca.logger.i('new separation: ${animation.value}');
        // may have aborted prematurely
        if ((calloutConfig.isAnimating() || removeAfterMs == null) &&
            animation.value > prevSep) {
          prevSep = animation.value;
          calloutConfig.setSeparation(animation.value);
        }
      });
      calloutConfig.startedAnimatingSeparation();
      animationController.reset();
      animationController.forward(from: 0.0).then((value) => onReadyF?.call());
    }
  }

  Future<void> _possiblyAnimateAlignmentScale(
    CalloutConfig calloutConfig,
    VoidCallback? onReadyF,
    int? removeAfterMs,
  ) async {
    if ((calloutConfig.finalSeparation ?? 0.0) > 0.0) {
      // animate separation, top or left
      AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: calloutConfig,
      );
      Tween<double> tween = Tween<double>(begin: 0.0, end: 1.0);
      Animation<double> animation = tween.animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      );
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // print('animation completed');
          calloutConfig.finishedAnimatingSeparation();
          animationController.dispose();
        }
      });
      animation.addListener(() {
        // fca.logger.i('new separation: ${animation.value}');
        // may have aborted prematurely
        if (calloutConfig.isAnimating() || removeAfterMs == null) {
          calloutConfig.setAlignmentScale(animation.value);
        }
      });
      calloutConfig.startedAnimatingSeparation();
      animationController.reset();
      animationController.forward(from: 0.0).then((value) => onReadyF?.call());
    }
  }

  bool _sameType<T1, T2>() => T1 == T2;

  void showToastOverlay({
    required CalloutConfig calloutConfig,
    required Widget calloutContent,
    int removeAfterMs = 0,
    bool skipAnimation = false,
  }) {
    assert(
      calloutConfig.gravity != null &&
          calloutConfig.initialCalloutW != null &&
          calloutConfig.initialCalloutH != null,
    );

    CalloutConfig toastCC = calloutConfig.cloneWith(
      cId: calloutConfig.cId,
      scrollConfig: calloutConfig.scrollConfig,
      initialTargetAlignment: null,
      initialCalloutAlignment: null,
      gravity: calloutConfig.gravity,
      initialCalloutPos: _initialOffsetFromGravity(
        calloutConfig.gravity!,
        calloutConfig.initialCalloutW!,
        calloutConfig.initialCalloutH!,
      ),
      targetPointerType: TargetPointerType.none(),
      // draggable: false,
      allowScrolling: calloutConfig.followScroll,
    );
    if (removeAfterMs > 0) {
      Future.delayed(Duration(milliseconds: removeAfterMs), () {
        dismiss(toastCC.cId);
      });
    }
    showOverlay(
      calloutConfig: toastCC,
      calloutContent: calloutContent,
      skipOnScreenCheck: true,
      removeAfterMs: removeAfterMs,
      skipAnimation: skipAnimation,
    );
  }

  void showToast({
    required String msg,
    Color? bgColor,
    Color? textColor,
    double? fontSize,
    String? fontFamily,
    double? letterSpacing,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double scaleFactor = 1.0,
    Alignment gravity = Alignment.topCenter,
    bool showCPI = false,
    bool onlyOnce = false,
    int removeAfterMs = 0,
    double? width,
    double? height,
    bool showCloseButton = false,
    bool skipAnimation = false,
  }) {
    double? contentTranslateX;
    double? contentTranslateY;
    switch (gravity) {
      case Alignment.topLeft:
        contentTranslateX = 50;
        contentTranslateY = 50;
        break;
      case Alignment.topRight:
        contentTranslateX = -50;
        contentTranslateY = 50;
        break;
      case Alignment.topCenter:
        contentTranslateY = 50;
        break;
      case Alignment.centerLeft:
        contentTranslateX = 50;
        break;
      case Alignment.centerRight:
        contentTranslateX = -50;
        break;
      case Alignment.center:
        break;
      case Alignment.bottomLeft:
        contentTranslateX = 50;
        contentTranslateY = -50;
        break;
      case Alignment.bottomCenter:
        contentTranslateY = -50;
        break;
      case Alignment.bottomRight:
        contentTranslateX = -50;
        contentTranslateY = -50;
        break;
    }

    final w = width ?? fca.scrW * .8;
    final h = height ?? 80;
    var cc = CalloutConfig(
      cId: 'toast-${gravity.toString()}',
      gravity: gravity,
      decorationFillColors: ColorOrGradient.color(bgColor ?? Colors.white),
      initialCalloutW: w,
      initialCalloutH: h,
      contentTranslateX: contentTranslateX,
      contentTranslateY: contentTranslateY,
      showcpi: showCPI,
      onlyOnce: onlyOnce,
      showCloseButton: showCloseButton,
      elevation: 10,
      decorationBorderRadius: 24,
    );

    showToastOverlay(
      calloutConfig: cc,
      calloutContent: Container(
        alignment: Alignment.center,
        width: w, height: h,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: fca.coloredText(
            msg,
            color: textColor ?? Colors.black,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontStyle: fontStyle,
            fontWeight: fontWeight,
            scaleFactor: scaleFactor,
          ),
        ),
      ),
      removeAfterMs: removeAfterMs,
      skipAnimation: skipAnimation,
    );
  }

  void showToastColor1OnColor2({
    Alignment gravity = Alignment.topCenter,
    required String msg,
    required Color textColor,
    double? fontSize,
    String? fontFamily,
    double? letterSpacing,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double scaleFactor = 1.0,
    required Color bgColor,
    bool showCPI = false,
    int removeAfterMs = 0,
  }) => showToast(
    gravity: gravity,
    msg: msg,
    bgColor: bgColor,
    textColor: textColor,
    showCPI: showCPI,
    removeAfterMs: removeAfterMs,
  );

  // void showToastPurpleOnLightWhite({
  //   required CalloutId cId,
  //   required String msg,
  //   int removeAfterMs = 0,
  //   double? widthPC,
  // }) {
  //   var cc = CalloutConfig(
  //     cId: cId,
  //     gravity: Alignment.topCenter,
  //     fillColor: Color.white(),
  //     initialCalloutW: widthPC == null
  //         ? fca.scrW * .8
  //         : fca.scrW * widthPC / 100,
  //     initialCalloutH: 80,
  //     scrollConfig: null,
  //   );
  //
  //   showToastOverlay(
  //     calloutConfig: cc,
  //     calloutContent: Center(
  //       child: fca.coloredText(
  //         msg,
  //         fontSize: 16,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.purple,
  //       ),
  //     ),
  //     removeAfterMs: removeAfterMs,
  //   );
  // }

  // before animating
  static Offset _initialOffsetFromGravity(
    Alignment alignment,
    double w,
    double h,
  ) {
    late Offset initialOffset;
    if (alignment == Alignment.topCenter) {
      initialOffset = Offset((fca.scrW - w) / 2, -h);
    } else if (alignment == Alignment.topLeft) {
      initialOffset = Offset(-w, -h);
    } else if (alignment == Alignment.topRight) {
      initialOffset = Offset(fca.scrW, -h);
    } else if (alignment == Alignment.bottomCenter) {
      initialOffset = Offset((fca.scrW - w) / 2, fca.scrH);
    } else if (alignment == Alignment.bottomLeft) {
      initialOffset = Offset(-w, fca.scrH);
    } else if (alignment == Alignment.bottomRight) {
      initialOffset = Offset(fca.scrW, fca.scrH);
    } else if (alignment == Alignment.center) {
      initialOffset = Offset(
        fca.scrW / 2 - w / 2 - 10,
        fca.scrH / 2 - h / 2 - 10,
      );
    } else if (alignment == Alignment.centerLeft) {
      initialOffset = Offset(-w, fca.scrH / 2 - h / 2);
    } else if (alignment == Alignment.centerRight) {
      initialOffset = Offset(fca.scrW, fca.scrH / 2 - h / 2);
    } else {
      initialOffset = Offset(
        fca.scrW / 2 - w / 2 - 10,
        fca.scrH / 2 - h / 2 - 10,
      );
    }
    return initialOffset;
  }

  // after animating
  Offset _finalOffsetFromGravity(Alignment alignment, double w, double h) {
    late Offset initialOffset;
    if (alignment == Alignment.topCenter) {
      initialOffset = Offset((fca.scrW - w) / 2, 10);
    } else if (alignment == Alignment.topLeft) {
      initialOffset = const Offset(10, 10);
    } else if (alignment == Alignment.topRight) {
      initialOffset = Offset(fca.scrW - w - 10, 10);
    } else if (alignment == Alignment.bottomCenter) {
      initialOffset = Offset((fca.scrW - w) / 2, fca.scrH - h - 10);
    } else if (alignment == Alignment.bottomLeft) {
      initialOffset = Offset(10, fca.scrH - h - 10);
    } else if (alignment == Alignment.bottomRight) {
      initialOffset = Offset(fca.scrW - w - 10, fca.scrH - h - 20);
    } else if (alignment == Alignment.center) {
      initialOffset = Offset(fca.scrW / 2 - w / 2, fca.scrH / 2 - h / 2);
    } else if (alignment == Alignment.centerLeft) {
      initialOffset = Offset(10, fca.scrH / 2 - h / 2);
    } else if (alignment == Alignment.centerRight) {
      initialOffset = Offset(fca.scrW - w - 10, fca.scrH / 2 - h / 2);
    } else {
      initialOffset = Offset(fca.scrW / 2 - w / 2, fca.scrH / 2 - h / 2);
    }
    return initialOffset;
  }

  Future<void> _possiblyAnimateToastPos(
    CalloutConfig toastCC,
    VoidCallback? onReadyF,
  ) async {
    Offset initialPos = _initialOffsetFromGravity(
      toastCC.gravity!,
      toastCC.calloutW!,
      toastCC.calloutH!,
    );
    Offset finalPos = _finalOffsetFromGravity(
      toastCC.gravity!,
      toastCC.calloutW!,
      toastCC.calloutH!,
    );
    // animate pos from offscreen
    AnimationController animationController = AnimationController(
      duration: const Duration(milliseconds: separationAnimationMs),
      vsync: toastCC,
    );
    Tween<Offset> tween = Tween<Offset>(begin: initialPos, end: finalPos);
    Animation<Offset> animation = tween.animate(
      CurvedAnimation(parent: animationController, curve: Curves.bounceOut),
    );
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        toastCC.finishedAnimatingSeparation();
        animationController.dispose();
      }
    });
    animation.addListener(() {
      toastCC.setPos(animation.value);
    });
    toastCC.startedAnimatingSeparation();
    animationController.forward(from: 0.0).then((value) => onReadyF?.call());
  }

  void showCircularProgressIndicator(
    bool show, {
    // ScrollControllerName? scName,
    required String reason,
  }) {
    // if (width != null && height == null) height = 60;
    BuildContext? cachedContext = fca.rootContext;
    if (show && (cachedContext.mounted)) {
      showOverlay(
        calloutConfig: CalloutConfig(
          cId: reason,
          gravity: Alignment.topCenter,
          // scale: 1.0,
          initialCalloutW: 600,
          initialCalloutH: 50,
          elevation: 5,
          decorationBorderRadius: 10,
          alwaysReCalcSize: true,
          targetPointerType: TargetPointerType.none(),
          draggable: false,
          // scrollConfig: null,
        ),
        calloutContent: Center(
          child: Container(
            //width: w,
            // decoration: BoxDecoration(
            //   color: background,
            //   borderRadius: BorderRadius.circular(backgroundRadius),
            // ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Row(
                children: [const CircularProgressIndicator(), Text(reason)],
              ),
            ),
          ),
        ),
      );
    } else {
      dismiss(reason);
    }
  }

  /// given a Rect, returns most appropriate alignment between target and callout within the wrapper
  /// NOTICE does not depend on callout size
  Alignment calcTargetAlignmentWithinWrapper({
    Rect? wrapperRect,
    required Rect targetRect,
  }) {
    // Rect? wrapperRect = findGlobalRect(widget.key as GlobalKey);

    Rect screenRect = Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
    // if (wrapperRect == null) {
    //   wrapperRect = screenRect;
    // }
    wrapperRect = screenRect;

    // final cutoutPadding = 30.0;
    // final scaleTarget = 1.71;
    // double scaledAndPaddedW = scaleTarget * (targetRect.width + cutoutPadding*2);
    // double scaledAndPaddedH = scaleTarget * (targetRect.height + cutoutPadding*2);
    // Rect scaledTr = Rect.fromLTWH(
    //   targetRect.left - (scaledAndPaddedW - targetRect.width)/2,
    //   targetRect.top - (scaledAndPaddedH - targetRect.height)/2,
    //   scaledAndPaddedW,
    //   scaledAndPaddedH,
    // );

    Offset wrapperC = wrapperRect.center;
    Offset targetRectC = targetRect.center;
    double x = (targetRectC.dx - wrapperC.dx) / (wrapperRect.width / 2);
    double y = (targetRectC.dy - wrapperC.dy) / (wrapperRect.height / 2);
    // keep away from sides
    if (x < -0.75) {
      x = -1.0;
    } else if (x > 0.75) {
      x = 1.0;
    }
    if (y < -0.75) {
      y = -1.0;
    } else if (y > 0.75) {
      y = 1.0;
    }
    // fca.logger.i("$x, $y");
    return Alignment(x, y);
  }

  // this offset will be scroll aware
  // Offset? findGlobalPos(GlobalKey key) {
  //   BuildContext? cxt = key.currentContext;
  //   RenderObject? renderObject = cxt?.findRenderObject();
  //   return (renderObject as RenderBox).localToGlobal(Offset.zero);
  // }

  // make sure callout will not be off the screen
  // NOTE - scroll aware!
  (double, double) ensureOnScreen({
    required Rect calloutRect,
    double? minAlwaysVisibleH,
    double? minAlwaysVisibleV,
    required double scrollOffsetX,
    required double scrollOffsetY,
    required bool skipOnScreenCheck,
  }) {
    if (skipOnScreenCheck) return (calloutRect.left, calloutRect.top);

    double resultLeft = calloutRect.left;
    double resultTop = calloutRect.top;
    // adjust s.t entirely visible
    if (calloutRect.left > (fca.scrW - (minAlwaysVisibleH ?? 0.0))) {
      resultLeft = fca.scrW - (minAlwaysVisibleH ?? 0.0);
    }
    if (calloutRect.top >
        (fca.scrH - (minAlwaysVisibleV ?? 0.0) - fca.keyboardHeight) +
            scrollOffsetY) {
      resultTop =
          fca.scrH -
          (minAlwaysVisibleV ?? 0.0) -
          fca.keyboardHeight +
          scrollOffsetY;
    }
    if (calloutRect.right < (minAlwaysVisibleH ?? 0.0)) {
      resultLeft = (minAlwaysVisibleH ?? 0.0) - calloutRect.width;
    }
    if (calloutRect.bottom < (minAlwaysVisibleV ?? 0.0) + scrollOffsetY) {
      resultTop =
          (minAlwaysVisibleV ?? 0.0) - calloutRect.height + scrollOffsetY;
    }

    if (calloutRect.top != resultTop) {
      print('limited');
    }
    return (resultLeft, resultTop);
  }

  Rect restrictRectToScreen(Rect rect) {
    // Clamp left and top to screen bounds
    final left = max(rect.left, 0.0);
    final top = max(rect.top, 0.0);

    // Clamp right and bottom to prevent going off-screen
    final right = min(rect.right, fca.scrW);
    final bottom = min(rect.bottom, fca.scrH);

    // Ensure width and height remain positive (might be 0 if completely off-screen)
    final width = max(0.0, right - left);
    final height = max(0.0, bottom - top);

    return Rect.fromLTWH(left, top, width, height);
  }

  Alignment calcTargetAlignmentWholeScreen(
    final Rect targetRect,
    double calloutW,
    double calloutH,
  ) {
    Rect screenRect = Rect.fromLTWH(0, 0, fca.scrW, fca.scrH);
    double T = targetRect.top;
    double L = targetRect.left;
    double B = screenRect.height - targetRect.bottom;
    double R = screenRect.width - targetRect.right;
    double spareAbove = T - calloutH;
    double spareBelow = B - calloutH;
    double spareOnLeft = L - calloutW;
    double spareOnRight = R - calloutW;
    double maxSpare = [
      spareAbove,
      spareBelow,
      spareOnLeft,
      spareOnRight,
    ].reduce(max);
    if (maxSpare == spareOnRight) {
      return Alignment.centerRight;
    } else if (maxSpare == spareOnLeft)
      return Alignment.centerLeft;
    else if (maxSpare == spareAbove)
      return Alignment.topCenter;
    else
      return Alignment.bottomCenter;
    // else if (maxSpare == spareBelow) return Alignment.topCenter;
    // bool calloutPossiblyOnLeft = L > calloutW;
    // bool calloutPossiblyOnRight = R > calloutW;
    // bool calloutPossiblyAbove = T > calloutH;
    // bool calloutPossiblyBelow = B > calloutH;
    // if (L > R) {
    //   bool onLeft = calloutPossiblyOnLeft;
    // } else {
    //   bool onRight = calloutPossiblyOnRight;
    // }
    // if (T > B) {
    //   bool above = calloutPossiblyAbove;
    // } else {
    //   bool below = calloutPossiblyBelow;
    // }
    // if ()
    //   if (calloutW < B) return Alignment.bottomCenter;
    // if (calloutW < T) return Alignment.topCenter;
    // if (calloutW < R) return Alignment.centerRight;
    // if (calloutW < L) return Alignment.centerLeft;
    //
    // return Alignment.center;
  }

  //------------------
  //---  static  -----
  //------------------
  OE? findOE(CalloutId cId) {
    for (OE oe in OE.list) {
      if (oe.calloutConfig.cId == cId) {
        return oe;
      }
    }
    return null;
  }

  CalloutConfig? getCalloutConfig(CalloutId feature) {
    OE? oe = findOE(feature);
    if (oe != null) return oe.calloutConfig;
    return null;
  }

  void rebuild(CalloutId feature, {VoidCallback? f}) {
    findOE(feature)?.calloutConfig.rebuild(f);
  }

  T? findCallout<T>(String cId) {
    if (_sameType<T, OverlayEntry>()) {
      OverlayEntry? entry = findOE(cId)?.entry;
      return entry as T?;
    }
    if (_sameType<T, OverlayPortalController>()) {
      OverlayPortalController? entry = findOE(cId)?.opC;
      return entry as T?;
    }
    return null;
  }

  CalloutConfig? findCalloutConfig(String cId) => findOE(cId)?.calloutConfig;

  // BuildContext? findCalloutCallerContext(String cId) {
  //   var oe = findOE(cId);
  //   var callerGK = oe?.calloutConfig.callerGK;
  //   return callerGK?.currentContext;
  // }
  //
  // State? findCalloutCallerState(String cId) {
  //   var oe = findOE(cId);
  //   var callerGK = oe?.calloutConfig.callerGK;
  //   return callerGK?.currentState;
  // }
  //
  // Widget? findCalloutCallerWidget(String cId) {
  //   var oe = findOE(cId);
  //   var callerGK = oe?.calloutConfig.callerGK;
  //   return callerGK?.currentWidget;
  // }

  void dismissAll({
    List<CalloutId> exceptFeatures = const [],
    bool onlyToasts = false,
    bool exceptToasts = false,
  }) {
    // fca.logger.d("dismissAll");
    List<CalloutId> overlays2bRemoved = [];
    for (OE oe in OE.list) {
      // if (oe.entry != null) {
      bool isToast = oe.calloutConfig.gravity != null;
      if ((onlyToasts && isToast) ||
          (exceptToasts && !isToast) ||
          (!onlyToasts && !exceptToasts)) {
        overlays2bRemoved.add(oe.calloutConfig.cId);
      }
      // }
    }
    for (CalloutId cId in overlays2bRemoved) {
      if (!exceptFeatures.contains(cId)) dismiss(cId);
    }
  }

  void dismiss(String cId, {bool skipOnDismiss = false}) {
    OE? oeObj = findOE(cId);
    if (oeObj != null) {
      try {
        oeObj
          ..isHidden = true
          ..opC?.hide()
          ..entry?.remove();
      } catch (e) {}
      OE.deRegisterOE(oeObj, skipOnDismiss: skipOnDismiss);
    }
  }

  void dismissToast(Alignment gravity, {bool skipOnDismiss = false}) {
    dismiss('toast-${gravity.toString()}', skipOnDismiss: skipOnDismiss);
  }

  (int? i, OverlayEntry?) lowestEntry() {
    if (OE.list.isNotEmpty) {
      for (int i = 0; i < OE.list.length; i++) {
        if (OE.list[i].entry != null) {
          return (i, OE.list[i].entry);
        }
      }
    }
    return (null, null);
  }

  // void bringToTop(String cId) {
  //   return;
  //   OE? oeObjToMove = findOE(cId);
  //   OverlayEntry? entryToMove = oeObjToMove?.entry;
  //   if (entryToMove == null) return;
  //   final topMostEntry = _nonPortalList().last.entry;
  //   entryToMove.remove();
  //   OverlayState? os = Overlay.maybeOf(fca.rootContext);
  //   os?.insert(entryToMove!, above: topMostEntry);
  //   os?.setState((){});
  //   OE.list.remove(oeObjToMove);
  //   OE.list.add(oeObjToMove!);
  // }

  // List<OE> _nonPortalList() => OE.list.where((oe) => oe.opC == null).toList();

  void dismissTopFeature() {
    if (OE.list.isNotEmpty) {
      OE topOE = OE.list.last;
      dismiss(topOE.calloutConfig.cId);
    }
  }

  CalloutConfig? findParentCalloutConfig(context) {
    return PositionedBoxContent.of(context)?.cc;
  }

  // unhide OpenPortal overlay
  void unhideParentCallout(
    BuildContext context, {
    bool animateSeparation = false,
    int hideAfterMs = 0,
  }) {
    var op = context.findAncestorWidgetOfExactType<OverlayPortal>();
    if (op != null) {
      // find its cc
      for (OE oe in OE.list) {
        if (oe.opC == op.controller) {
          CalloutConfig cc = oe.calloutConfig;
          unhide(cc.cId);
        }
      }
    }

    CalloutConfig? config = findParentCalloutConfig(context);
    if (config != null) {
      unhide(config.cId);
    } else {
      WrappedCalloutState? c = WrappedCallout.of(context);
      c?.unhide(animateSeparation: animateSeparation, hideAfterMs: hideAfterMs);
    }
  }

  void hideParentCallout(context) {
    CalloutConfig? config = findParentCalloutConfig(context);
    if (config != null) {
      hide(config.cId);
    }
  }

  void removeParentCallout(context) {
    CalloutConfig? config = findParentCalloutConfig(context);
    if (config != null) {
      dismiss(config.cId);
    }
  }

  bool isHidden(String cId) => findOE(cId)?.isHidden ?? false;

  void hide(String cId) {
    OE? oeObj = findOE(cId);
    if (oeObj != null /*  && !oeObj.isHidden*/ ) {
      oeObj
        ..isHidden = true
        ..opC?.hide()
        ..entry?.markNeedsBuild();
      // OE.debug();
    }
  }

  void hideAll() {
    // fca.logger.d("dismissAll");
    List<CalloutId> overlays2bRemoved = [];
    for (OE oe in OE.list) {
      // bool isOP = oe.opC != null;
      if (oe.opC != null) {
        overlays2bRemoved.add(oe.calloutConfig.cId);
      }
    }
    for (CalloutId cId in overlays2bRemoved) {
      hide(cId);
    }
  }

  void zeroHeight(String cId) {
    OE? oeObj = findOE(cId);
    if (oeObj != null /*  && !oeObj.isHidden*/ ) {
      oeObj.savedHeight = oeObj.calloutConfig.calloutH = 0;
      oeObj.entry?.markNeedsBuild();
    }
  }

  void restoreHeight(String cId) {
    OE? oeObj = findOE(cId);
    if (oeObj != null /*  && !oeObj.isHidden*/ ) {
      oeObj.calloutConfig.calloutH = oeObj.savedHeight;
      oeObj.entry?.markNeedsBuild();
    }
  }

  void unhide(String cId) {
    OE? oe = findOE(cId);
    if (oe != null /*&& oe.isHidden*/ ) {
      oe
        ..isHidden = false
        ..opC?.show()
        ..entry?.markNeedsBuild();
      // OE.debug();
    }
  }

  void refresh(String cId, {VoidCallback? f}) {
    f?.call();
    final callout = findCallout<OverlayEntry>(cId);
    callout?.markNeedsBuild();
  }

  void refreshAll({VoidCallback? f}) {
    f?.call();
    for (OE oe in OE.list) {
      if (!oe.isHidden && oe.entry != null) {
        oe.calloutConfig.calcEndpoints();
        // oe.calloutConfig.refreshAlignment();
        fca.logger.i(
          'after calcEndpoints: tR is ${oe.calloutConfig.tR().toString()}',
        );
        oe.entry?.markNeedsBuild();
      }
      // if (!oe.isHidden && oe.opC != null) {
      //   oe.opC?.show();
      // }
    }
  }

  bool anyPresent(
    List<CalloutId> cIds, {
    String? startsWith,
    bool includeHidden = false,
  }) {
    bool result = false;
    if (cIds.isEmpty && startsWith == null) {
      result = false;
    } else {
      // full matches
      for (OE oe in OE.list) {
        if ((!oe.isHidden || includeHidden) &&
            cIds.contains(oe.calloutConfig.cId)) {
          result = true;
        }
      }
      // partial matches
      if (startsWith != null) {
        for (OE oe in OE.list) {
          if ((!oe.isHidden || includeHidden) &&
              oe.calloutConfig.cId.startsWith(startsWith)) {
            result = true;
          }
        }
      }
    }
    return result;
  }

  void dismissPartialMatching({
    required String startsWith,
    bool includeHidden = false,
  }) {
    List<String> cidsTBD = [];
    // partial matches
    for (OE oe in OE.list) {
      if ((!oe.isHidden || includeHidden) &&
          oe.calloutConfig.cId.startsWith(startsWith)) {
        cidsTBD.add(oe.calloutConfig.cId);
      }
    }
    if (cidsTBD.isNotEmpty) {
      for (int i=0; i<cidsTBD.length; i++) {
        dismiss(cidsTBD[i]);
      }
    }
  }

  void preventParentCalloutDrag(BuildContext ctx) {
    PositionedBoxContent.of(ctx)?.cc.preventDrag = true;
  }

  void allowParentCalloutDrag(BuildContext ctx) {
    PositionedBoxContent? parent = PositionedBoxContent.of(ctx);
    if (parent != null) {
      // delay to allow _onContentPointerUp to do its thing
      fca.afterMsDelayDo(300, () {
        parent.cc.preventDrag = false;
      });
    }
  }

  /// Calculates the alignment of the center of [other] relative to [target].
  Alignment getAlignmentBetweenRects(Rect target, Rect other) {
    // The point for pointToAlignment needs to be relative to the target's top-left corner.
    final Offset relativeCenter = other.center - target.topLeft;
    return target.pointToAlignment(relativeCenter);
  }

  /// Inflates a [Rect] from its center by a given percentage factor.
  /// (Alternative and clearer implementation)
  Rect inflateRectByFactor_fromCenter(Rect rect, double factor) {
    return Rect.fromCenter(
      center: rect.center,
      width: rect.width * factor,
      height: rect.height * factor,
    );
  }

  /// Calculates the top-left [Offset] for a [calloutRect] to position it
  /// relative to a [targetRect] based on a given [alignment].
  ///
  /// The function finds the point on the [targetRect] specified by the [alignment]
  /// and then calculates the top-left position for the [calloutRect] so that
  /// its center is at that point.
  Offset calculateCalloutTopLeft({
    required Rect targetRect,
    required Rect calloutRect,
    required Alignment alignment,
  }) {
    // 1. Find the target point on the targetRect based on the alignment.
    final Offset anchorPoint = alignment.withinRect(targetRect);

    // 2. Calculate the top-left for the calloutRect so its center is at the anchorPoint.
    return Offset(
      anchorPoint.dx - calloutRect.width / 2,
      anchorPoint.dy - calloutRect.height / 2,
    );
  }

  /// Calculates the top-left Offset for a callout, ensuring it remains visible on screen.
  ///
  /// This function determines where the calloutRect should be placed such that its
  /// center is aligned with a specific point on the targetRect, as defined by
  /// the [alignment] parameter. It then adjusts this position to prevent the
  /// callout from appearing off-screen.
  ///
  /// - [targetRect]: The rectangle that serves as the anchor point, in global coordinates.
  /// - [calloutRect]: The rectangle that needs to be positioned.
  /// - [alignment]: The alignment that describes where the center of the calloutRect
  ///   should be placed relative to the targetRect. For example, Alignment.topCenter
  ///   places the callout's center at the top-center point of the targetRect.
  ///
  /// Returns an [Offset] representing the callout's adjusted top-left position in
  /// global coordinates.
  Offset getRelativeCalloutTopLeft({
    required Rect targetRect,
    required Rect calloutRect,
    required Alignment alignment,
  }) {
    // 1. Calculate the true intersection point on the targetRect's border,
    //    respecting alignments outside the [-1, 1] range.
    final Offset targetPoint = _getIntersectionOnBorder(targetRect, alignment);

    // 2. Calculate the ideal top-left corner of the calloutRect based on its center position.
    final double idealX = targetPoint.dx - calloutRect.width / 2;
    final double idealY = targetPoint.dy - calloutRect.height / 2;

    // 3. Get screen dimensions and define a padding.
    final screenWidth = fca.scrW;
    final screenHeight = fca.scrH;
    const screenPadding = 8.0;

    // 4. Adjust the position to keep the callout on screen, applying padding.
    // This ensures the entire callout is visible.
    final double adjustedX = idealX.clamp(
      screenPadding,
      screenWidth - calloutRect.width - screenPadding,
    );
    final double adjustedY = idealY.clamp(
      screenPadding,
      screenHeight - calloutRect.height - screenPadding,
    );

    // 5. Return the calculated and adjusted top-left offset.
    return Offset(adjustedX, adjustedY);
  }

  /// Calculates the intersection point of a line, defined by the rectangle's
  /// center and an alignment, with the rectangle's border. This correctly
  /// handles alignments where x or y are outside the [-1, 1] range.
  Offset _getIntersectionOnBorder(Rect rect, Alignment alignment) {
    // The line starts at the center of the rectangle.
    final center = rect.center;

    // And it goes towards the point defined by the alignment, which may be outside the rect.
    final targetPoint = alignment.withinRect(rect);

    // If the alignment point is already strictly inside the rect, no intersection calculation is needed.
    // Note: We check abs() < 1.0 to handle cases exactly on the border.
    if (alignment.x.abs() < 1.0 && alignment.y.abs() < 1.0) {
      return targetPoint;
    }

    // Vector from the center to the target point.
    final dx = targetPoint.dx - center.dx;
    final dy = targetPoint.dy - center.dy;

    // If dx or dy is zero, the point is already on a border axis.
    if (dx == 0 || dy == 0) {
      return targetPoint;
    }

    double t = double.maxFinite;

    // Calculate the 't' parameter for the line equation P = center + t * (direction)
    // for each of the four rectangle boundaries. We want the smallest positive t.
    if (dx.abs() > 0) {
      // Check intersection with vertical boundaries (left and right)
      // t = (boundary - origin) / direction
      if (dx > 0) {
        // Right edge
        t = min(t, (rect.right - center.dx) / dx);
      } else {
        // Left edge
        t = min(t, (rect.left - center.dx) / dx);
      }
    }

    if (dy.abs() > 0) {
      // Check intersection with horizontal boundaries (top and bottom)
      if (dy > 0) {
        // Bottom edge
        t = min(t, (rect.bottom - center.dy) / dy);
      } else {
        // Top edge
        t = min(t, (rect.top - center.dy) / dy);
      }
    }

    // The intersection point is the center plus the scaled direction vector.
    return center + Offset(dx, dy) * t;
  }
}

// extension ExtendedOffset on Offset {
//   String toFlooredString() {
//     return '(${dx.floor()}, ${dy.floor()})';
//   }
// }
