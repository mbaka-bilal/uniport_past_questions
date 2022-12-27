// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// abstract class CounterEvent extends Equatable {
//   const CounterEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class Increment extends CounterEvent {
//   const Increment();
// }
//
// class Stop extends CounterEvent {
//   const Stop();
// }
//
// class CounterState extends Equatable {
//   final int count;
//
//   const CounterState(this.count);
//
//   @override
//   List<Object> get props => [count];
//
// }
//
// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc() : super(const CounterState(0));
//
//   @override
//   Stream<CounterState> mapEventToState(CounterEvent event) async* {
//     if (event is Increment) {
//       final newCount = state.count + 1;
//       yield CounterState(newCount);
//     } else if (event is Stop) {
//       final newCount = state.count - 1;
//       yield CounterState(newCount);
//     }
//   }
// }