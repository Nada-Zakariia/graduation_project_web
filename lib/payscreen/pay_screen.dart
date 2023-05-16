import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:control_page/const.dart';
import 'package:control_page/loginscreen/button.dart';
import 'package:control_page/loginscreen/defualtForm.dart';
import 'package:control_page/payscreen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/states.dart';

class payScreen extends StatelessWidget {
  const payScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    FocusNode phoneFocus = FocusNode();

    return BlocProvider(
        create: (context) => payCubit(),
        child: BlocConsumer<payCubit, payStates>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              backgroundColor: ColorTheme.black,
              elevation: 0,
              title: Text('Pay Management',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorTheme.white,
                        fontWeight: FontWeight.bold,
                      )),
            ),
            backgroundColor: ColorTheme.white,
            body: Center(
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SizedBox(
                        width: 350,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            defualtForm(
                                context: context,
                                controller: phoneController,
                                inputType: TextInputType.name,
                                lable: 'Phone Number',
                                validator: 'Please Enter the Phone Number',
                                myFocusNode: phoneFocus),
                            const SizedBox(height: 20),
                            button(
                                text: 'Search',
                                onpress: () {
                                  if (formKey.currentState!.validate()) {
                                    payCubit.get(context).searchNumber(
                                          number: phoneController.text,
                                        );
                                  }
                                },
                                width: 320,
                                height: 40,
                                context: context),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ConditionalBuilder(
                    condition: state is! getUserLoadinglState,
                    builder: (context) => Column(
                      children: [
                        state is getUserSuccesslState ||
                                state is getUserErrorState
                            ? Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                    image: const DecorationImage(
                                      repeat: ImageRepeat.noRepeat,
                                      image:
                                          AssetImage('assets/images/train.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: payCubit.get(context).snapshot.exists
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.person,
                                                    size: 25,
                                                    color: ColorTheme.white,
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text(
                                                    'Name : ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color:
                                                              ColorTheme.white,
                                                        ),
                                                  ),
                                                  Text(
                                                    '${payCubit.get(context).user.name}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color:
                                                              ColorTheme.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone_android,
                                                    size: 25,
                                                    color: ColorTheme.white,
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text(
                                                    'Phone Number : ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color:
                                                              ColorTheme.white,
                                                        ),
                                                  ),
                                                  Text(
                                                    '${payCubit.get(context).user.uId}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color:
                                                              ColorTheme.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.money,
                                                    size: 25,
                                                    color: ColorTheme.white,
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text(
                                                    'To Be Paid : ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color:
                                                              ColorTheme.white,
                                                        ),
                                                  ),
                                                  Text(
                                                    '${payCubit.get(context).user.bill} EGP',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color:
                                                              ColorTheme.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  )
                                                ],
                                              )
                                            ])
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                  'Phone Number Not Found !',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: ColorTheme.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                            ),
                                          ],
                                        ),
                                ),
                              )
                            : const SizedBox(
                                width: 0,
                                height: 0,
                              ),
                        state is getUserSuccesslState
                            ? button(
                                text: 'Pay',
                                onpress: () {
                                  payCubit
                                      .get(context)
                                      .updateBalance(phoneController.text);
                                },
                                width: 90,
                                height: 60,
                                context: context)
                            : const SizedBox(
                                height: 0,
                                width: 0,
                              )
                      ],
                    ),
                    fallback: (context) => const Center(
                        child: CircularProgressIndicator(
                      color: ColorTheme.gold,
                    )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
