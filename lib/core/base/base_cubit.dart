import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<T, A> extends Cubit<T> {
  BaseCubit(super.initialState);

  Future<void> doAction(A action);

  void safeEmit(T state) {
    if (!isClosed) emit(state);
  }
}
