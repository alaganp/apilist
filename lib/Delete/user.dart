import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getlist/Delete/product4.dart';
import 'package:http/http.dart' as http;
class delete extends StatefulWidget {
  const delete({super.key});

  @override
  State<delete> createState() => _deleteState();
}

class _deleteState extends State<delete> {
  Future<List<Delete>> fetch() async{
    var res =await http.get(Uri.parse('https://fakestoreapi.com/carts'));
    var data = jsonDecode(res.body);
    return (data as List).map((e) => Delete.fromJson(e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext context, snapshot){
                if (snapshot.hasData){
                  List<Delete>list = snapshot.data!;
                  return Container(
                  height: 800,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index){
                      return ListTile(
                        title: Column(children: [
                          Text(list[index].id!.toString()),
                          Text(list[index].userId!.toString()),
                          Text(list[index].date!.toString()),
                          Text(list[index].products!.toString()),
                          Text(list[index].iV!.toString()),
                        ],
                        ),
                      );}
    )
                      );
                    } else if (snapshot.hasError){
                  return Text("${snapshot.error}");

    }return CircularProgressIndicator();}
                  ),




        ],
    ),
    );
  }
}
