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

  late SelectedCountryCubit _selectedCountryCubit;
  @override
  void dispose() {
    _selectedCountryCubit.cancelTimer();
    _selectedCountryCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _selectedCountryCubit = SelectedCountryCubit(widget.countryName, SelectedCountryData());

    return BlocProvider(
      create: (context) => _selectedCountryCubit,
      child: scaffold(),
    );
  }

  Scaffold scaffold() {
    String title = "WORLD TIME";
    return Scaffold(
      appBar: appBarWidget(title),
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
            return clockBody(state, context);
          } else {
            final error = state as SelectedCountryError;
            return Text(error.message);
          }
        },
      ),
    );
  }

  Center clockBody(SelectedCountryCompleted state, BuildContext context) {
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
                  state.response!.datetime.toString().substring(11, 13),
                  style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 65, fontWeight: FontWeight.w700),
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
                child: Text(":", style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w800)),
              ),
              Container(
                alignment: Alignment.center,
                height: 150,
                width: 150,
                child: Text(
                  state.response!.datetime.toString().substring(14, 16),
                  style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 65, fontWeight: FontWeight.w700),
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
                timeParser(state.response!.datetime.toString(), "EEEE") +
                    ", GMT " +
                    state.response!.utcOffset.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                timeParser(state.response!.datetime.toString(), "MMM dd, yyyy"),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSize appBarWidget(String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
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
            title,
            style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
