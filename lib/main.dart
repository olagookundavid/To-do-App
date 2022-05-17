import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/providerclass.dart';
import 'taskscreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ProviderClass(),
      child: const MaterialApp(
        home: TasksScreen(),
      ),
    ),
  );
}



// style: TextStyle(
                        //   decoration: ischecked ? TextDecoration.lineThrough : null,
                        // ),