// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capi_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
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
 HotspotTargetModel? get newestTarget; HotspotTargetModel? get selectedTarget;//
// persisted -----------
 String? get ea; String? get token; bool? get verified; List<String> get verifiedEas; bool? get isSignedInAsSuperEditor; bool? get isSignedInAsArticleEditor; bool? get isSignedInAsGuestEditor; int? get themeModeIndex;// system, light, dark
 int? get appRating;// persisted -----------
// awaitingConfirmation and authErrorMessage are transient — excluded from HydratedBloc serialisation.
 bool? get awaitingConfirmation; String? get authErrorMessage; String? get textTBD; bool? get showClipboardContent; int? get force;// hacky way to force a transition
 bool? get onlyTargetsWrappers;// hacky way to force a transition
//==========================================================================================
//====  PAGE ROUTE NAME  ===================================================================
//==========================================================================================
 String? get routeName;//==========================================================================================
//====  SNIPPET EDITING  ===================================================================
//==========================================================================================
// set when inNodeSelectionMode
 SnippetName? get activeSnippetName;// set when editing a snippet (ui is a MSV)
 SnippetBeingEdited? get snippetBeingEdited;
/// Create a copy of CAPIState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CAPIStateCopyWith<CAPIState> get copyWith => _$CAPIStateCopyWithImpl<CAPIState>(this as CAPIState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CAPIState&&(identical(other.newestTarget, newestTarget) || other.newestTarget == newestTarget)&&(identical(other.selectedTarget, selectedTarget) || other.selectedTarget == selectedTarget)&&(identical(other.ea, ea) || other.ea == ea)&&(identical(other.token, token) || other.token == token)&&(identical(other.verified, verified) || other.verified == verified)&&const DeepCollectionEquality().equals(other.verifiedEas, verifiedEas)&&(identical(other.isSignedInAsSuperEditor, isSignedInAsSuperEditor) || other.isSignedInAsSuperEditor == isSignedInAsSuperEditor)&&(identical(other.isSignedInAsArticleEditor, isSignedInAsArticleEditor) || other.isSignedInAsArticleEditor == isSignedInAsArticleEditor)&&(identical(other.isSignedInAsGuestEditor, isSignedInAsGuestEditor) || other.isSignedInAsGuestEditor == isSignedInAsGuestEditor)&&(identical(other.themeModeIndex, themeModeIndex) || other.themeModeIndex == themeModeIndex)&&(identical(other.appRating, appRating) || other.appRating == appRating)&&(identical(other.awaitingConfirmation, awaitingConfirmation) || other.awaitingConfirmation == awaitingConfirmation)&&(identical(other.authErrorMessage, authErrorMessage) || other.authErrorMessage == authErrorMessage)&&(identical(other.textTBD, textTBD) || other.textTBD == textTBD)&&(identical(other.showClipboardContent, showClipboardContent) || other.showClipboardContent == showClipboardContent)&&(identical(other.force, force) || other.force == force)&&(identical(other.onlyTargetsWrappers, onlyTargetsWrappers) || other.onlyTargetsWrappers == onlyTargetsWrappers)&&(identical(other.routeName, routeName) || other.routeName == routeName)&&(identical(other.activeSnippetName, activeSnippetName) || other.activeSnippetName == activeSnippetName)&&(identical(other.snippetBeingEdited, snippetBeingEdited) || other.snippetBeingEdited == snippetBeingEdited));
}


@override
int get hashCode => Object.hashAll([runtimeType,newestTarget,selectedTarget,ea,token,verified,const DeepCollectionEquality().hash(verifiedEas),isSignedInAsSuperEditor,isSignedInAsArticleEditor,isSignedInAsGuestEditor,themeModeIndex,appRating,awaitingConfirmation,authErrorMessage,textTBD,showClipboardContent,force,onlyTargetsWrappers,routeName,activeSnippetName,snippetBeingEdited]);

@override
String toString() {
  return 'CAPIState(newestTarget: $newestTarget, selectedTarget: $selectedTarget, ea: $ea, token: $token, verified: $verified, verifiedEas: $verifiedEas, isSignedInAsSuperEditor: $isSignedInAsSuperEditor, isSignedInAsArticleEditor: $isSignedInAsArticleEditor, isSignedInAsGuestEditor: $isSignedInAsGuestEditor, themeModeIndex: $themeModeIndex, appRating: $appRating, awaitingConfirmation: $awaitingConfirmation, authErrorMessage: $authErrorMessage, textTBD: $textTBD, showClipboardContent: $showClipboardContent, force: $force, onlyTargetsWrappers: $onlyTargetsWrappers, routeName: $routeName, activeSnippetName: $activeSnippetName, snippetBeingEdited: $snippetBeingEdited)';
}


}

/// @nodoc
abstract mixin class $CAPIStateCopyWith<$Res>  {
  factory $CAPIStateCopyWith(CAPIState value, $Res Function(CAPIState) _then) = _$CAPIStateCopyWithImpl;
@useResult
$Res call({
 HotspotTargetModel? newestTarget, HotspotTargetModel? selectedTarget, String? ea, String? token, bool? verified, List<String> verifiedEas, bool? isSignedInAsSuperEditor, bool? isSignedInAsArticleEditor, bool? isSignedInAsGuestEditor, int? themeModeIndex, int? appRating, bool? awaitingConfirmation, String? authErrorMessage, String? textTBD, bool? showClipboardContent, int? force, bool? onlyTargetsWrappers, String? routeName, SnippetName? activeSnippetName, SnippetBeingEdited? snippetBeingEdited
});




}
/// @nodoc
class _$CAPIStateCopyWithImpl<$Res>
    implements $CAPIStateCopyWith<$Res> {
  _$CAPIStateCopyWithImpl(this._self, this._then);

  final CAPIState _self;
  final $Res Function(CAPIState) _then;

/// Create a copy of CAPIState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? newestTarget = freezed,Object? selectedTarget = freezed,Object? ea = freezed,Object? token = freezed,Object? verified = freezed,Object? verifiedEas = null,Object? isSignedInAsSuperEditor = freezed,Object? isSignedInAsArticleEditor = freezed,Object? isSignedInAsGuestEditor = freezed,Object? themeModeIndex = freezed,Object? appRating = freezed,Object? awaitingConfirmation = freezed,Object? authErrorMessage = freezed,Object? textTBD = freezed,Object? showClipboardContent = freezed,Object? force = freezed,Object? onlyTargetsWrappers = freezed,Object? routeName = freezed,Object? activeSnippetName = freezed,Object? snippetBeingEdited = freezed,}) {
  return _then(_self.copyWith(
newestTarget: freezed == newestTarget ? _self.newestTarget : newestTarget // ignore: cast_nullable_to_non_nullable
as HotspotTargetModel?,selectedTarget: freezed == selectedTarget ? _self.selectedTarget : selectedTarget // ignore: cast_nullable_to_non_nullable
as HotspotTargetModel?,ea: freezed == ea ? _self.ea : ea // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,verified: freezed == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool?,verifiedEas: null == verifiedEas ? _self.verifiedEas : verifiedEas // ignore: cast_nullable_to_non_nullable
as List<String>,isSignedInAsSuperEditor: freezed == isSignedInAsSuperEditor ? _self.isSignedInAsSuperEditor : isSignedInAsSuperEditor // ignore: cast_nullable_to_non_nullable
as bool?,isSignedInAsArticleEditor: freezed == isSignedInAsArticleEditor ? _self.isSignedInAsArticleEditor : isSignedInAsArticleEditor // ignore: cast_nullable_to_non_nullable
as bool?,isSignedInAsGuestEditor: freezed == isSignedInAsGuestEditor ? _self.isSignedInAsGuestEditor : isSignedInAsGuestEditor // ignore: cast_nullable_to_non_nullable
as bool?,themeModeIndex: freezed == themeModeIndex ? _self.themeModeIndex : themeModeIndex // ignore: cast_nullable_to_non_nullable
as int?,appRating: freezed == appRating ? _self.appRating : appRating // ignore: cast_nullable_to_non_nullable
as int?,awaitingConfirmation: freezed == awaitingConfirmation ? _self.awaitingConfirmation : awaitingConfirmation // ignore: cast_nullable_to_non_nullable
as bool?,authErrorMessage: freezed == authErrorMessage ? _self.authErrorMessage : authErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,textTBD: freezed == textTBD ? _self.textTBD : textTBD // ignore: cast_nullable_to_non_nullable
as String?,showClipboardContent: freezed == showClipboardContent ? _self.showClipboardContent : showClipboardContent // ignore: cast_nullable_to_non_nullable
as bool?,force: freezed == force ? _self.force : force // ignore: cast_nullable_to_non_nullable
as int?,onlyTargetsWrappers: freezed == onlyTargetsWrappers ? _self.onlyTargetsWrappers : onlyTargetsWrappers // ignore: cast_nullable_to_non_nullable
as bool?,routeName: freezed == routeName ? _self.routeName : routeName // ignore: cast_nullable_to_non_nullable
as String?,activeSnippetName: freezed == activeSnippetName ? _self.activeSnippetName : activeSnippetName // ignore: cast_nullable_to_non_nullable
as SnippetName?,snippetBeingEdited: freezed == snippetBeingEdited ? _self.snippetBeingEdited : snippetBeingEdited // ignore: cast_nullable_to_non_nullable
as SnippetBeingEdited?,
  ));
}

}


/// Adds pattern-matching-related methods to [CAPIState].
extension CAPIStatePatterns on CAPIState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CAPIState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CAPIState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CAPIState value)  $default,){
final _that = this;
switch (_that) {
case _CAPIState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CAPIState value)?  $default,){
final _that = this;
switch (_that) {
case _CAPIState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HotspotTargetModel? newestTarget,  HotspotTargetModel? selectedTarget,  String? ea,  String? token,  bool? verified,  List<String> verifiedEas,  bool? isSignedInAsSuperEditor,  bool? isSignedInAsArticleEditor,  bool? isSignedInAsGuestEditor,  int? themeModeIndex,  int? appRating,  bool? awaitingConfirmation,  String? authErrorMessage,  String? textTBD,  bool? showClipboardContent,  int? force,  bool? onlyTargetsWrappers,  String? routeName,  SnippetName? activeSnippetName,  SnippetBeingEdited? snippetBeingEdited)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CAPIState() when $default != null:
return $default(_that.newestTarget,_that.selectedTarget,_that.ea,_that.token,_that.verified,_that.verifiedEas,_that.isSignedInAsSuperEditor,_that.isSignedInAsArticleEditor,_that.isSignedInAsGuestEditor,_that.themeModeIndex,_that.appRating,_that.awaitingConfirmation,_that.authErrorMessage,_that.textTBD,_that.showClipboardContent,_that.force,_that.onlyTargetsWrappers,_that.routeName,_that.activeSnippetName,_that.snippetBeingEdited);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HotspotTargetModel? newestTarget,  HotspotTargetModel? selectedTarget,  String? ea,  String? token,  bool? verified,  List<String> verifiedEas,  bool? isSignedInAsSuperEditor,  bool? isSignedInAsArticleEditor,  bool? isSignedInAsGuestEditor,  int? themeModeIndex,  int? appRating,  bool? awaitingConfirmation,  String? authErrorMessage,  String? textTBD,  bool? showClipboardContent,  int? force,  bool? onlyTargetsWrappers,  String? routeName,  SnippetName? activeSnippetName,  SnippetBeingEdited? snippetBeingEdited)  $default,) {final _that = this;
switch (_that) {
case _CAPIState():
return $default(_that.newestTarget,_that.selectedTarget,_that.ea,_that.token,_that.verified,_that.verifiedEas,_that.isSignedInAsSuperEditor,_that.isSignedInAsArticleEditor,_that.isSignedInAsGuestEditor,_that.themeModeIndex,_that.appRating,_that.awaitingConfirmation,_that.authErrorMessage,_that.textTBD,_that.showClipboardContent,_that.force,_that.onlyTargetsWrappers,_that.routeName,_that.activeSnippetName,_that.snippetBeingEdited);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HotspotTargetModel? newestTarget,  HotspotTargetModel? selectedTarget,  String? ea,  String? token,  bool? verified,  List<String> verifiedEas,  bool? isSignedInAsSuperEditor,  bool? isSignedInAsArticleEditor,  bool? isSignedInAsGuestEditor,  int? themeModeIndex,  int? appRating,  bool? awaitingConfirmation,  String? authErrorMessage,  String? textTBD,  bool? showClipboardContent,  int? force,  bool? onlyTargetsWrappers,  String? routeName,  SnippetName? activeSnippetName,  SnippetBeingEdited? snippetBeingEdited)?  $default,) {final _that = this;
switch (_that) {
case _CAPIState() when $default != null:
return $default(_that.newestTarget,_that.selectedTarget,_that.ea,_that.token,_that.verified,_that.verifiedEas,_that.isSignedInAsSuperEditor,_that.isSignedInAsArticleEditor,_that.isSignedInAsGuestEditor,_that.themeModeIndex,_that.appRating,_that.awaitingConfirmation,_that.authErrorMessage,_that.textTBD,_that.showClipboardContent,_that.force,_that.onlyTargetsWrappers,_that.routeName,_that.activeSnippetName,_that.snippetBeingEdited);case _:
  return null;

}
}

}

/// @nodoc


class _CAPIState extends CAPIState {
   _CAPIState({this.newestTarget, this.selectedTarget, this.ea, this.token, this.verified, final  List<String> verifiedEas = const <String>[], this.isSignedInAsSuperEditor, this.isSignedInAsArticleEditor, this.isSignedInAsGuestEditor, this.themeModeIndex, this.appRating, this.awaitingConfirmation, this.authErrorMessage, this.textTBD, this.showClipboardContent, this.force, this.onlyTargetsWrappers, this.routeName, this.activeSnippetName, this.snippetBeingEdited}): _verifiedEas = verifiedEas,super._();
  

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
@override final  HotspotTargetModel? newestTarget;
@override final  HotspotTargetModel? selectedTarget;
//
// persisted -----------
@override final  String? ea;
@override final  String? token;
@override final  bool? verified;
 final  List<String> _verifiedEas;
@override@JsonKey() List<String> get verifiedEas {
  if (_verifiedEas is EqualUnmodifiableListView) return _verifiedEas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_verifiedEas);
}

@override final  bool? isSignedInAsSuperEditor;
@override final  bool? isSignedInAsArticleEditor;
@override final  bool? isSignedInAsGuestEditor;
@override final  int? themeModeIndex;
// system, light, dark
@override final  int? appRating;
// persisted -----------
// awaitingConfirmation and authErrorMessage are transient — excluded from HydratedBloc serialisation.
@override final  bool? awaitingConfirmation;
@override final  String? authErrorMessage;
@override final  String? textTBD;
@override final  bool? showClipboardContent;
@override final  int? force;
// hacky way to force a transition
@override final  bool? onlyTargetsWrappers;
// hacky way to force a transition
//==========================================================================================
//====  PAGE ROUTE NAME  ===================================================================
//==========================================================================================
@override final  String? routeName;
//==========================================================================================
//====  SNIPPET EDITING  ===================================================================
//==========================================================================================
// set when inNodeSelectionMode
@override final  SnippetName? activeSnippetName;
// set when editing a snippet (ui is a MSV)
@override final  SnippetBeingEdited? snippetBeingEdited;

/// Create a copy of CAPIState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CAPIStateCopyWith<_CAPIState> get copyWith => __$CAPIStateCopyWithImpl<_CAPIState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CAPIState&&(identical(other.newestTarget, newestTarget) || other.newestTarget == newestTarget)&&(identical(other.selectedTarget, selectedTarget) || other.selectedTarget == selectedTarget)&&(identical(other.ea, ea) || other.ea == ea)&&(identical(other.token, token) || other.token == token)&&(identical(other.verified, verified) || other.verified == verified)&&const DeepCollectionEquality().equals(other._verifiedEas, _verifiedEas)&&(identical(other.isSignedInAsSuperEditor, isSignedInAsSuperEditor) || other.isSignedInAsSuperEditor == isSignedInAsSuperEditor)&&(identical(other.isSignedInAsArticleEditor, isSignedInAsArticleEditor) || other.isSignedInAsArticleEditor == isSignedInAsArticleEditor)&&(identical(other.isSignedInAsGuestEditor, isSignedInAsGuestEditor) || other.isSignedInAsGuestEditor == isSignedInAsGuestEditor)&&(identical(other.themeModeIndex, themeModeIndex) || other.themeModeIndex == themeModeIndex)&&(identical(other.appRating, appRating) || other.appRating == appRating)&&(identical(other.awaitingConfirmation, awaitingConfirmation) || other.awaitingConfirmation == awaitingConfirmation)&&(identical(other.authErrorMessage, authErrorMessage) || other.authErrorMessage == authErrorMessage)&&(identical(other.textTBD, textTBD) || other.textTBD == textTBD)&&(identical(other.showClipboardContent, showClipboardContent) || other.showClipboardContent == showClipboardContent)&&(identical(other.force, force) || other.force == force)&&(identical(other.onlyTargetsWrappers, onlyTargetsWrappers) || other.onlyTargetsWrappers == onlyTargetsWrappers)&&(identical(other.routeName, routeName) || other.routeName == routeName)&&(identical(other.activeSnippetName, activeSnippetName) || other.activeSnippetName == activeSnippetName)&&(identical(other.snippetBeingEdited, snippetBeingEdited) || other.snippetBeingEdited == snippetBeingEdited));
}


@override
int get hashCode => Object.hashAll([runtimeType,newestTarget,selectedTarget,ea,token,verified,const DeepCollectionEquality().hash(_verifiedEas),isSignedInAsSuperEditor,isSignedInAsArticleEditor,isSignedInAsGuestEditor,themeModeIndex,appRating,awaitingConfirmation,authErrorMessage,textTBD,showClipboardContent,force,onlyTargetsWrappers,routeName,activeSnippetName,snippetBeingEdited]);

@override
String toString() {
  return 'CAPIState(newestTarget: $newestTarget, selectedTarget: $selectedTarget, ea: $ea, token: $token, verified: $verified, verifiedEas: $verifiedEas, isSignedInAsSuperEditor: $isSignedInAsSuperEditor, isSignedInAsArticleEditor: $isSignedInAsArticleEditor, isSignedInAsGuestEditor: $isSignedInAsGuestEditor, themeModeIndex: $themeModeIndex, appRating: $appRating, awaitingConfirmation: $awaitingConfirmation, authErrorMessage: $authErrorMessage, textTBD: $textTBD, showClipboardContent: $showClipboardContent, force: $force, onlyTargetsWrappers: $onlyTargetsWrappers, routeName: $routeName, activeSnippetName: $activeSnippetName, snippetBeingEdited: $snippetBeingEdited)';
}


}

/// @nodoc
abstract mixin class _$CAPIStateCopyWith<$Res> implements $CAPIStateCopyWith<$Res> {
  factory _$CAPIStateCopyWith(_CAPIState value, $Res Function(_CAPIState) _then) = __$CAPIStateCopyWithImpl;
@override @useResult
$Res call({
 HotspotTargetModel? newestTarget, HotspotTargetModel? selectedTarget, String? ea, String? token, bool? verified, List<String> verifiedEas, bool? isSignedInAsSuperEditor, bool? isSignedInAsArticleEditor, bool? isSignedInAsGuestEditor, int? themeModeIndex, int? appRating, bool? awaitingConfirmation, String? authErrorMessage, String? textTBD, bool? showClipboardContent, int? force, bool? onlyTargetsWrappers, String? routeName, SnippetName? activeSnippetName, SnippetBeingEdited? snippetBeingEdited
});




}
/// @nodoc
class __$CAPIStateCopyWithImpl<$Res>
    implements _$CAPIStateCopyWith<$Res> {
  __$CAPIStateCopyWithImpl(this._self, this._then);

  final _CAPIState _self;
  final $Res Function(_CAPIState) _then;

/// Create a copy of CAPIState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? newestTarget = freezed,Object? selectedTarget = freezed,Object? ea = freezed,Object? token = freezed,Object? verified = freezed,Object? verifiedEas = null,Object? isSignedInAsSuperEditor = freezed,Object? isSignedInAsArticleEditor = freezed,Object? isSignedInAsGuestEditor = freezed,Object? themeModeIndex = freezed,Object? appRating = freezed,Object? awaitingConfirmation = freezed,Object? authErrorMessage = freezed,Object? textTBD = freezed,Object? showClipboardContent = freezed,Object? force = freezed,Object? onlyTargetsWrappers = freezed,Object? routeName = freezed,Object? activeSnippetName = freezed,Object? snippetBeingEdited = freezed,}) {
  return _then(_CAPIState(
newestTarget: freezed == newestTarget ? _self.newestTarget : newestTarget // ignore: cast_nullable_to_non_nullable
as HotspotTargetModel?,selectedTarget: freezed == selectedTarget ? _self.selectedTarget : selectedTarget // ignore: cast_nullable_to_non_nullable
as HotspotTargetModel?,ea: freezed == ea ? _self.ea : ea // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,verified: freezed == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool?,verifiedEas: null == verifiedEas ? _self._verifiedEas : verifiedEas // ignore: cast_nullable_to_non_nullable
as List<String>,isSignedInAsSuperEditor: freezed == isSignedInAsSuperEditor ? _self.isSignedInAsSuperEditor : isSignedInAsSuperEditor // ignore: cast_nullable_to_non_nullable
as bool?,isSignedInAsArticleEditor: freezed == isSignedInAsArticleEditor ? _self.isSignedInAsArticleEditor : isSignedInAsArticleEditor // ignore: cast_nullable_to_non_nullable
as bool?,isSignedInAsGuestEditor: freezed == isSignedInAsGuestEditor ? _self.isSignedInAsGuestEditor : isSignedInAsGuestEditor // ignore: cast_nullable_to_non_nullable
as bool?,themeModeIndex: freezed == themeModeIndex ? _self.themeModeIndex : themeModeIndex // ignore: cast_nullable_to_non_nullable
as int?,appRating: freezed == appRating ? _self.appRating : appRating // ignore: cast_nullable_to_non_nullable
as int?,awaitingConfirmation: freezed == awaitingConfirmation ? _self.awaitingConfirmation : awaitingConfirmation // ignore: cast_nullable_to_non_nullable
as bool?,authErrorMessage: freezed == authErrorMessage ? _self.authErrorMessage : authErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,textTBD: freezed == textTBD ? _self.textTBD : textTBD // ignore: cast_nullable_to_non_nullable
as String?,showClipboardContent: freezed == showClipboardContent ? _self.showClipboardContent : showClipboardContent // ignore: cast_nullable_to_non_nullable
as bool?,force: freezed == force ? _self.force : force // ignore: cast_nullable_to_non_nullable
as int?,onlyTargetsWrappers: freezed == onlyTargetsWrappers ? _self.onlyTargetsWrappers : onlyTargetsWrappers // ignore: cast_nullable_to_non_nullable
as bool?,routeName: freezed == routeName ? _self.routeName : routeName // ignore: cast_nullable_to_non_nullable
as String?,activeSnippetName: freezed == activeSnippetName ? _self.activeSnippetName : activeSnippetName // ignore: cast_nullable_to_non_nullable
as SnippetName?,snippetBeingEdited: freezed == snippetBeingEdited ? _self.snippetBeingEdited : snippetBeingEdited // ignore: cast_nullable_to_non_nullable
as SnippetBeingEdited?,
  ));
}


}

// dart format on
