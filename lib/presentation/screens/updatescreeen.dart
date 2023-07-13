import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplebloc/blocs/updatebloc/updatebloc.dart';
import 'package:simplebloc/blocs/updatebloc/updateevent.dart';
import 'package:simplebloc/data/model/postmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../blocs/updatebloc/updatestate.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required this.model});

  final PostsModel model;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  int? userId;

  int? id;

  String? nbody;

  String? title;

  @override
  Widget build(BuildContext context) {
    final mdq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 54, 94),
        title: const Text('Update Screen'),
      ),
      body: BlocConsumer<UpdateBloc, UpdateState>(
        listener: (context, state) {
          if (state is UpdatedUploadedState) {
            Fluttertoast.showToast(msg: state.success.toString());
          }
          if (state is UpdateErrorState) {
            debugPrint(state.error.toString());
            Fluttertoast.showToast(msg: state.error.toString());
          }
        },
        builder: (context, state) {
          if (state is UpdateUploadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: [
              Form(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.model.id.toString(),
                      onChanged: (val) {
                        id = int.tryParse(val);
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      initialValue: widget.model.title,
                      onChanged: (val) {
                        title = val;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      initialValue: widget.model.body,
                      onChanged: (val) {
                        nbody = val;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      initialValue: widget.model.userId.toString(),
                      onChanged: (val) {
                        userId = int.tryParse(val);
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    SizedBox(
                      height: mdq.height * 0.1,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 5, 54, 94),
                            fixedSize: Size(mdq.width * 0.9, 50)),
                        onPressed: () {
                          // userId ??= widget.model.userId;
                          // id ??= widget.model.id;
                          // title ??= widget.model.title!;
                          // nbody ??= widget.model.body!;
                          // debugPrint(nbody);

                          PostsModel pm = PostsModel(
                              id: id,
                              userId: userId,
                              title: title,
                              body: nbody);

                          debugPrint(pm.toJson().toString());

                          BlocProvider.of<UpdateBloc>(context)
                              .add(UpdatePressedEvent(postId: widget.model.id));
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}
