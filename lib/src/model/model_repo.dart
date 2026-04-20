import 'package:firebase_storage/firebase_storage.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/snodes/widget/fs_folder_node.dart';

// import '../kroki/domain/models/diagram_type.dart' show DiagramType;

// enum FSAction { undo, redo }

abstract class IModelRepository {
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

  Future<String?> getGcrServerUrl();

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
}
