import 'package:bloc/bloc.dart';
import 'package:bloc_testing/bloc/switch_button/swtich_event.dart';
import 'package:bloc_testing/bloc/switch_button/swtich_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchState()) {
    on<EnableNotification>(_enableNotifications);
    on<DisableNotification>(_disableNotifications);
    on<SliderEvent>(_slider);
  }

  void _enableNotifications(EnableNotification event, Emitter emit) {
    emit(state.copyWith(switchValue: true));
  }
void _slider(SliderEvent event, Emitter<SwitchState> emit) {
    emit(state.copyWith(slider: event.slider));
  }

  void _disableNotifications(DisableNotification event, Emitter<SwitchState> emit) {
    emit(state.copyWith(switchValue: false));
  }
}
