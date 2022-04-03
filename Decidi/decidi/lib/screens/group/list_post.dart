import 'package:decidi/providers/DataProvider.dart';

import 'package:decidi/screens/group/add_post.dart';
import 'package:decidi/screens/group/message_list.dart';
import 'package:decidi/theme/color.dart';

import 'package:decidi/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  const PostList(this.name);
  final String name;
  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  void initState() {
    super.initState();

    Provider.of<DataProvider>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<DataProvider>(context).listPost;
    final user = Provider.of<DataProvider>(context, listen: false).user;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            widget.name,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 2.0,
          shadowColor: shadowColor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => MessageList(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.message_outlined,
                  color: Colors.black,
                ))
          ],
        ),
        floatingActionButton: user.role == "coach"
            ? FloatingActionButton(
                child: Icon(
                  Icons.add,
                ),
                backgroundColor: primary,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => AddPost(),
                    ),
                  );
                },
              )
            : null,
        floatingActionButtonLocation: user.role == "coach"
            ? FloatingActionButtonLocation.centerFloat
            : null,
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostItem(
              posts[index].postId,
              posts[index].description,
              posts[index].like,
            );
          },
        ));
  }
}
