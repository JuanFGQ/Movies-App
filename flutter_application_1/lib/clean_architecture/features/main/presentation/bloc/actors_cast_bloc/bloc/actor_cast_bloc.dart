import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/get_movie_credits.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/actors_cast_bloc/bloc/actor_cast_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/actors_cast_bloc/bloc/actor_cast_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActorsCastBloc extends Bloc<ActorCastEvent, ActorCastState> {
  final GetActorsCastUseCase _getActorsCastUseCase;

  ActorsCastBloc(this._getActorsCastUseCase)
      : super((const ActorCastLoading())) {
    on<GetActorsCast>(onGetActorCast);
  }

  void onGetActorCast(GetActorsCast event, Emitter<ActorCastState> emit) async {
    //*RECORDAR QUE ESTA FUNCION NECESIT UN VALOR DE ID QUE TENGO QUE ASIGNARLE
    final dataState = await _getActorsCastUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(ActorCastDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(ActorCastError(state.error!));
    }
  }
}
