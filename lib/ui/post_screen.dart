import 'package:bloc_testing/bloc/post/post_bloc.dart';
import 'package:bloc_testing/bloc/post/post_event.dart';
import 'package:bloc_testing/bloc/post/post_state.dart';
import 'package:bloc_testing/model/post_comments_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    context.read<PostBloc>().add(FetchDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text(
          "Api Fetch Method",
        ),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.postStatus == PostStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.postStatus == PostStatus.success) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: state.commentsList?.length,
                itemBuilder: (context, index) {
                  CommentsModel item = state.commentsList![index];
                  return Card(
                      child: ListTile(
                    title: Text(
                      item.name!.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    subtitle: Text(
                      item.body!,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ));
                },
              ),
            );
          } else if (state.postStatus == PostStatus.failure) {
            return const Center(child: Text("There was an error loading data"));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
