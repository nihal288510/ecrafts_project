import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  Api({Key? key}) : super(key: key);

  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  List<dynamic>? userData;

  Future<void> fetchUser() async {
    final response = await http.post(
      Uri.parse("https://demo.ezyerp.live/api/banners"),
      body: jsonEncode({
        'X-API-KEY': 'DemoApi123',
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API')),
      body: Column(
        children: [
          if (userData == null) Text('Please press the button to fetch data'),
          if (userData != null)
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: userData!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    textColor: Colors.cyan,
                    leading: Text(' ${userData![index]['id']}'),
                    title: Text(' ${userData![index]['title']}'),
                  );
                },
              ),
            ),
          ElevatedButton(
            onPressed: () {
              fetchUser();
            },
            child: Text('Press to Fetch Data'),
          ),
        ],
      ),
    );
  }
}
