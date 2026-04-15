import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class Todo {
  final String id;
  final String title;
  final String text;

  Todo({
    required this.id,
    required this.title,
    required this.text,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<Todo> todos = [];

  void addTodo(String title, String text) {
    final todo = Todo(
      id: Random().nextInt(1000000).toString(),
      title: title,
      text: text,
    );

    setState(() {
      todos.add(todo);
    });
  }

  void deleteTodo(String id) {
    setState(() {
      todos.removeWhere((todo) => todo.id == id);
    });
  }

  void openAddTodoModal() {
    String title = '';
    String text = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Создание задачи"),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Название",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => title = value,
                ),

                const SizedBox(height: 12),

                TextField(
                  decoration: const InputDecoration(
                    labelText: "Текст задачи",
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  onChanged: (value) => text = value,
                  maxLines: 5,
                  minLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Отмена"),
            ),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  addTodo(title, text);
                }
                Navigator.pop(context);
              },
              child: const Text("Добавить"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),

      body: todos.isEmpty
          ? const Center(
              child: Text(
                "Задачи отсутствуют",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return Dismissible(
                  key: Key(todo.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: const Color.fromARGB(255, 255, 59, 49),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    deleteTodo(todo.id);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    child: ListTile(
                      title: Text(
                        todo.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                      subtitle: Text(todo.text),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Color.fromARGB(255, 238, 130, 122)),
                        onPressed: () => deleteTodo(todo.id),
                      ),
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: openAddTodoModal,
        icon: const Icon(Icons.add),
        label: const Text("Добавить задачу"),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }
}
