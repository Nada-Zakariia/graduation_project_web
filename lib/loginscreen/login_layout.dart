import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:control_page/const.dart';
import 'package:control_page/loginscreen/button.dart';
import 'package:control_page/loginscreen/cubit/cubit.dart';
import 'package:control_page/loginscreen/cubit/states.dart';
import 'package:control_page/loginscreen/defualtForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var stationNameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  FocusNode stationFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              body: Stack(children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'images/hometrain1.jpg',
                //images\hometrain1.jpg
                fit: BoxFit.cover,
              ),
            ),
            Container(
                height: double.infinity,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.4)),
                child: Center(
                    child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Log in here to access Admin view',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                      Container(
                        padding: EdgeInsets.all(20),
                        width: 350,
                        child: Column(
                          children: [
                            defualtForm(
                                context: context,
                                controller: stationNameController,
                                inputType: TextInputType.name,
                                lable: 'Station Name',
                                validator: 'Please Enter the Station Name',
                                myFocusNode: stationFocus),
                            SizedBox(height: 15),
                            defualtForm(
                                context: context,
                                controller: passwordController,
                                inputType: TextInputType.visiblePassword,
                                prefix: Icons.lock_outline,
                                postfix: LoginCubit.get(context).isHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                sufffun: () {
                                  LoginCubit.get(context).visiblePassword();
                                },
                                hidden: LoginCubit.get(context).isHidden,
                                lable: 'Password',
                                validator: 'Please Enter Valid password',
                                myFocusNode: passwordFocus),
                            SizedBox(height: 20),
                            ConditionalBuilder(
                              condition: state is! LoginLoadinglState,
                              builder: (context) => button(
                                  text: 'Log In',
                                  onpress: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).login(
                                          passwordController.text, context);
                                    }
                                  },
                                  width: 320,
                                  height: 40,
                                  context: context),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator(
                                color: ColorTheme.gold,
                              )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )))
          ]));
        },
      ),
    );
  }
}
