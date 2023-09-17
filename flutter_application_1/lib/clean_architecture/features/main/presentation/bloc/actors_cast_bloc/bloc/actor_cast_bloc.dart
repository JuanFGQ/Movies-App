import 'dart:async';

import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/get_movie_credits.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/actors_cast_bloc/bloc/actor_cast_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/actors_cast_bloc/bloc/actor_cast_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActorsCastBloc extends Bloc<ActorCastEvent, ActorCastState> {
  final GetActorsCastUseCase _getActorsCastUseCase;

  ActorsCastBloc(this._getActorsCastUseCase) : super(const ActorCastLoading()) {
    //
    on<GetActorsCast>(onGetActorsCast);
  }

  void onGetActorsCast(
      GetActorsCast event, Emitter<ActorCastState> emit) async {
    final datastate = await _getActorsCastUseCase.call(params: event.castID);
    if (datastate is DataSuccess && datastate.data!.isNotEmpty) {
      emit(ActorCastDone(datastate.data!, event.castID!));
    }
    if (datastate is DataFailed) {
      emit(ActorCastError(datastate.error!));
    }
  }
}
