# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install dependencies
flutter pub get

# Run tests
flutter test

# Run a single test file
flutter test test/debouncer_test.dart

# Run the example app
cd example && flutter run

# Analyze for lint issues
flutter analyze
```

## Architecture

**flutter_callouts** is a Flutter package for creating animated callout overlays (popovers/tooltips) that can point to target widgets, float independently, or appear as toasts.

### Entry Point & Global Singleton

`lib/flutter_callouts.dart` exports all public APIs and defines the global `fca` singleton — an instance of `FlutterCalloutMixins`. All package functionality is accessed through `fca`.

```dart
fca.showOverlay(
  calloutConfig: CalloutConfig(...),
  calloutContent: MyWidget(),
  targetGK: myGlobalKey,  // optional — omit for floating/toast callouts
);
```

### Mixin Composition Pattern

`FlutterCalloutMixins` is built by composing ~11 mixins, each responsible for a domain:

| Mixin | File | Responsibility |
|---|---|---|
| `CalloutMixin` | `src/api/callouts/callout_mixin.dart` | Core `showOverlay()`, lifecycle, timers |
| `MeasuringMixin` | `src/measuring_mixin.dart` | Widget bounds via GlobalKey, off-screen measurement |
| `LineMixin` | `src/lines/line_mixin.dart` | Pointing line rendering and animation |
| `DiscoveryMixin` | `src/feature_discovery/discovery_mixin.dart` | Feature discovery/tutorial overlays |
| `SystemMixin` | `src/system_mixin.dart` | Platform detection, device info, package version |
| `RootContextMixin` | `src/root_context_mixin.dart` | Overlay state, navigator, named GlobalKey registry |
| `KeystrokesMixin` | `src/kbd_mixin.dart` | Keyboard event handling |
| `LocalStorageMixin` | `src/ls_mixin.dart` | Persistence for "show once" / "got it" tracking |
| `GotitsMixin` | `src/gotits_mixin.dart` | "Got It" acknowledgment button logic |
| `CanvasMixin` | `src/canvas/canvas_mixin.dart` | Custom canvas drawing |
| `WidgetHelperMixin` | `src/widget/widget_helper_mixin.dart` | Widget tree utilities |

### Three Callout Display Modes

1. **Pointing at target** — set `initialCalloutAlignment` + `initialTargetAlignment` + `targetGK`
2. **Floating** — set `initialCalloutPos` (absolute screen coordinates), no `targetGK`
3. **Toast** — set `gravity` (alignment value for screen edge positioning)

### Key Configuration Class

`CalloutConfig` (`src/api/callouts/callout_config.dart`) is the central serializable config object with 50+ properties. It is designed to be JSON-serializable for use with the companion **fsdui** package (visual callout designer with Firestore persistence).

Notable properties:
- `cId` — unique callout ID (required)
- `scrollControllerName` — required field; forces developer to consider scroll context
- `arrowType` — `ArrowTypeEnum` (11 variants: bubble, thin/medium/large lines, wavy, etc.)
- `decorationShape` — `DecorationShapeEnum` (rectangle, circle, star, bevelled, stadium, dotted variants)
- `barrier` — adds a modal barrier behind the callout with optional circular cutout
- `onlyOnce` — show callout just once (persisted via `LocalStorageMixin`)
- `followScroll` — callout tracks its target widget as the user scrolls

### App Setup

Replace `MaterialApp` with `FlutterCalloutsApp` to enable the global navigation key required for overlay management:

```dart
FlutterCalloutsApp(
  home: MyHomePage(),
  // other MaterialApp params...
)
```

### Rendering

Callouts are rendered via `WrappedCallout` (`src/api/callouts/callout_using_overlayportal.dart`) using Flutter's `OverlayPortal`. Pointing lines are drawn by `PointingLine` (`src/api/callouts/pointing_line.dart`) / `src/lines/pointing_line.dart` using custom `CustomPainter`.

### Feature Discovery

`src/feature_discovery/` provides a separate tutorial overlay system. Wrap widgets with `FeaturedWidget` and use `DiscoveryController` to sequence feature highlights with `DiscoveryOverlay`.
