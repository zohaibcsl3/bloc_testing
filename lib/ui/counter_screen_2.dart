import 'package:bloc_testing/cubit/counter_2/counter_2_cubit.dart';
import 'package:bloc_testing/cubit/counter_2/counter_2_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/display/display_utils.dart';

class CounterScreen2 extends StatefulWidget {
  const CounterScreen2({super.key});

  @override
  State<CounterScreen2> createState() => _CounterScreen2State();
}

class _CounterScreen2State extends State<CounterScreen2> {
  late CounterCubit _counterCubit;

  @override
  void initState() {
    _counterCubit = CounterCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _counterCubit,
        child: Column(
          children: [
            BlocBuilder<CounterCubit, Counter2State>(
              builder: (context, state) {
                return Center(
                  child: Text(
                    state.counter.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 44.0,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<CounterCubit, Counter2State>(
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: state.counter == 30
                              ? () {
                                  DisplayUtils.showSnackBar(
                                    context,
                                    "You've Reached Maximum limit of Counter",
                                  );
                                }
                              : () {
                                  context.read<CounterCubit>().increment();
                                },
                          child: const Text(
                            "Increment",
                          ));
                    },
                  ),
                ),
                const SizedBox(
                  width: 24.0,
                ),
                Expanded(
                  child: BlocBuilder<CounterCubit, Counter2State>(
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: state.counter <= 0
                              ? null
                              : () {
                                  context.read<CounterCubit>().decrement();
                                },
                          child: const Text(
                            "Decrement",
                          ));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
