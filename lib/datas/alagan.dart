import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getlist/datas/product%205.dart';
import 'package:http/http.dart' as http;
class noo extends StatefulWidget {
  const noo({super.key});

  @override
  State<noo> createState() => _nooState();
}

class _nooState extends State<noo> {
  Future<List<Use>> fetch()async{
    var res = await http.get(Uri.parse('https://api.restful-api.dev/objects'));
    var data = jsonDecode(res.body);
    return(data as List).map((e)=> Use.fromJson(e)).toList();
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
                    List<Use> list = snapshot.data!;
                    return Container(
                      height: 100,
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index){
                            return ListTile(
                              title: Column(
                                children: [
                                  Text(list[index].id!.toString()),
                                  Text(list[index].name!.toString()),
                                  Text(list[index].data!.toString()),
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
