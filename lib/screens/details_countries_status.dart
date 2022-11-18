import 'package:covid_19_tracker/screens/world_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsCountriesStatus extends StatefulWidget {

  String image;
  String name;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;

   DetailsCountriesStatus({
     required this.image,
     required this.name,
     required this.active,
     required this.critical,
     required this.test,
     required this.todayRecovered,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
});

  @override
  State<DetailsCountriesStatus> createState() => _DetailsCountriesStatusState();
}

class _DetailsCountriesStatusState extends State<DetailsCountriesStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding:  EdgeInsets.all(8.w),
                child: Card(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: NetworkImage(widget.image),
                      ),
                      ReuseableRow(title: "Total Cases", value: widget.totalCases.toString()),
                      ReuseableRow(title: "Total Recovered", value: widget.totalRecovered.toString()),
                      ReuseableRow(title: "Total Deaths", value: widget.totalDeaths.toString()),
                      ReuseableRow(title: "Critical", value: widget.critical.toString()),
                      ReuseableRow(title: "Active", value: widget.active.toString()),
                      ReuseableRow(title: "Test", value: widget.test.toString()),
                      ReuseableRow(title: "Today Recovered", value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
