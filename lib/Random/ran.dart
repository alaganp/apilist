import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getlist/Random/product%205.dart';
import 'package:http/http.dart' as http;
class Random extends StatefulWidget {
  const Random({super.key});

  @override
  State<Random> createState() => _RandomState();
}

class _RandomState extends State<Random> {
  Future<List<One>> fetch()async{
    var res = await http.get(Uri.parse('https://randomuser.me/api/'));
    var data = jsonDecode(res.body);
    return(data as List).map((e)=> One.fromJson(e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            FutureBuilder(
                future: fetch(),
                builder: (BuildContext context, snapshot){
                  if(snapshot.hasData){
                    List<One> list = snapshot.data!;
                    return Container(
                      height: 800,
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index){
                            return ListTile(
                              title: Column(
                                children: [
                              Text(list[index].info!.toString()),
                                  Text(list[index].results!.toString()),
                                ],
                              ),
                            );
                          }
                      ),
                    );
                  } else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }
            )
          ],
        )
    );
  }
}
