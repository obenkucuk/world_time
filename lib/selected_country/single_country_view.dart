import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import 'package:world_time/selected_country/cubit/selected_country_cubit.dart';
import 'package:world_time/selected_country/selected_country_data.dart';

class SingleCountryView extends StatefulWidget {
  final String countryName;
  SingleCountryView({Key? key, required this.countryName}) : super(key: key);

  @override
  State<SingleCountryView> createState() => _SingleCountryViewState();
}

class _SingleCountryViewState extends State<SingleCountryView> {
  String timeParser(String dateTimeString, String hourOrMinute) {
    final dateTime = DateTime.parse(dateTimeString);

    final format = DateFormat(hourOrMinute);
    final clockString = format.format(dateTime);

    return clockString;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectedCountryCubit(widget.countryName, SelectedCountryData()),
      child: scaffold(),
    );
  }

  Scaffold scaffold() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          leading: Transform(
            transform: Matrix4.translationValues(20.0, 20.0, 20.0),
            child: IconButton(
              enableFeedback: false,
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).buttonColor,
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          centerTitle: true,
          titleSpacing: 0.0,
          title: Transform(
            // you can forcefully translate values left side using Transform
            transform: Matrix4.translationValues(-20.0, 20.0, 0.0),
            child: Text(
              "WORLD TIME",
              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
      body: BlocConsumer<SelectedCountryCubit, SelectedCountryState>(
        listener: (context, state) {
          if (state is SelectedCountryError) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is SelectedCountryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SelectedCountryCompleted) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          timeParser(state.response!.datetime.toString(), "HH"),
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontSize: 65, fontWeight: FontWeight.w700),
                        ),
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          border: Border.all(color: Theme.of(context).hoverColor, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 25,
                        child: Text(":",
                            style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w800)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        child: Text(
                          timeParser(state.response!.datetime.toString(), "mm"),
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontSize: 65, fontWeight: FontWeight.w700),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          border: Border.all(color: Theme.of(context).hoverColor, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    state.response!.timezone.toString().split("/")[1],
                    style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.response!.timezone.toString().split("/")[0],
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timeParser(state.response!.datetime.toString(), "EEEE") + ", GMT ",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        state.response!.utcOffset.toString(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timeParser(state.response!.datetime.toString(), "MMM "),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        timeParser(state.response!.datetime.toString(), "dd, "),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        timeParser(state.response!.datetime.toString(), "yyyy"),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            final error = state as SelectedCountryError;
            return Text(error.message);
          }
        },
      ),
    );
  }
}
