import 'package:bloc/bloc.dart';
import 'package:bloc_testing/cubit/counter_2/counter_2_state.dart';

class CounterCubit extends Cubit<Counter2State> {
  CounterCubit() : super(const Counter2State());

  void increment() => emit(
        state.copyWith(counter: state.counter + 1),
      );

  void decrement() => emit(
        state.copyWith(counter: state.counter - 1),
      );
}
