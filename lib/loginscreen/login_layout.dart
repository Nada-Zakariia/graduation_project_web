import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:control_page/const.dart';
import 'package:control_page/loginscreen/button.dart';
import 'package:control_page/loginscreen/cubit/cubit.dart';
import 'package:control_page/loginscreen/cubit/states.dart';
import 'package:control_page/loginscreen/defualtForm.dart';
import 'package:control_page/payscreen/pay_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../homescreen/home_layout.dart';

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
  Color iconcolor = ColorTheme.white;
  Color iconcolor2 = ColorTheme.white;
  String nextscreen = '0';
  bool selected = false;
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
                        width: 375,
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
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      if (selected == false) {
                                        setState(() {
                                          iconcolor = ColorTheme.gold;
                                          nextscreen = '1';

                                          selected = true;
                                        });
                                      } else if (nextscreen == '1') {
                                        setState(() {
                                          iconcolor = ColorTheme.white;

                                          nextscreen = '0';

                                          selected = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 160,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.circle_rounded,
                                            size: 15,
                                            color: iconcolor,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Technical Support',
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorTheme.black,
                                                ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(
                                  width: 7,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (selected == false) {
                                        setState(() {
                                          iconcolor2 = ColorTheme.gold;

                                          nextscreen = '2';

                                          selected = true;
                                        });
                                      } else if (nextscreen == '2') {
                                        setState(() {
                                          iconcolor2 = ColorTheme.white;

                                          nextscreen = '0';

                                          selected = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 160,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.circle_rounded,
                                            size: 15,
                                            color: iconcolor2,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Customer Service',
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorTheme.black,
                                                ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ConditionalBuilder(
                              condition: state is! LoginLoadinglState,
                              builder: (context) => button(
                                  text: 'Log In',
                                  onpress: () {
                                    if (formKey.currentState!.validate()) {
                                      if (nextscreen == '1') {
                                        LoginCubit.get(context).login(
                                            passwordController.text, context);
                                      } else if (nextscreen == '2') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const payScreen()),
                                        );
                                      }
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
