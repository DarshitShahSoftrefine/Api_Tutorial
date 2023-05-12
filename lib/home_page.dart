import 'dart:convert';
import 'package:api_calling_tutorial/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserPost> samplePosts = [];
  bool onClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: onClick
            ? FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: samplePosts.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: ListTile(
                              minLeadingWidth: 10,
                              minVerticalPadding: 10,
                              contentPadding: const EdgeInsets.all(10),
                              tileColor: Colors.cyan,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1.0,
                                      color: Colors.grey)),
                              leading: Text(
                                "${samplePosts[index].id}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              title: Text(
                                samplePosts[index].title,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              subtitle: Text(
                                samplePosts[index].body,
                                maxLines: 1,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
            : Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      onClick = true;
                    });
                  },
                  child: const Text('Click to see the List of Users'),
                ),
              ));
  }

  Future<List<UserPost>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        samplePosts.add(UserPost.fromJson(index));
      }
      return samplePosts;
    } else {
      return samplePosts;
    }
  }
}
