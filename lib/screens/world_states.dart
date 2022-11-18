import 'dart:async';

import 'package:covid_19_tracker/model/world_states_model.dart';
import 'package:covid_19_tracker/screens/countries_list_screen.dart';
import 'package:covid_19_tracker/services/states_sevices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin{

  late final AnimationController _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  final colorList = <Color> [
    Color(0xff285430),
    Color(0xff00A8CC),
    Color(0xffC70D3A),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h, bottom: 15.h),
          child: Column(
              children: [
                SizedBox(height: 10.h,),

                FutureBuilder(
                    future: statesServices.fetchWorldStatesRecords(),
                    builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.w,
                        controller: _animationController,
                      ),
                    );
                  }else{
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total": double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered.toString()),
                            "Deaths": double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: 150.w,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                          animationDuration: Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.h),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseableRow(title: "Total", value: snapshot.data!.cases.toString()),
                                ReuseableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                ReuseableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                ReuseableRow(title: "Active", value: snapshot.data!.active.toString()),
                                ReuseableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                ReuseableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                                ReuseableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                                ReuseableRow(title: "Affected Countries", value: snapshot.data!.affectedCountries.toString()),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CountriesList()));
                          },
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            ),
                            child: Center(
                              child: Text("Track Countries"),
                            ),
                          ),
                        )
                      ],
                    );
                  }

                }),
            ],
          ),
          ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
   ReuseableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 3.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5.h,),
          Divider(),
        ],
      ),
    );
  }
}

