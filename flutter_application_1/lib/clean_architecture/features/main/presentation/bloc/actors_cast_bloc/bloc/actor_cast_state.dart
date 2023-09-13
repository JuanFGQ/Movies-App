import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/credits_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/credits_entity.dart';

abstract class ActorCastState extends Equatable {
  final List<CastEntity>? actorsCast;

  final Exception? error;

  const ActorCastState({this.actorsCast, this.error});

  @override
  List<Object> get props => [actorsCast!, error!];
}

class ActorCastLoading extends ActorCastState {
  const ActorCastLoading();
}

class ActorCastDone extends ActorCastState {
  const ActorCastDone(List<CastEntity> actorsCast)
      : super(actorsCast: actorsCast);
}

class ActorCastError extends ActorCastState {
  const ActorCastError(Exception error) : super(error: error);
}
