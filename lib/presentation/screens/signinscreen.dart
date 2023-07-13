import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplebloc/presentation/screens/homescreen.dart';
import 'authentication/bloc/bloc/bloc/password_bloc.dart';
import 'authentication/bloc/signinbloc.dart';
import 'authentication/bloc/signinevent.dart';
import 'authentication/bloc/signinstate.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FocusNode setfocus = FocusNode();
  bool showContainer = false;
  bool isUpperCase = false;
  bool isLowerCase = false;
  bool isNumber = false;
  bool specialCharacter = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 54, 94),
      body: BlocConsumer<SignInBloc, SigninState>(
        listener: (context, state) {
          if (state is SignedInUser) {
            Get.off(const HomeScreen());
          }
        },
        builder: (context, state) {
          if (state is SignInLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                SizedBox(
                  height: mdq.height * 0.1,
                ),
                const Center(
                    child: Text(
                  'LogIn',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: mdq.height * 0.1,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          cursorColor: Theme.of(context).colorScheme.background,
                          controller: _emailController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'email field should not be empty';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            BlocProvider.of<SignInBloc>(context).add(
                                SigninDataChangeEvent(_emailController.text,
                                    _passwordController.text));
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              hintText: 'Enter your Email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              focusedBorder: InputBorder.none,
                              errorStyle: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(
                          height: mdq.height * 0.02,
                        ),
                        BlocBuilder<PasswordBloc, PasswordState>(
                          builder: (context, state) {
                            return TextFormField(
                              controller: _passwordController,
                              cursorColor:
                                  Theme.of(context).colorScheme.background,
                              // ignore: unnecessary_type_check
                              obscureText:
                                  state is PasswordShowState ? true : false,
                              focusNode: setfocus,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'password field should not be empty';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                BlocProvider.of<SignInBloc>(context).add(
                                    SigninDataChangeEvent(_emailController.text,
                                        _passwordController.text));
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Enter your password',
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon:
                                      BlocBuilder<PasswordBloc, PasswordState>(
                                          builder: (context, state) {
                                    if (state is PasswordInitialState) {
                                      return GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<PasswordBloc>(context)
                                              .add(PasswordVisible(false));
                                        },
                                        child: const Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                      );
                                    } else if (state is PasswordShowState) {
                                      return GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<PasswordBloc>(context)
                                              .add(PasswordInvisible(false));
                                        },
                                        child: const Icon(
                                          Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<PasswordBloc>(context)
                                              .add(PasswordVisible(true));
                                        },
                                        child: const Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                      );
                                    }
                                  }),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        BlocBuilder<SignInBloc, SigninState>(
                            builder: (context, state) {
                          if (state is SignInErrorState) {
                            return Text(
                              state.errorMessage,
                              style: const TextStyle(color: Colors.white),
                            );
                          } else {
                            return Container();
                          }
                        }),
                        SizedBox(
                          height: mdq.height * 0.01,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: mdq.height * 0.1,
                ),

                BlocBuilder<SignInBloc, SigninState>(builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<SignInBloc>(context).add(
                          SignInButtonEvent(
                              _emailController.text, _passwordController.text));
                    },
                    child: Container(
                      width: 20,
                      height: mdq.height * 0.06,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: state is SignInValidState
                            ? const CircularProgressIndicator(
                                color: Colors.grey,
                              )
                            : const Text(
                                'LogIn',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                      ),
                    ),
                  );
                })
                // SizedBox(
                //   height: mdq.height * 0.03,
                // ),
                // RichText(
                //   textAlign: TextAlign.center,
                //   text: TextSpan(
                //       text: 'Create Account or SignUp',
                //       style: const TextStyle(
                //           color: Colors.white,
                //           decoration: TextDecoration.underline,
                //           fontWeight: FontWeight.bold),
                //       recognizer: TapGestureRecognizer()
                //         ..onTap = () {
                //           // Get.to(() => const SignUpScreen());
                //         }),
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}
