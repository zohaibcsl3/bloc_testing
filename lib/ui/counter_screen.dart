import 'package:bloc_testing/bloc/counter/counter_event.dart';
import 'package:bloc_testing/bloc/counter/counter_state.dart';
import 'package:bloc_testing/bloc/switch_button/swtich_bloc.dart';
import 'package:bloc_testing/bloc/switch_button/swtich_event.dart';
import 'package:bloc_testing/bloc/switch_button/swtich_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';
import '../utils/display/display_utils.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late CounterBloc _counterBloc;

  @override
  void initState() {
    _counterBloc = CounterBloc();
    super.initState();
  }

  @override
  void dispose() {
    _counterBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _counterBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            "Counter App Example",
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<CounterBloc, CounterState>(
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
                    child: BlocBuilder<CounterBloc, CounterState>(
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
                                    context
                                        .read<CounterBloc>()
                                        .add(IncrementCounter());
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
                    child: BlocBuilder<CounterBloc, CounterState>(
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: state.counter <= 0
                                ? null
                                : () {
                                    context
                                        .read<CounterBloc>()
                                        .add(DecrementCounter());
                                  },
                            child: const Text(
                              "Decrement",
                            ));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Notifications"),
                  BlocBuilder<SwitchBloc, SwitchState>(
                    buildWhen: (previous, current) =>
                        previous.switchValue != current.switchValue,
                    builder: (context, state) {
                      return Switch(
                          value: state.switchValue,
                          onChanged: (value) {
                            if (!value) {
                              context
                                  .read<SwitchBloc>()
                                  .add(DisableNotification());
                            } else {
                              context
                                  .read<SwitchBloc>()
                                  .add(EnableNotification());
                            }
                          });
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Card(
                    elevation: state.slider * 100,
                    shadowColor: Colors.red.withOpacity(state.slider),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        state.slider * 100,
                      ),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(state.slider),
                        borderRadius: BorderRadius.circular(state.slider * 100),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Slider(
                      value: state.slider,
                      onChanged: (value) {
                        context
                            .read<SwitchBloc>()
                            .add(SliderEvent(slider: value));
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
