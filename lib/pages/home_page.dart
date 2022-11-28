import 'package:flutter/material.dart';
import 'package:idoc/model/post.dart';
import 'package:idoc/services/remote_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Datas"),
      ),
      body: Visibility(
      visible: isLoaded,
        replacement:  const Center(child: CircularProgressIndicator(),),
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return Text(posts![index].title);
          },
        ),
      ),
    );
  }
}
