import 'dart:async';

import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/snodes/widget/fs_folder_node.dart';

// import '../kroki/domain/models/diagram_type.dart' show DiagramType;

// enum FSAction { undo, redo }

abstract class IModelRepository {
  /// auth repo --------------------------------------------
  ///
  Future<String?> requestToken({
    required String ea,
    required String appId,
    required String appName,
  });

  // Emits true once when the confirmed-tokens/{token} doc appears in Firestore.
  Stream<bool> watchTokenConfirmation(
    String appId,
    String token,
    String userEa,
  );

  // -- end of auth rep
  Future<void> ensureSnippetInfoCached({required SnippetName snippetName});

  // Future<void> migrateCollection();
  // Future<void> copyUsersBetweenProjects();
  // Future<void> copyCollectionBetweenProjects();
  // Future<void> copyFlowchartDocBetweenUsersInSameProject(String fromUserId, String toUserId);
  // Future<void> copyUsersProjects();

  Future<SNode?> loadVersionFromFBIntoCache({
    required SnippetInfoModel snippetInfo,
    required VersionId versionId,
  });

  Future<String?> getGcrServerUrlFromFB();

  Future<AppInfoModel?> getAppInfo();

  Future<void> saveAppInfo();

  Future<void> updateSnippetInfo({
    required SnippetName snippetName,
    VersionId? newEditingVersionId,
    VersionId? newPublishingVersionId,
    bool? newAutoPublish,
    List<VersionId>? newVersionIds,
  });

  // Future<bool> saveNewVersionOfSnippetBeingEdited();
  Future<void> saveNewVersionOfSnippet(SNode rootNode);

  Future<void> saveNewVersionOfSnippetMap(
    String snippetName,
    Map<String, dynamic> rootMap,
  );

  Future<bool> saveBrandNewSnippet({
    required SnippetName snippetName,
    required VersionId versionId,
    required SNode initialVersion,
  });

  Future<void> deleteSnippet(final String snippetName);

  Future<void> deleteSnippetVersions(
    final String snippetName,
    final List<VersionId> tbd,
  );

  Future<void> purgePreviousSnippetVersions(final String snippetName);

  Future<void> saveVote({
    required String pollName,
    required VoterId voterId,
    required PollOptionId optionId,
    required Map<PollOptionId, int> newOptionVoteCountMap,
  });

  Future<OptionVoteCountMap> getPollOptionVoteCounts({
    required String pollName,
  });

  Future<UserVoterRecord?> getUsersVote({
    required String pollName,
    required VoterId voterId,
  });

  Future<Map<PollOptionId, List<EmailAddress>>> getVotersByOption({
    required String pollName,
    required List<PollOptionId> pollOptionIds,
  });

  // Future<void> createAndPopulateRootFSStorageNode();

  Future<FSFolderNode> createAndPopulateFolderTree({
    required Reference ref,
    FSFolderNode? parentNode,
  });

  Future<bool> tokenConfirmed(String token);

  Future<void> saveRating(String appId, String email, int stars);
  Future<void> saveFeedback(String appId, String email, String feedback);

  /// Merges [fields] into the verified-user doc's `crosswordProgress.<puzzleId>`
  /// map. Firestore's merge:true recursively merges nested maps, so this only
  /// touches the given puzzle's sub-fields — safe to call with a partial
  /// [fields] (e.g. just `{'completed': true}`) without clobbering the rest.
  Future<void> saveCrosswordProgress(
    String appId,
    String email,
    String puzzleId,
    Map<String, dynamic> fields,
  );

  /// Atomically increments the verified-user doc's `wordleProgress.completed`
  /// and/or `wordleProgress.gaveUp` counters by the given deltas. Unlike
  /// [saveCrosswordProgress] (keyed by puzzle id), wordle games have no
  /// stable identity to key by, so progress is just running totals —
  /// increments (rather than overwrites) so concurrent devices add up
  /// correctly instead of clobbering each other.
  Future<void> incrementWordleProgress(
    String appId,
    String email, {
    int completed = 0,
    int gaveUp = 0,
  });

  /// Merges [gameState] into the verified-user doc's `wordleProgress.gameState`
  /// map — the in-progress game's word/clue/guesses, mirroring
  /// [saveCrosswordProgress]'s `gridState` field. Unlike crossword, wordle has
  /// only one active game at a time, so this isn't keyed by an id — each call
  /// overwrites the previously synced game.
  Future<void> saveWordleGameState(
    String appId,
    String email,
    Map<String, dynamic> gameState,
  );
  Stream<Map<String, dynamic>?> watchVerifiedUserDoc(
    String appId,
    String email,
  );
}
