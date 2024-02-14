import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class New extends StatefulWidget {
  const New({super.key});

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  var user;
  Future<dynamic> users() async {
    final responce = await http.post(
      Uri.parse('https://demo.ezyerp.live/api/banners'),
      body: jsonEncode({
        'X-API-KEY': 'DemoApi123',
      }),
    );
    user = jsonDecode(responce.body);

    setState(() {
      return user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.cyan),
            child: Row(children: [
              Icon(Icons.location_pin),
              Text('calicut'),
              SizedBox(width: 10),
              Icon(Icons.arrow_drop_down)
            ]),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 20),
            ),
            Icon(Icons.person_2)
          ],
        ),
        Text(
          'how you feeling today',
          style: const TextStyle(fontSize: 10),
        ),
        Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber[50]),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('serach'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  )
                ])),
        InkWell(
          onTap: () {
            setState(() {
              users();
            });
          },
          child: Column(
            children: [
              if (user == null) Text('pleace enter the button'),
              if (user != null)
                Container(
                  child: Text(user['msg']),
                  width: double.infinity,
                  height: 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                ),
            ],
          ),
        )
      ]),
    );
  }
}
