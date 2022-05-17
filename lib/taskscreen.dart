import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/providerclass.dart';
import 'addtask.dart';
// import 'database.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // List<Map<String, dynamic>> _notes = [];
  late final TextEditingController _notesController;

  get kcontainerdeco => null;

  // This function is used to fetch all data from the database
  // void _refreshNotes() async {
  //   final data = await SQLHelper.getItems();
  //   setState(() {
  //     _notes = data;
  //   });
  // }

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
                        await Provider.of<ProviderClass>(context)
                            .deleteAllTasks();
                        // _refreshNotes();
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
                        title: Text(notes.note[index]['title']),
                        trailing: const Checkbox(
                          activeColor: Colors.lightBlueAccent,
                          // value: ischecked,
                          value: false, onChanged: null,
                        ),
                        onLongPress: () async {
                          await notes.deleteTask(notes.note[index]['id']);
                          // SQLHelper.deleteItem(_notes[index]['id']);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Successfully deleted the To_Do!'),
                          ));
                          // _refreshNotes();
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
          // _refreshNotes();
        },
      ),
    );
  }
}
