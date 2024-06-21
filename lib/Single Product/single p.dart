import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getlist/Single%20Product/product%202.dart';
import 'package:http/http.dart' as http;
class singlep extends StatefulWidget {
  const singlep({super.key});

  @override
  State<singlep> createState() => _singlepState();
}

class _singlepState extends State<singlep> {
  Future<List<Single>> fetch() async{
    var res = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    var data = jsonDecode(res.body);
    return (data as List).map((e)=> Single.fromJson(e)).toList();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder(future: fetch(), builder:(
        BuildContext context,snapshot
        ){
          if(snapshot.hasData){
            List<Single>list = snapshot.data!;
            return Container(
              height: 800,
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    leading: Container(
                      height: 100,width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(list[index].image!),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                    title: Column(children: [
                      Text(list[index].id!.toString()),
                      Text(list[index].title!.toString()),
                      Text(list[index].price!.toString()),
                      Text(list[index].image!.toString()),
                      Text(list[index].category!.toString()),
                      Text(list[index].description!.toString()),
                      Text(list[index].rating!.toString()),

                    ],),
                  );
                }

              ),
            );

          }else if(snapshot.hasError){
            return Text("${snapshot.error}");

          }
          return CircularProgressIndicator();
        }
        )
      ],),
    );
  }
}
