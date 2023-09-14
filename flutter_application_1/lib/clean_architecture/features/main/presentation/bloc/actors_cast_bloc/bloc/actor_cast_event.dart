abstract class ActorCastEvent {
  const ActorCastEvent();
}

class GetActorsCast extends ActorCastEvent {
  final int castID;
  const GetActorsCast({required this.castID});
}
