import 'package:equatable/equatable.dart';

class Counter2State extends Equatable {
  final int counter;

  const Counter2State({this.counter = 0});

  Counter2State copyWith({int? counter}) {
    return Counter2State(
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object?> get props => [counter];
}
