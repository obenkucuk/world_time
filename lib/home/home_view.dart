import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_time/home/cubit/home_cubit.dart';
import 'package:world_time/home/home_data.dart';
import 'package:world_time/selected_country/single_country_view.dart';
import 'package:world_time/theme/cubit/app_theme_cubit.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController controller = TextEditingController();

  String timeParser(String dateTimeString, String type) {
    final dateTime = DateTime.parse(dateTimeString);

    final format = DateFormat(type);
    final clockString = format.format(dateTime);

    return clockString;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    Timer.periodic(
        Duration(seconds: 5),
        (Timer t) => setState(() {
              now;
            }));
    const String goodMorning = "Günaydın, Özgür!";
    const String goodDays = "İyi Günler, Özgür!";
    const String hintText = "Arama";
    final int intTime = int.parse(timeParser(now.toString(), "HH"));
    final String hourAndMinute = timeParser(now.toString(), "HH : mm");
    final String calendar = timeParser(now.toString(), "dd MMM, EEEE");
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CountriesCubit(ClockCountryData()),
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 240),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocBuilder<CountriesCubit, CountriesState>(
                  builder: (blocContext, state) {
                    if (state is CountriesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is CountriesCompleted) {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              Column(
                                children: List.generate(state.response.length, (index) {
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (blocContext) => SingleCountryView(
                                          countryName: state.response[index].toString(),
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Align(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 15, left: 15),
                                              child: Card(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                    state.response[index].toString().split("/").length > 1
                                                        ? state.response[index].toString().split("/")[0] +
                                                            ", " +
                                                            state.response[index].toString().split("/")[1]
                                                        : state.response[index].toString().split("/")[0],
                                                    style: Theme.of(context).textTheme.headline5,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.only(top: 15),
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context).appBarTheme.backgroundColor,
                                                border: Border.all(color: Theme.of(context).backgroundColor, width: 3),
                                              ),
                                              child: const Icon(Icons.chevron_right),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      final error = state as CountriesError;
                      return Text(error.message);
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        borderRadius:
                            const BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35))),
                    height: 220,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 193, left: 40, right: 40),
                    child: BlocConsumer<CountriesCubit, CountriesState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return TextField(
                          style: Theme.of(context).textTheme.headline6,
                          controller: controller,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(0),
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black.withOpacity(0.4),
                            ),
                            hintText: hintText,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onChanged: ((value) {
                            BlocProvider.of<CountriesCubit>(context).getSearchedCountryNames(value);
                          }),
                        );
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 60, right: 40, left: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  intTime < 12 ? goodMorning : goodDays,
                                  style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).buttonColor,
                                  ),
                                  child: IconButton(
                                    alignment: Alignment.center,
                                    onPressed: () {
                                      theme.changeTheme();
                                    },
                                    icon: Icon(
                                      !theme.isDark ? Icons.sunny : Icons.dark_mode_outlined,
                                      color: Theme.of(context).cardColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              hourAndMinute,
                              style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Row(children: [
                              Text(
                                calendar,
                                style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
