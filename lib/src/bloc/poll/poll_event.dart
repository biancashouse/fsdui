import 'package:fsdui/fsdui.dart';

part 'poll_event.freezed.dart';

@freezed
abstract class PollEvent with _$PollEvent {
  const PollEvent._();

  const factory PollEvent.userVoted({
    required VoterId voterId,
    required PollNode poll,
    required PollOptionId optionId,
  }) = UserVoted;

  // const factory PollEvent.voterIdCreated({
  //   required VoterId newVoterId,
  // }) = VoterIdCreated;
}
