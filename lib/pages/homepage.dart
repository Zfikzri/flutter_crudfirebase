import 'package:flutter/material.dart';
import 'package:flutter_firebase_database/controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.put(TodoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD FIREBASE"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: todoController.title,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter Title',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: todoController.content,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter Content',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    todoController.addTodo();
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [Text("ALL NOTES")],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(
                () => ListView(
                  children: todoController.todoList
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListTile(
                              tileColor: Colors.white,
                              onTap: () {},
                              title: Text(e.title ?? 'No Title'),
                              subtitle: Text(e.content ?? 'Content'),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (e.id != null)
                                      InkWell(
                                        onTap: () {
                                          todoController.deleteTodo(e.id!);
                                        },
                                        child: Icon(Icons.delete),
                                      ),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        todoController.updatedTitle.text =
                                            e.title!;
                                            todoController.updatedContent.text=e.content!;
                                        Get.defaultDialog(
                                          title: "UPDATE TODO",
                                          content: StatefulBuilder(
                                            builder: (BuildContext context,
                                                StateSetter setState) {
                                              return Container(
                                                height: 100,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            todoController
                                                                .updatedTitle,
                                                        decoration:
                                                            const InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            todoController
                                                                .updatedContent,
                                                        decoration:
                                                            const InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        todoController
                                                            .updateTodo(e);
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        height: 45,
                                                        width: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .deepPurple,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: const Icon(
                                                          Icons.done,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Icon(Icons.edit),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

