import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplebloc/blocs/postbloc/postbloc.dart';
import 'package:simplebloc/blocs/postbloc/postevent.dart';
import 'package:simplebloc/blocs/postbloc/poststate.dart';
import 'package:simplebloc/data/model/postmodel.dart';
import 'package:simplebloc/data/repository/postrepository.dart';
import 'package:get/get.dart';
import './updatescreeen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 54, 94),
          title: const Text('Posts '),
          centerTitle: true,
        ),
        body: blocBody());
  }

  Widget blocBody() {
    return BlocProvider<PostBloc>(
      create: (context) => PostBloc(PostRepository())..add(LoadPostEvent()),
      child: BlocConsumer<PostBloc, PostState>(listener: (context, state) {
        if (state is ErrorPostState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      }, builder: (context, state) {
        if (state is LoadingPostState) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        } else if (state is LoadedPostState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: state.post.length,
                itemBuilder: (context, index) {
                  final post = state.post[index];
                  return GestureDetector(
                    onTap: () {
                      PostsModel postModel = PostsModel(
                          id: post.id,
                          title: post.title,
                          body: post.body,
                          userId: post.userId);
                      debugPrint(postModel.toJson().toString());
                      Get.to(() => UpdateScreen(
                            model: postModel,
                          ));
                    },
                    child: Card(
                      child: ListTile(
                        leading: Text(post.id.toString()),
                        title: Text(post.title.toString()),
                        subtitle: Text(post.body.toString()),
                        trailing: Text(post.userId.toString()),
                      ),
                    ),
                  );
                }),
          );
        }
        return const Center(
          child: Text('There is SomeThing Error'),
        );
      }),
    );
  }
}
