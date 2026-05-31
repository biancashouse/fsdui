// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart' show ThemeMode;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/hotspot_target_model.dart';
import '../../typedefs.dart';
import 'snippet_being_edited.dart';

part 'capi_state.freezed.dart';

@freezed
class CAPIState with _$CAPIState {
  // const CAPIState._();

  // one per page, each having its own json data file
  // can have multiple (named) target wrappers, hence the maps
  factory CAPIState({
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
    HotspotTargetModel? newestTarget,
    HotspotTargetModel? selectedTarget,
    //
    // String? selectedPanel,
    String? unverifiedEa,
    String? verifiedEa,
    int? appRating,
    String? textTBD,

    bool? isSignedInAsNormalUser,
    bool? isSignedInAsSuperEditor,
    bool? isSignedInAsArticleEditor,
    bool? isSignedInAsGuestEditor,

    int? themeModeIndex, // system, light, dark

    bool? showClipboardContent,
    int? force, // hacky way to force a transition
    bool? onlyTargetsWrappers, // hacky way to force a transition
    //==========================================================================================
    //====  PAGE ROUTE NAME  ===================================================================
    //==========================================================================================
    String? routeName,

    //==========================================================================================
    //====  SNIPPET EDITING  ===================================================================
    //==========================================================================================

    // set when inNodeSelectionMode
    SnippetName? activeSnippetName,

    // set when editing a snippet (ui is a MSV)
    SnippetBeingEdited? snippetBeingEdited,

    // VersionId? snippetBeingEditedVersionId,
    // @Default(true) bool ONLY_TESTING,
  }) = _CAPIState;
}
