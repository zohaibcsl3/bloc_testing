import 'package:bloc_testing/core/shared_preferences_storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_bloc.dart';
import '../core/service_locators/service_locators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBlocs;
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final _preferences = locator<SharedPreferencesStorage>();

  @override
  void initState() {
    _loginBlocs = LoginBloc();
    super.initState();
  }

  @override
  void dispose() {
    _loginBlocs.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
        centerTitle: true,
      ),
      // body: BlocProvider(
      //   create: (context) => _loginBloc,
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Form(
      //       key: _formKey,
      //       child: BlocListener<LoginBloc, LoginState>(
      //         listenWhen: (previous, current) =>
      //         current.loginStatus != previous.loginStatus,
      //         listener: (context, state) {
      //           if (state.loginStatus == LoginStatus.failure) {
      //             ScaffoldMessenger.of(context)
      //               ..hideCurrentSnackBar()
      //               ..showSnackBar(
      //                 SnackBar(content: Text(state.message.toString())),
      //               );
      //           }
      //
      //           if (state.loginStatus == LoginStatus.success) {
      //             ScaffoldMessenger.of(context)
      //               ..hideCurrentSnackBar()
      //               ..showSnackBar(
      //                 const SnackBar(content: Text('Login successful')),
      //               );
      //           }
      //         },
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             BlocBuilder<LoginBloc, LoginState>(
      //               buildWhen: (current, previous) =>
      //               current.email != previous.email,
      //               builder: (context, state) {
      //                 return TextFormField(
      //                   keyboardType: TextInputType.emailAddress,
      //                   focusNode: emailFocusNode,
      //                   decoration: const InputDecoration(
      //                     hintText: "Email Address",
      //                     border: OutlineInputBorder(),
      //                   ),
      //                   onChanged: (value) {
      //                     context
      //                         .read<LoginBloc>()
      //                         .add(EmailChanged(emailString: value));
      //                   },
      //                   validator: (value) {
      //                     if (value!.isEmpty) {
      //                       return 'Enter email';
      //                     }
      //                     return null;
      //                   },
      //                   onFieldSubmitted: (value) {},
      //                 );
      //               },
      //             ),
      //             const SizedBox(
      //               height: 24.0,
      //             ),
      //             BlocBuilder<LoginBloc, LoginState>(
      //               buildWhen: (current, previous) =>
      //               current.password != previous.password,
      //               builder: (context, state) {
      //                 return TextFormField(
      //                   keyboardType: TextInputType.text,
      //                   focusNode: passwordFocusNode,
      //                   decoration: const InputDecoration(
      //                     hintText: "Password",
      //                     border: OutlineInputBorder(),
      //                   ),
      //                   onChanged: (value) {
      //                     context
      //                         .read<LoginBloc>()
      //                         .add(PasswordChanged(passwordString: value));
      //                   },
      //                   validator: (value) {
      //                     if (value!.isEmpty) {
      //                       return 'Enter password';
      //                     }
      //                     return null;
      //                   },
      //                   onFieldSubmitted: (value) {},
      //                 );
      //               },
      //             ),
      //             const SizedBox(
      //               height: 24.0,
      //             ),
      //             SizedBox(
      //               width: double.infinity,
      //               child: BlocBuilder<LoginBloc, LoginState>(
      //                   buildWhen: (current, previous) =>
      //                   current.loginStatus != previous.loginStatus,
      //                   builder: (context, state) {
      //                     return ElevatedButton(
      //                         onPressed: () {
      //                           if (_formKey.currentState!.validate()) {
      //                             context
      //                                 .read<LoginBloc>()
      //                                 .add(LoginButtonEvent());
      //                           }
      //                         },
      //                         child: state.loginStatus == LoginStatus.loading
      //                             ? CircularProgressIndicator()
      //                             : const Text('Login'));
      //                   }),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: BlocProvider(
        create: (_) => _loginBlocs,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: BlocListener<LoginBloc, LoginState>(
              listenWhen: (previous, current) =>
                  current.loginStatus != previous.loginStatus,
              listener: (context, state) {
                if (state.loginStatus == LoginStatus.error) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text(state.message.toString())),
                    );
                }

                if (state.loginStatus == LoginStatus.success) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('Login successful')),
                    );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (current, previous) =>
                          current.email != previous.email,
                      builder: (context, state) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          focusNode: emailFocusNode,
                          decoration: const InputDecoration(
                              hintText: 'Email', border: OutlineInputBorder()),
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(EmailChanged(email: value));
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {},
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (current, previous) =>
                          current.password != previous.password,
                      builder: (context, state) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          focusNode: passwordFocusNode,
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder()),
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(PasswordChanged(password: value));
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {},
                        );
                      }),
                  const SizedBox(
                    height: 50,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (current, previous) =>
                          current.loginStatus != previous.loginStatus,
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _preferences.setString("email", state.email);

                                _preferences.setString(
                                    "password", state.password);

                                context.read<LoginBloc>().add(LoginApi());
                              }
                            },
                            child: state.loginStatus == LoginStatus.loading
                                ? const CircularProgressIndicator()
                                : const Text('Login'));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
