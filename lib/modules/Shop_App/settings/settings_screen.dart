import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/Shop_App/cubit.dart';
import '../../../layout/Shop_App/states.dart';
import '../../../shared/shared_component/components.dart';
import '../../../shared/shared_component/constants.dart';

class SettingScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userData;
        nameController.text = model!.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userData != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserDataStates)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 60,
                      child: defaultFormField(
                          raduis: 15,
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Name must be not empty';
                            }
                            return null;
                          },
                          label: 'Full Name',
                          prefix: Icons.person),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 60,
                      child: defaultFormField(
                          raduis: 15,
                          prefix: Icons.email_outlined,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Email address must be not empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefixIcon: Icons.email_sharp),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 60,
                      child: defaultFormField(
                          prefix: Icons.phone,
                          raduis: 15,
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Phone must be not empty';
                            }
                            return null;
                          },
                          label: 'Phone ',
                          prefixIcon: Icons.phone_android_sharp),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 50,
                      child: defaultButton(
                          radius: 15,
                          background: Colors.orange,
                          function: () {
                            ShopCubit.get(context).currentIndex = 0;
                            signOut(context);
                          },
                          text: ShopCubit.signOut),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 50,
                      child: defaultButton(
                          radius: 15,
                          background: Colors.orange,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: ShopCubit.update),
                    )
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
