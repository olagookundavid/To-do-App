import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/providerclass.dart';

class AddTask extends StatelessWidget {
  final TextEditingController addTaskController;

  const AddTask({Key? key, required this.addTaskController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF757575),
      child: Container(
        padding:
            const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 40),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Add Task',
              style: TextStyle(fontSize: 20, color: Colors.lightBlueAccent),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              cursorColor: Colors.lightBlueAccent,
              cursorHeight: 25,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.5),
                ),
              ),
              controller: addTaskController,
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              child: Container(
                child: const Center(
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color: Colors.lightBlueAccent,
                height: 50,
                width: double.infinity,
              ),
              onTap: () async {
                Provider.of<ProviderClass>(context)
                    .addTask(addTaskController.text);
                addTaskController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('A new Task as been added!'),
                  ),
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
