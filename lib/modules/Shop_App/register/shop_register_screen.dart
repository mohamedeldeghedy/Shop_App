import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Shop_App/register/register_cubit.dart';
import 'package:shop_app/modules/Shop_App/register/register_states.dart';
import '../../../shared/network/local/cash_helper.dart';
import '../../../shared/shared_component/components.dart';
import '../../../shared/shared_component/constants.dart';
import '../Login/shopLogin.dart';

class ShopRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => ShopRegisterCubit()),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) => {
                if (state is ShopRegisterSuccessState)
                  {
                    if (state.loginModel.status!)
                      {
                        showToast(
                          msg: state.loginModel.message!,
                          state: ToastStates.SUCCESS,
                        ),
                        print(state.loginModel.message),
                        print(state.loginModel.data!.token),
                        CacheHelper.saveData(
                                key: "token",
                                value: state.loginModel.data!.token)
                            .then((value) {
                          token = state.loginModel.data!.token!;
                          navigateAndFinish(context, ShopLoginScreen());
                        })
                      }
                    else
                      {
                        showToast(
                          msg: state.loginModel.message!,
                          state: ToastStates.ERROR,
                        ),
                        print(state.loginModel.message)
                      }
                  }
              },
          builder: (context, state) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: defaultFormField(
                              raduis: 20,
                              controller: nameController,
                              type: TextInputType.text,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'the first name must not be empty';
                                }
                              },
                              label: 'Full Name',
                              hint: 'Full Name',
                              prefix: Icons.text_fields_rounded,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: defaultFormField(
                                raduis: 20,
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'the email must not be empty';
                                  }
                                },
                                label: 'Email Address',
                                prefix: Icons.email_outlined),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: defaultFormField(
                                raduis: 20,
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'the phone must not be empty';
                                  }
                                },
                                label: 'Phone Number',
                                prefix: Icons.phone),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: defaultFormField(
                                raduis: 20,
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                isPassword:
                                    ShopRegisterCubit.get(context).isPassword,
                                onTap: () {
                                  ShopRegisterCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                suffix:
                                    ShopRegisterCubit.get(context).isPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'the password must not be empty';
                                  }
                                },
                                label: 'Password',
                                hint: 'Password',
                                prefix: Icons.lock),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ConditionalBuilder(
                              condition: state is! ShopRegisterLoadingState,
                              builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopRegisterCubit.get(context)
                                          .registerUsers(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text,
                                              phone: phoneController.text);

                                      navigateTo(context, ShopLoginScreen());
                                    }
                                  },
                                  text: 'Register',
                                  radius: 20,
                                  background: Colors.orange),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Sign up with',
                            style: TextStyle(
                                color: Colors.orange.withOpacity(0.5),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MaterialButton(
                                    onPressed: () {},
                                    child: Image(
                                        width: 50,
                                        height: 40,
                                        image: AssetImage(
                                            'assets/images/fblogo.png'))),
                              ),
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Image(
                                    width: 50,
                                    height: 40,
                                    image:
                                        AssetImage('assets/images/gologo.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
