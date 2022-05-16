import 'dart:async';
import 'package:domain_module/domain_module.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:data_layer/data_layer.dart';

part 'main_bloc.freezed.dart';

class MainBloc {
  final UserService userService;
  final StreamController<MainBlocEvent> _eventsController = StreamController();
  final StreamController<MainBlocState> _stateController =
      StreamController.broadcast();

  Stream<MainBlocState> get state => _stateController.stream;

  MainBloc({
    required this.userService,
  }) {
    _eventsController.stream.listen((event) {
      event.map(
          init: (_) async {
            _stateController.add(
              const MainBlocState.loading(),
            );
            _stateController.add(MainBlocState.loaded(
                userData: await userService.getDefaultUser()));
          },
          setUser: (event) async => _stateController.add(MainBlocState.loaded(
              userData: await userService.getUserById(event.userId))));
    });
  }

  void add(MainBlocEvent event) {
    if (_eventsController.isClosed) return;
    _eventsController.add(event);
  }

  void dispose() {
    _eventsController.close();
  }
}

@freezed
class MainBlocState with _$MainBlocState {
  const factory MainBlocState.loading() = MainLoadingState;
  const factory MainBlocState.loaded({required UserData userData}) =
      MainLoadedState;
}

@freezed
class MainBlocEvent with _$MainBlocEvent {
  const factory MainBlocEvent.init() = MainInitEvent;
  const factory MainBlocEvent.setUser({required int userId}) = _MainSetEvent;
}
