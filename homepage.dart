//import 'dart:ffi';

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:fluttercocktail/drink_detail.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'package:fluttercocktail/homepage.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = Uri.parse(
      "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail");
  // ignore: prefer_typing_uninitialized_variables
  var res, drinks;
  //var myText = "India Wale!";
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    res = await http.get(url);
    //print(res.body);

    drinks = jsonDecode(res.body)["drinks"];
    print(drinks.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: Text("Cocktail App"),
        elevation: 0.0,
      ),
      body: Center(
        child: res != null
            ? ListView.builder(
                itemCount: drinks.length,
                itemBuilder: (context, index) {
                  var drink = drinks[index];
                  return ListTile(
                    leading: Hero(
                      tag: drink["idDrink"],
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(drink["strDrinkThumb"]),
                      ),
                    ),
                    title: Text(
                      "${drinks[index]["strDrink"]}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "${drinks[index]["idDrink"]}",
                      style: TextStyle(
                        //fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DrinkDetail(drink: drink),
                        ),
                      );
                    },
                  );
                },
              )
            : CircularProgressIndicator(backgroundColor: Colors.white),
      ),
    );
  }
}
