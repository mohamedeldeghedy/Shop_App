import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Shop_App/Login/states.dart';
import '../../../layout/Shop_App/ShoopingLayout.dart';
import '../../../layout/Shop_App/cubit.dart';
import '../../../shared/network/local/cash_helper.dart';
import '../../../shared/shared_component/components.dart';
import '../../../shared/shared_component/constants.dart';
import '../register/shop_register_screen.dart';
import 'cubit.dart';

// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              showToast(
                  msg: state.loginModel.message.toString(),
                  state: ToastStates.SUCCESS);

              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token!;
                navigateAndFinish(context, ShopLayout());

                ShopCubit.get(context).getUserData();
                ShopCubit.get(context).getFavData();

                navigateAndFinish(context, ShopLayout());
              });
            } else {
              showToast(
                  msg: state.loginModel.message.toString(),
                  state: ToastStates.ERROR);
              print(state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: Colors.orange.withOpacity(0.7),
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          raduis: 15,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email address';
                            }
                            return null;
                          },
                          prefixIcon: Icons.email,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          onFieldSubmitted: (value) {},
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultFormField(
                          raduis: 15,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).loginUsers(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password is to short';
                            }
                            return null;
                          },
                          prefixIcon: Icons.lock,
                          suffixIcon: ShopLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          label: 'Password',
                          prefix: Icons.password_outlined,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).loginUsers(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => Container(
                            height: 50,
                            child: defaultButton(
                                background: Colors.orange,
                                function: () {
                                  // debugPrint(emailController.text);
                                  // debugPrint(passwordController.text);
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).loginUsers(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                isUpperCase: false,
                                radius: 15,
                                text: 'Login'),
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account? '),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                child: Text('register now')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
