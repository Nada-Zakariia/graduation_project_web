import 'package:control_page/const.dart';
import 'package:control_page/homescreen/cubit/cubit.dart';
import 'package:control_page/payscreen/pay_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget firstPart(BuildContext context, List trains, String station,
    double width, double height)
{
  contextt=context;
  return Container(
    decoration: const BoxDecoration(color: Colors.black),
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            children: [
              Text(
                'Control Page',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: menuTextColor),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20),
                  width: 55,
                  height: 32,
                  decoration: BoxDecoration(
                      color: ColorTheme.gold,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text('Admin',
                        // style: TextStyle(color: pageTextColor),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: pageTextColor,
                            )),
                  )),
            ],
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Container(
            height: height * 0.1,
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: searchController,
              cursorColor: ColorTheme.gold,
              onChanged: (value) =>
                  AppCubit.get(context).onSearchTextChanged(value),
              decoration: InputDecoration(
                labelText: 'Search...',
                labelStyle: const TextStyle(color: Colors.white),
                border: const OutlineInputBorder(),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: ColorTheme.gold,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // searchedTrainsData.isEmpty?Text('No Trains Found'): trainList()
          Container(
            margin: const EdgeInsets.only(bottom: 80),
            height: height * 0.35,
            child: searchedTrainsList.isNotEmpty
                ? trainList(height)
                : const Text(
                    'No Trains Found',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const payScreen()),
              );
            },
            child: Text(
              'Go to Customer Service Page?',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: menuTextColor),
            ),
          )
        ],
      ),
    ),
  );
}

Widget trainList(double height) {
  return Container(
    width: 120,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
            // width: 150,
            child: ListView.builder(
          controller: scrollController,
          itemBuilder: (context, index) {
            return buildTrainListItem(
                searchedTrainsList[index], context, index);
          },
          itemCount: searchedTrainsList.length,
        )),
        Visibility(
            visible: isVisable,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height: height * 0.08,
                  color: Colors.black.withOpacity(0.75),
                ),
                const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: ColorTheme.gold,
                )
              ],
            ))
      ],
    ),
  );
}

Widget secondPart(BuildContext context, List trains, String date, double width,
    double height) {
  return Container(
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        color: ColorTheme.blueGray,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Status(${searchedTrainsList.isEmpty ? allTrains[itemSelect] : searchedTrainsList[itemSelect]})',
                style: Theme.of(context).textTheme.bodyLarge),
            Text(date),
            Container(
                width: double.infinity,
                height: 200,
                child: const Image(
                  image: AssetImage('assets/images/train.png'),
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Stations',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              searchedTrainsList.isEmpty
                  ? trains[itemSelect]['stations']
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                  : searchedTrainsData[itemSelect]['stations']
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", ""),
              // trainsData[selectedTrainName]!['stations']!
              //     .toString()
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Seats',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Number of booked seats:${searchedTrainsList.isEmpty ? numberOfBookedSeats : 48 - int.parse(searchedTrainsData[itemSelect]['available']['${day}'])}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Number of available seats:${searchedTrainsList.isEmpty ? numberOfAvailableSeats : int.parse(searchedTrainsData[itemSelect]['available']['${day}'])}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ));
}

Widget thirdPart(BuildContext context, double width, double height) {
  return Container(
    decoration: const BoxDecoration(color: Colors.white),
    padding: const EdgeInsets.all(40),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CircularPercentIndicator(
                        radius: 80.0,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 12.0,
                        percent: tempValue / 50,
                        progressColor: ColorTheme.saimon,
                        center: Text("${tempValue.toString()}°C",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                      ),
                      const SizedBox(height: 15),
                      title('Temperature', context),
                    ],
                  ),
                  SizedBox(
                    width: width * 0.25,
                  ),
                  Column(
                    children: [
                      CircularPercentIndicator(
                        radius: 80.0,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 12.0,
                        percent: humValue / 100,
                        progressColor: ColorTheme.saimon,
                        center: Text(humValue.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                      ),
                      const SizedBox(height: 15),
                      title('Humidity', context),
                    ],
                  ),
                ],
              ),
              // const Spacer(),
              sensorIcon('Flame', flameState, context, width, height),
              // const Spacer(),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                children: [
                  sensorIcon(
                      'Door Lock', doorLockState, context, width, height),
                  SizedBox(
                    width: width * 0.3,
                  ),
                  sensorIcon('Lights', lightState, context, width, height),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget buildTrainListItem(String text, context, int index) {
  return GestureDetector(
    onTap: () {
      trainNum = searchedTrainsData[index]["trainNum"].toString();
      numberOfAvailableSeats =
          int.parse(searchedTrainsData[index]['available']['${day}']);
      numberOfBookedSeats = 48 - numberOfAvailableSeats;
      itemSelect = index;
      selectedTrainName = text;
      tempValue = 0;
      humValue = 0;
      flameState = false;
      doorLockState = false;
      lightState = false;
      AppCubit.get(context).selectPage();
    },
    child: MouseRegion(
      onEnter: (event) {
        itemHover = index;
        AppCubit.get(context).hoverEffect();
      },
      onExit: (event) {
        itemHover = index;
        AppCubit.get(context).hoverEffect();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isHover && itemHover == index
                    ? Colors.white54
                    : itemSelect == index
                        ? Colors.white54
                        : Colors.white)),
      ),
    ),
  );
}

Widget title(String text, BuildContext context) {
  return Text(text,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(fontWeight: FontWeight.bold, color: ColorTheme.lightGray));
}

Widget sensorIcon(
    String text, var state, BuildContext context, double width, double height) {
  return Container(
      padding: const EdgeInsets.all(8),
      height: 130,
      width: 130,
      decoration: BoxDecoration(
          color: ColorTheme.blueGray, borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        Icon(
          text == 'Flame'
              ? Icons.fire_extinguisher_outlined
              : text == 'Lights'
                  ? Icons.lightbulb
                  : state
                      ? Icons.lock_open_outlined
                      : Icons.lock,
          size: 85,
          color: state
              ? text == 'Flame'
                  ? Colors.red
                  : ColorTheme.primaryColor
              : ColorTheme.lightGray,
        ),
        title(text, context),
      ]));
}
// ValueListenableBuilder<String>(
// builder: (BuildContext context, String value, Widget? child) {
// return Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: <Widget>[
// Text('$value',
// style: const TextStyle(
// color: Colors.deepPurpleAccent, fontSize: 35))
// ],
// );
// },
// valueListenable: MapsCubit.get(context).mqttHandler.data,
// ),