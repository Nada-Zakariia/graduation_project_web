// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'package:control_page/const.dart';
import 'package:control_page/homescreen/cubit/cubit.dart';
import 'package:control_page/homescreen/cubit/states.dart';
import 'package:control_page/homescreen/widgets/screenparts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_split_view/multi_split_view.dart';

class ControlLayout extends StatefulWidget {
  final String station;
  const ControlLayout({super.key, required this.station});
  @override
  State<ControlLayout> createState() => _ControlLayoutState();
}

class _ControlLayoutState extends State<ControlLayout> {
  // List<String> trains = trainsData.keys.toList();

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AppCubit()
        ..initialFunction()
        ..appIndeicator(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, AppStates state) {},
        builder: (context, AppStates state) => Scaffold(
          body: MultiSplitViewTheme(
            data: MultiSplitViewThemeData(
              dividerThickness: 0.00000000000000001,
            ),
            child: MultiSplitView(
                controller: MultiSplitViewController(
                  areas: [Area(weight: 0.15)],
                ),
                children: [
                  firstPart(context, allTrains, widget.station, width, height),
                  MultiSplitViewTheme(
                    data: MultiSplitViewThemeData(
                      dividerThickness: 0.00000000000000001,
                    ),
                    child: MultiSplitView(
                        controller: MultiSplitViewController(
                          areas: [Area(weight: 0.35)],
                        ),
                        children: [
                          secondPart(context, trains, date, width, height),
                          // Text('teesttsts'),
                          thirdPart(context, width, height),
                        ]),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
