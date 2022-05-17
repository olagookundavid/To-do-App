import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/providerclass.dart';
import 'addtask.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late final TextEditingController _notesController;

  get kcontainerdeco => null;

  @override
  void initState() {
    _notesController = TextEditingController();
    super.initState();
    Provider.of<ProviderClass>(context, listen: false).refreshNotes();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(35, 60, 60, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 30,
                    color: Colors.lightBlueAccent,
                  ),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'ToDo',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      ' ${Provider.of<ProviderClass>(context).notecount} Tasks',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () async {
                        await Provider.of<ProviderClass>(context, listen: false)
                            .deleteAllTasks();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('All Tasks have been deleted!'),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child:
                    Consumer<ProviderClass>(builder: (context, notes, child) {
                  return ListView.builder(
                    itemCount: notes.notecount,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          notes.note[index]['title'],
                          style: TextStyle(
                            decoration: notes.isChecked
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: Checkbox(
                          activeColor: Colors.lightBlueAccent,
                          value: notes.isChecked,
                          onChanged: (value) {
                            notes.changeIsChecked();
                          },
                        ),
                        onLongPress: () async {
                          await notes.deleteTask(notes.note[index]['id']);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Successfully deleted the Task!'),
                          ));
                        },
                      );
                    },
                  );
                }),
                decoration: kcontainerdeco),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.add),
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            builder: (context) => AddTask(addTaskController: _notesController),
          );
        },
      ),
    );
  }
}
