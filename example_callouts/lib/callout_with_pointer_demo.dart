import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

/// it's important to add the mixin, because callouts are animated
class PointerDemo extends StatefulWidget {
  const PointerDemo({super.key});

  @override
  State<PointerDemo> createState() => _PointerDemoState();
}

class _PointerDemoState extends State<PointerDemo> {
  final GlobalKey _gk = GlobalKey();
  final GlobalKey _lineStartGK = GlobalKey();
  final GlobalKey _lineEndGK = GlobalKey();
  late OverlayEntry _lineOE;
  late CalloutConfig _cc;
  late CalloutBarrierConfig _barrierC;

  // user can change callout properties even when a callout is already shown
  bool _showBarrier = false;

  // final bool _animateArrow = false;
  bool _showLineLabel = false;
  TargetPointerType? _pointerType;

  @override
  void initState() {
    super.initState();

    _barrierC = CalloutBarrierConfig(
      excludeTargetFromBarrier: false,
      roundExclusion: false,
      closeOnTapped: false,
      onTappedF: _onTappedBarrier,
      color: Colors.grey,
      opacity: .9,
    );

    _pointerType = TargetPointerType.thin_line();

    _cc = _createCalloutConfig2();

    fca.afterNextBuildDo(() {
      // namedSC.jumpTo(150.0);
      // showOverlay requires a callout config + callout content + optionally, a target widget globalKey
      fca.showOverlay(
        calloutConfig: _cc,
        calloutContent: _createCalloutContent2(),
        targetGK: _gk,
      );
      // _line = ConnectingLine(
      //   feature: 'line',
      //   fromGK: _lineEndGK,
      //   toGK: _lineStartGK,
      //   arrowType: TargetPointerType.wavy_line(),
      //   arrowColor: Colors.red,
      //   toDelta: 10,
      // );
      // ConnectingLine.show(line: _line); //, removeAfterMs: 5000);
      _lineOE = fca.showLine(
        lineId: 'line',
        fromGK: _lineEndGK,
        toGK: _lineStartGK,
        arrowType: TargetPointerType.wavy_line(),
        arrowColor: Colors.red,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTappedBarrier() {
    fca.showOverlay(
      calloutConfig: CalloutConfig(cId: 'tapped-barrier', elevation: 6),
      calloutContent: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.black),
              ),
              onPressed: () {
                fca.dismiss('some-callout-id');
                fca.dismiss('tapped-barrier');
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'You tapped the barrier.\n\n'
                  'The bool closeOnTap is false: gives you control over whether to allow user to close the callout.\n\n\n'
                  'Tap this button to remove this message callout and the yellow callout.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// CalloutConfig objects are where you configure callouts and the way they point at their target.
  /// All params are shown, and many are commented out for this example callout.
  /// NOTE - a callout can be updated after it is created by updating properties and rebuilding it.
  CalloutConfig _createCalloutConfig2() => CalloutConfig(
    cId: 'some-callout-id',
    initialTargetAlignment: Alignment.topRight,
    initialCalloutAlignment: Alignment.bottomLeft,
    finalSeparation: 80,
    initialCalloutW: 300,
    initialCalloutH: 160,
    targetPointerType: _pointerType,
    bubbleOrTargetPointerColor: Colors.red,
    resizeableH: true,
    resizeableV: true,
    animatePointer: true
  );

  Widget _createCalloutContent2() => DecoratedBox(
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      gradient: LinearGradient(
        colors: [
          Colors.red,
          Colors.red,
          Colors.red,
          Colors.red,
          Colors.red,
          Colors.red,
          Colors.red,
          Colors.red,
          Colors.yellow,
          Colors.lightBlue,
        ],
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: fca.coloredText(
        'Pointing at the icon widget.\n\n'
        'Arrow is red, and this callout content\n'
        'is in a decorated container\n\n'
        'BTW - this callout is draggable and resizable',
        color: Colors.white,
      ),
    ),
  );

  void toggleShowBarrier() {
    setState(() {
      _showBarrier = !_showBarrier;
      _cc.barrier = _showBarrier ? _barrierC : null;
      fca.rebuild('some-callout-id');
    });
  }

  void toggleCutout() {
    setState(() {
      if (_cc.barrier != null) {
        _cc.barrier!.excludeTargetFromBarrier =
            !_cc.barrier!.excludeTargetFromBarrier;
        fca.rebuild('some-callout-id');
      }
    });
  }

  void toggleCutoutShape() {
    setState(() {
      if (_cc.barrier != null) {
        _cc.barrier!.roundExclusion = !_cc.barrier!.roundExclusion;
        fca.rebuild('some-callout-id');
      }
    });
  }

  void _changePointerType(TargetPointerType newType) {
    setState(() {
      _pointerType = _cc.targetPointerType = newType;
      if (newType.name == "bubble" && _cc.decorationFillColors == null) {
        _cc.decorationFillColors = ColorOrGradient.color(Colors.grey);
      } else {
        _cc.decorationFillColors = null;
      }
      if (newType.name != "none" &&
          newType.name != "bubble" &&
          _cc.decorationBorderColors == null) {
        _cc.decorationBorderColors = ColorOrGradient.color(Colors.grey);
      } else {
        _cc.decorationBorderColors = null;
      }
      fca.dismiss('some-callout-id');
      fca.showOverlay(
        calloutConfig: _cc,
        calloutContent: _createCalloutContent2(),
        targetGK: _gk,
      );
    });
  }

  void toggleAnimatedArrow() {
    setState(() {
      _cc.animatePointer = !(_cc.animatePointer ?? false);
      // because animate requires a controller created in its intState, we simply recreate the callout rather just rebuild
      // TODO may refine later
      fca.dismiss('some-callout-id');
      fca.showOverlay(
        calloutConfig: _cc,
        calloutContent: _createCalloutContent2(),
        targetGK: _gk,
      );
    });
  }

  void toggleLineLabel(bool newVal) {
    setState(() {
      _showLineLabel = newVal;
      fca.dismiss('some-callout-id');
      _cc.lineLabelBuilder = newVal
          ? () => Container(
              color: Colors.white,
              padding: EdgeInsets.all(6),
              child: Text('line label'),
            )
          : null;
      fca.showOverlay(
        calloutConfig: _cc,
        calloutContent: _createCalloutContent2(),
        targetGK: _gk,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, _) {
        _lineOE.remove();
        fca.dismissAll();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('flutter_callouts target pointer demo')),
        // give it extra height to show how scrolling can work with callouts
        // also notice we pass in the named scroll controller
        body: Center(
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.green[900],
              fontStyle: FontStyle.italic,
              fontSize: 18,
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'How your callout points to its target is highly configurable.\n',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DropdownMenu<TargetPointerType>(
                          initialSelection: _pointerType,
                          controller: TextEditingController(
                            text: _pointerType?.name,
                          ),
                          requestFocusOnTap: true,
                          inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                            contentPadding: EdgeInsets.all(20.0),
                          ),
                          label: Text(
                            'Pointer Type ${_pointerType != null ? "" : "null"}',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                          onSelected: (TargetPointerType? newType) {
                            if (newType == null) return;
                            _changePointerType(newType);
                          },
                          dropdownMenuEntries: TargetPointerType.entries,
                        ),
                      ),
                      if (_cc.targetPointerType != null &&
                          _cc.targetPointerType?.name != "none" &&
                          _cc.targetPointerType?.name != "wavy" &&
                          _cc.targetPointerType?.name != "bubble")
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('animate arrow ?'),
                              StatefulBuilder(
                                builder: (context, setState) => Checkbox(
                                  value: _cc.animatePointer,
                                  onChanged: (_) {
                                    toggleAnimatedArrow();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_cc.targetPointerType != null &&
                          _cc.targetPointerType?.name != "none" &&
                          _cc.targetPointerType?.name != "bubble")
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('show line label ?'),
                              StatefulBuilder(
                                builder: (context, setState) => Checkbox(
                                  value: _showLineLabel,
                                  onChanged: (newVal) {
                                    toggleLineLabel(newVal ?? false);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 150),
                SizedBox(width:60, height:60, child: Icon(key: _gk, Icons.adb_rounded)),
                SizedBox(height: 50),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Icon(key: _lineStartGK, Icons.access_time_sharp)],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(key: _lineEndGK, Icons.hdr_auto_rounded)],
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          color: Colors.black,
          padding: EdgeInsets.all(8),
          child: Text(
            'demonstrating how callouts can point to their target',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
