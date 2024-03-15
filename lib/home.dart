//ignore_for_file: prefer_const_constructors
//ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wire/constants/api.dart';
import 'package:wire/list_of_characters.dart';
import 'package:wire/models/character.dart';
import 'package:wire/services/http.service.dart';
import 'package:wire/tab_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Character> listOfCharacters = [];

  /*bool isTab(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width >= 600;
  }*/

  getCharacters() async {
    Response response = await HttpService.get(Api.baseUrl);
    Map apiResult = jsonDecode(response.data);
    List relatedTopics = apiResult["RelatedTopics"];
    listOfCharacters =
        relatedTopics.map((element) => Character.fromJson(element)).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: listOfCharacters.isEmpty
              ? Center(child: CircularProgressIndicator())
              : LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth >= 600) {
                    return TabView(
                      characters: listOfCharacters,
                    );
                  } else {
                    return ListOfCharacters(
                      characters: listOfCharacters,
                    );
                  }
                })),
    );
  }
}
