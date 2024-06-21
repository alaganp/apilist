import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getlist/category/product3.dart';
import 'package:http/http.dart' as http;
class one extends StatefulWidget {
  const one({super.key});

  @override
  State<one> createState() => _oneState();
}

class _oneState extends State<one> {
  Future<List<Get>>fetch()async{
    var res = await http.get(Uri.parse('https://fakestoreapi.com/products/7'));
    var data = jsonDecode(res.body);
    return(data as List).map((e)=> Get.fromJson(e)).toList();
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
                    List<Get> list = snapshot.data!;
                    return Container(
                      height: 800,
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index){
                            return ListTile(
                              leading: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(list[index].image!),fit: BoxFit.fill
                                  ),
                                ),
                              ),
                              title: Column(
                                children: [
                                  Text(list[index].id!.toString()),
                                  Text(list[index].title!.toString()),
                                  Text(list[index].category!.toString()),
                                  Text(list[index].description!.toString()),
                                  Text(list[index].price!.toString()),
                                  Text(list[index].rating!.count.toString()),
                                  Text(list[index].rating!.rate.toString()),
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
