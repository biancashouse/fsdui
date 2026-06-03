// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capi_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CAPIState {
  // required bool useFirebase,
  // @Default(false) bool localTestingFilePaths, // because filepaths and fonts accedd differently in own package
  // String?
  // initialValueJsonAssetPath, // both come from MaterialAppWrapper widget constructor
  // required ModelUR modelUR,
  // @Default(false) bool hideIframes,
  // @Default(false) bool hideSnippetPencilIcons,
  // @Default(Offset.zero) Offset? directoryTreeCalloutInitialPos,
  // @Default(400) double? directoryTreeCalloutW,
  // @Default(600) double? directoryTreeCalloutH,
  HotspotTargetModel? get newestTarget => throw _privateConstructorUsedError;
  HotspotTargetModel? get selectedTarget =>
      throw _privateConstructorUsedError; //
  // persisted -----------
  String? get ea => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  bool? get verified => throw _privateConstructorUsedError;
  bool? get isSignedInAsSuperEditor => throw _privateConstructorUsedError;
  bool? get isSignedInAsArticleEditor => throw _privateConstructorUsedError;
  bool? get isSignedInAsGuestEditor => throw _privateConstructorUsedError;
  int? get themeModeIndex =>
      throw _privateConstructorUsedError; // system, light, dark
  // persisted -----------
  // awaitingConfirmation and authErrorMessage are transient — excluded from HydratedBloc serialisation.
  bool? get awaitingConfirmation => throw _privateConstructorUsedError;
  String? get authErrorMessage => throw _privateConstructorUsedError;
  int? get appRating => throw _privateConstructorUsedError;
  String? get textTBD => throw _privateConstructorUsedError;
  bool? get showClipboardContent => throw _privateConstructorUsedError;
  int? get force =>
      throw _privateConstructorUsedError; // hacky way to force a transition
  bool? get onlyTargetsWrappers =>
      throw _privateConstructorUsedError; // hacky way to force a transition
  //==========================================================================================
  //====  PAGE ROUTE NAME  ===================================================================
  //==========================================================================================
  String? get routeName =>
      throw _privateConstructorUsedError; //==========================================================================================
  //====  SNIPPET EDITING  ===================================================================
  //==========================================================================================
  // set when inNodeSelectionMode
  String? get activeSnippetName =>
      throw _privateConstructorUsedError; // set when editing a snippet (ui is a MSV)
  SnippetBeingEdited? get snippetBeingEdited =>
      throw _privateConstructorUsedError;

  /// Create a copy of CAPIState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CAPIStateCopyWith<CAPIState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CAPIStateCopyWith<$Res> {
  factory $CAPIStateCopyWith(CAPIState value, $Res Function(CAPIState) then) =
      _$CAPIStateCopyWithImpl<$Res, CAPIState>;
  @useResult
  $Res call({
    HotspotTargetModel? newestTarget,
    HotspotTargetModel? selectedTarget,
    String? ea,
    String? token,
    bool? verified,
    bool? isSignedInAsSuperEditor,
    bool? isSignedInAsArticleEditor,
    bool? isSignedInAsGuestEditor,
    int? themeModeIndex,
    bool? awaitingConfirmation,
    String? authErrorMessage,
    int? appRating,
    String? textTBD,
    bool? showClipboardContent,
    int? force,
    bool? onlyTargetsWrappers,
    String? routeName,
    String? activeSnippetName,
    SnippetBeingEdited? snippetBeingEdited,
  });
}

/// @nodoc
class _$CAPIStateCopyWithImpl<$Res, $Val extends CAPIState>
    implements $CAPIStateCopyWith<$Res> {
  _$CAPIStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CAPIState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newestTarget = freezed,
    Object? selectedTarget = freezed,
    Object? ea = freezed,
    Object? token = freezed,
    Object? verified = freezed,
    Object? isSignedInAsSuperEditor = freezed,
    Object? isSignedInAsArticleEditor = freezed,
    Object? isSignedInAsGuestEditor = freezed,
    Object? themeModeIndex = freezed,
    Object? awaitingConfirmation = freezed,
    Object? authErrorMessage = freezed,
    Object? appRating = freezed,
    Object? textTBD = freezed,
    Object? showClipboardContent = freezed,
    Object? force = freezed,
    Object? onlyTargetsWrappers = freezed,
    Object? routeName = freezed,
    Object? activeSnippetName = freezed,
    Object? snippetBeingEdited = freezed,
  }) {
    return _then(
      _value.copyWith(
            newestTarget: freezed == newestTarget
                ? _value.newestTarget
                : newestTarget // ignore: cast_nullable_to_non_nullable
                      as HotspotTargetModel?,
            selectedTarget: freezed == selectedTarget
                ? _value.selectedTarget
                : selectedTarget // ignore: cast_nullable_to_non_nullable
                      as HotspotTargetModel?,
            ea: freezed == ea
                ? _value.ea
                : ea // ignore: cast_nullable_to_non_nullable
                      as String?,
            token: freezed == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String?,
            verified: freezed == verified
                ? _value.verified
                : verified // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isSignedInAsSuperEditor: freezed == isSignedInAsSuperEditor
                ? _value.isSignedInAsSuperEditor
                : isSignedInAsSuperEditor // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isSignedInAsArticleEditor: freezed == isSignedInAsArticleEditor
                ? _value.isSignedInAsArticleEditor
                : isSignedInAsArticleEditor // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isSignedInAsGuestEditor: freezed == isSignedInAsGuestEditor
                ? _value.isSignedInAsGuestEditor
                : isSignedInAsGuestEditor // ignore: cast_nullable_to_non_nullable
                      as bool?,
            themeModeIndex: freezed == themeModeIndex
                ? _value.themeModeIndex
                : themeModeIndex // ignore: cast_nullable_to_non_nullable
                      as int?,
            awaitingConfirmation: freezed == awaitingConfirmation
                ? _value.awaitingConfirmation
                : awaitingConfirmation // ignore: cast_nullable_to_non_nullable
                      as bool?,
            authErrorMessage: freezed == authErrorMessage
                ? _value.authErrorMessage
                : authErrorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            appRating: freezed == appRating
                ? _value.appRating
                : appRating // ignore: cast_nullable_to_non_nullable
                      as int?,
            textTBD: freezed == textTBD
                ? _value.textTBD
                : textTBD // ignore: cast_nullable_to_non_nullable
                      as String?,
            showClipboardContent: freezed == showClipboardContent
                ? _value.showClipboardContent
                : showClipboardContent // ignore: cast_nullable_to_non_nullable
                      as bool?,
            force: freezed == force
                ? _value.force
                : force // ignore: cast_nullable_to_non_nullable
                      as int?,
            onlyTargetsWrappers: freezed == onlyTargetsWrappers
                ? _value.onlyTargetsWrappers
                : onlyTargetsWrappers // ignore: cast_nullable_to_non_nullable
                      as bool?,
            routeName: freezed == routeName
                ? _value.routeName
                : routeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            activeSnippetName: freezed == activeSnippetName
                ? _value.activeSnippetName
                : activeSnippetName // ignore: cast_nullable_to_non_nullable
                      as String?,
            snippetBeingEdited: freezed == snippetBeingEdited
                ? _value.snippetBeingEdited
                : snippetBeingEdited // ignore: cast_nullable_to_non_nullable
                      as SnippetBeingEdited?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CAPIStateImplCopyWith<$Res>
    implements $CAPIStateCopyWith<$Res> {
  factory _$$CAPIStateImplCopyWith(
    _$CAPIStateImpl value,
    $Res Function(_$CAPIStateImpl) then,
  ) = __$$CAPIStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    HotspotTargetModel? newestTarget,
    HotspotTargetModel? selectedTarget,
    String? ea,
    String? token,
    bool? verified,
    bool? isSignedInAsSuperEditor,
    bool? isSignedInAsArticleEditor,
    bool? isSignedInAsGuestEditor,
    int? themeModeIndex,
    bool? awaitingConfirmation,
    String? authErrorMessage,
    int? appRating,
    String? textTBD,
    bool? showClipboardContent,
    int? force,
    bool? onlyTargetsWrappers,
    String? routeName,
    String? activeSnippetName,
    SnippetBeingEdited? snippetBeingEdited,
  });
}

/// @nodoc
class __$$CAPIStateImplCopyWithImpl<$Res>
    extends _$CAPIStateCopyWithImpl<$Res, _$CAPIStateImpl>
    implements _$$CAPIStateImplCopyWith<$Res> {
  __$$CAPIStateImplCopyWithImpl(
    _$CAPIStateImpl _value,
    $Res Function(_$CAPIStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CAPIState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newestTarget = freezed,
    Object? selectedTarget = freezed,
    Object? ea = freezed,
    Object? token = freezed,
    Object? verified = freezed,
    Object? isSignedInAsSuperEditor = freezed,
    Object? isSignedInAsArticleEditor = freezed,
    Object? isSignedInAsGuestEditor = freezed,
    Object? themeModeIndex = freezed,
    Object? awaitingConfirmation = freezed,
    Object? authErrorMessage = freezed,
    Object? appRating = freezed,
    Object? textTBD = freezed,
    Object? showClipboardContent = freezed,
    Object? force = freezed,
    Object? onlyTargetsWrappers = freezed,
    Object? routeName = freezed,
    Object? activeSnippetName = freezed,
    Object? snippetBeingEdited = freezed,
  }) {
    return _then(
      _$CAPIStateImpl(
        newestTarget: freezed == newestTarget
            ? _value.newestTarget
            : newestTarget // ignore: cast_nullable_to_non_nullable
                  as HotspotTargetModel?,
        selectedTarget: freezed == selectedTarget
            ? _value.selectedTarget
            : selectedTarget // ignore: cast_nullable_to_non_nullable
                  as HotspotTargetModel?,
        ea: freezed == ea
            ? _value.ea
            : ea // ignore: cast_nullable_to_non_nullable
                  as String?,
        token: freezed == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String?,
        verified: freezed == verified
            ? _value.verified
            : verified // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isSignedInAsSuperEditor: freezed == isSignedInAsSuperEditor
            ? _value.isSignedInAsSuperEditor
            : isSignedInAsSuperEditor // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isSignedInAsArticleEditor: freezed == isSignedInAsArticleEditor
            ? _value.isSignedInAsArticleEditor
            : isSignedInAsArticleEditor // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isSignedInAsGuestEditor: freezed == isSignedInAsGuestEditor
            ? _value.isSignedInAsGuestEditor
            : isSignedInAsGuestEditor // ignore: cast_nullable_to_non_nullable
                  as bool?,
        themeModeIndex: freezed == themeModeIndex
            ? _value.themeModeIndex
            : themeModeIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
        awaitingConfirmation: freezed == awaitingConfirmation
            ? _value.awaitingConfirmation
            : awaitingConfirmation // ignore: cast_nullable_to_non_nullable
                  as bool?,
        authErrorMessage: freezed == authErrorMessage
            ? _value.authErrorMessage
            : authErrorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        appRating: freezed == appRating
            ? _value.appRating
            : appRating // ignore: cast_nullable_to_non_nullable
                  as int?,
        textTBD: freezed == textTBD
            ? _value.textTBD
            : textTBD // ignore: cast_nullable_to_non_nullable
                  as String?,
        showClipboardContent: freezed == showClipboardContent
            ? _value.showClipboardContent
            : showClipboardContent // ignore: cast_nullable_to_non_nullable
                  as bool?,
        force: freezed == force
            ? _value.force
            : force // ignore: cast_nullable_to_non_nullable
                  as int?,
        onlyTargetsWrappers: freezed == onlyTargetsWrappers
            ? _value.onlyTargetsWrappers
            : onlyTargetsWrappers // ignore: cast_nullable_to_non_nullable
                  as bool?,
        routeName: freezed == routeName
            ? _value.routeName
            : routeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        activeSnippetName: freezed == activeSnippetName
            ? _value.activeSnippetName
            : activeSnippetName // ignore: cast_nullable_to_non_nullable
                  as String?,
        snippetBeingEdited: freezed == snippetBeingEdited
            ? _value.snippetBeingEdited
            : snippetBeingEdited // ignore: cast_nullable_to_non_nullable
                  as SnippetBeingEdited?,
      ),
    );
  }
}

/// @nodoc

class _$CAPIStateImpl extends _CAPIState {
  _$CAPIStateImpl({
    this.newestTarget,
    this.selectedTarget,
    this.ea,
    this.token,
    this.verified,
    this.isSignedInAsSuperEditor,
    this.isSignedInAsArticleEditor,
    this.isSignedInAsGuestEditor,
    this.themeModeIndex,
    this.awaitingConfirmation,
    this.authErrorMessage,
    this.appRating,
    this.textTBD,
    this.showClipboardContent,
    this.force,
    this.onlyTargetsWrappers,
    this.routeName,
    this.activeSnippetName,
    this.snippetBeingEdited,
  }) : super._();

  // required bool useFirebase,
  // @Default(false) bool localTestingFilePaths, // because filepaths and fonts accedd differently in own package
  // String?
  // initialValueJsonAssetPath, // both come from MaterialAppWrapper widget constructor
  // required ModelUR modelUR,
  // @Default(false) bool hideIframes,
  // @Default(false) bool hideSnippetPencilIcons,
  // @Default(Offset.zero) Offset? directoryTreeCalloutInitialPos,
  // @Default(400) double? directoryTreeCalloutW,
  // @Default(600) double? directoryTreeCalloutH,
  @override
  final HotspotTargetModel? newestTarget;
  @override
  final HotspotTargetModel? selectedTarget;
  //
  // persisted -----------
  @override
  final String? ea;
  @override
  final String? token;
  @override
  final bool? verified;
  @override
  final bool? isSignedInAsSuperEditor;
  @override
  final bool? isSignedInAsArticleEditor;
  @override
  final bool? isSignedInAsGuestEditor;
  @override
  final int? themeModeIndex;
  // system, light, dark
  // persisted -----------
  // awaitingConfirmation and authErrorMessage are transient — excluded from HydratedBloc serialisation.
  @override
  final bool? awaitingConfirmation;
  @override
  final String? authErrorMessage;
  @override
  final int? appRating;
  @override
  final String? textTBD;
  @override
  final bool? showClipboardContent;
  @override
  final int? force;
  // hacky way to force a transition
  @override
  final bool? onlyTargetsWrappers;
  // hacky way to force a transition
  //==========================================================================================
  //====  PAGE ROUTE NAME  ===================================================================
  //==========================================================================================
  @override
  final String? routeName;
  //==========================================================================================
  //====  SNIPPET EDITING  ===================================================================
  //==========================================================================================
  // set when inNodeSelectionMode
  @override
  final String? activeSnippetName;
  // set when editing a snippet (ui is a MSV)
  @override
  final SnippetBeingEdited? snippetBeingEdited;

  @override
  String toString() {
    return 'CAPIState(newestTarget: $newestTarget, selectedTarget: $selectedTarget, ea: $ea, token: $token, verified: $verified, isSignedInAsSuperEditor: $isSignedInAsSuperEditor, isSignedInAsArticleEditor: $isSignedInAsArticleEditor, isSignedInAsGuestEditor: $isSignedInAsGuestEditor, themeModeIndex: $themeModeIndex, awaitingConfirmation: $awaitingConfirmation, authErrorMessage: $authErrorMessage, appRating: $appRating, textTBD: $textTBD, showClipboardContent: $showClipboardContent, force: $force, onlyTargetsWrappers: $onlyTargetsWrappers, routeName: $routeName, activeSnippetName: $activeSnippetName, snippetBeingEdited: $snippetBeingEdited)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CAPIStateImpl &&
            (identical(other.newestTarget, newestTarget) ||
                other.newestTarget == newestTarget) &&
            (identical(other.selectedTarget, selectedTarget) ||
                other.selectedTarget == selectedTarget) &&
            (identical(other.ea, ea) || other.ea == ea) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(
                  other.isSignedInAsSuperEditor,
                  isSignedInAsSuperEditor,
                ) ||
                other.isSignedInAsSuperEditor == isSignedInAsSuperEditor) &&
            (identical(
                  other.isSignedInAsArticleEditor,
                  isSignedInAsArticleEditor,
                ) ||
                other.isSignedInAsArticleEditor == isSignedInAsArticleEditor) &&
            (identical(
                  other.isSignedInAsGuestEditor,
                  isSignedInAsGuestEditor,
                ) ||
                other.isSignedInAsGuestEditor == isSignedInAsGuestEditor) &&
            (identical(other.themeModeIndex, themeModeIndex) ||
                other.themeModeIndex == themeModeIndex) &&
            (identical(other.awaitingConfirmation, awaitingConfirmation) ||
                other.awaitingConfirmation == awaitingConfirmation) &&
            (identical(other.authErrorMessage, authErrorMessage) ||
                other.authErrorMessage == authErrorMessage) &&
            (identical(other.appRating, appRating) ||
                other.appRating == appRating) &&
            (identical(other.textTBD, textTBD) || other.textTBD == textTBD) &&
            (identical(other.showClipboardContent, showClipboardContent) ||
                other.showClipboardContent == showClipboardContent) &&
            (identical(other.force, force) || other.force == force) &&
            (identical(other.onlyTargetsWrappers, onlyTargetsWrappers) ||
                other.onlyTargetsWrappers == onlyTargetsWrappers) &&
            (identical(other.routeName, routeName) ||
                other.routeName == routeName) &&
            (identical(other.activeSnippetName, activeSnippetName) ||
                other.activeSnippetName == activeSnippetName) &&
            (identical(other.snippetBeingEdited, snippetBeingEdited) ||
                other.snippetBeingEdited == snippetBeingEdited));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    newestTarget,
    selectedTarget,
    ea,
    token,
    verified,
    isSignedInAsSuperEditor,
    isSignedInAsArticleEditor,
    isSignedInAsGuestEditor,
    themeModeIndex,
    awaitingConfirmation,
    authErrorMessage,
    appRating,
    textTBD,
    showClipboardContent,
    force,
    onlyTargetsWrappers,
    routeName,
    activeSnippetName,
    snippetBeingEdited,
  ]);

  /// Create a copy of CAPIState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CAPIStateImplCopyWith<_$CAPIStateImpl> get copyWith =>
      __$$CAPIStateImplCopyWithImpl<_$CAPIStateImpl>(this, _$identity);
}

abstract class _CAPIState extends CAPIState {
  factory _CAPIState({
    final HotspotTargetModel? newestTarget,
    final HotspotTargetModel? selectedTarget,
    final String? ea,
    final String? token,
    final bool? verified,
    final bool? isSignedInAsSuperEditor,
    final bool? isSignedInAsArticleEditor,
    final bool? isSignedInAsGuestEditor,
    final int? themeModeIndex,
    final bool? awaitingConfirmation,
    final String? authErrorMessage,
    final int? appRating,
    final String? textTBD,
    final bool? showClipboardContent,
    final int? force,
    final bool? onlyTargetsWrappers,
    final String? routeName,
    final String? activeSnippetName,
    final SnippetBeingEdited? snippetBeingEdited,
  }) = _$CAPIStateImpl;
  _CAPIState._() : super._();

  // required bool useFirebase,
  // @Default(false) bool localTestingFilePaths, // because filepaths and fonts accedd differently in own package
  // String?
  // initialValueJsonAssetPath, // both come from MaterialAppWrapper widget constructor
  // required ModelUR modelUR,
  // @Default(false) bool hideIframes,
  // @Default(false) bool hideSnippetPencilIcons,
  // @Default(Offset.zero) Offset? directoryTreeCalloutInitialPos,
  // @Default(400) double? directoryTreeCalloutW,
  // @Default(600) double? directoryTreeCalloutH,
  @override
  HotspotTargetModel? get newestTarget;
  @override
  HotspotTargetModel? get selectedTarget; //
  // persisted -----------
  @override
  String? get ea;
  @override
  String? get token;
  @override
  bool? get verified;
  @override
  bool? get isSignedInAsSuperEditor;
  @override
  bool? get isSignedInAsArticleEditor;
  @override
  bool? get isSignedInAsGuestEditor;
  @override
  int? get themeModeIndex; // system, light, dark
  // persisted -----------
  // awaitingConfirmation and authErrorMessage are transient — excluded from HydratedBloc serialisation.
  @override
  bool? get awaitingConfirmation;
  @override
  String? get authErrorMessage;
  @override
  int? get appRating;
  @override
  String? get textTBD;
  @override
  bool? get showClipboardContent;
  @override
  int? get force; // hacky way to force a transition
  @override
  bool? get onlyTargetsWrappers; // hacky way to force a transition
  //==========================================================================================
  //====  PAGE ROUTE NAME  ===================================================================
  //==========================================================================================
  @override
  String? get routeName; //==========================================================================================
  //====  SNIPPET EDITING  ===================================================================
  //==========================================================================================
  // set when inNodeSelectionMode
  @override
  String? get activeSnippetName; // set when editing a snippet (ui is a MSV)
  @override
  SnippetBeingEdited? get snippetBeingEdited;

  /// Create a copy of CAPIState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CAPIStateImplCopyWith<_$CAPIStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
