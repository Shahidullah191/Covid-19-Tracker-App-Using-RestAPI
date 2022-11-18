import 'package:covid_19_tracker/screens/details_countries_status.dart';
import 'package:covid_19_tracker/services/states_sevices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    hintText: "Search with Country Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                    )),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.fetchCountriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: 10.h,
                                      width: 90.w,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10.h,
                                      width: 90.w,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 50.h,
                                      width: 50.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                          );

                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name =snapshot.data![index]["country"];

                          if(searchController.text.isEmpty){
                            return Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailsCountriesStatus(

                                        image: snapshot.data![index]["countryInfo"]["flag"],
                                        name: snapshot.data![index]["country"],
                                        totalCases: snapshot.data![index]["cases"],
                                        totalRecovered: snapshot.data![index]["recovered"],
                                        totalDeaths: snapshot.data![index]["deaths"],
                                        active: snapshot.data![index]["active"],
                                        test: snapshot.data![index]["tests"],
                                        todayRecovered: snapshot.data![index]["todayRecovered"],
                                        critical: snapshot.data![index]["critical"],
                                      )));
                                    },
                                    child: Card(
                                      child: ListTile(
                                        title: Text(snapshot.data![index]["country"]),
                                        subtitle: Text(snapshot.data![index]["cases"].toString()),
                                        leading: Image(
                                          height: 50.h,
                                          width: 50.w,
                                          image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"]),),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailsCountriesStatus(

                                        image: snapshot.data![index]["countryInfo"]["flag"],
                                        name: snapshot.data![index]["country"],
                                        totalCases: snapshot.data![index]["cases"],
                                        totalRecovered: snapshot.data![index]["recovered"],
                                        totalDeaths: snapshot.data![index]["deaths"],
                                        active: snapshot.data![index]["active"],
                                        test: snapshot.data![index]["tests"],
                                        todayRecovered: snapshot.data![index]["todayRecovered"],
                                        critical: snapshot.data![index]["critical"],
                                      )));
                                    },
                                    child: Card(
                                      child: ListTile(
                                        title: Text(snapshot.data![index]["country"]),
                                        subtitle: Text(snapshot.data![index]["cases"].toString()),
                                        leading: Image(
                                          height: 50.h,
                                          width: 50.w,
                                          image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"]),),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }else{
                            return Container();
                          }


                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
