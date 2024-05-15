import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'task_edit_screen.dart';

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<Task> _tasks = [];
  List<int> _selectedIndexes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (_selectedIndexes.contains(index)) {
                  _selectedIndexes.remove(index);
                } else {
                  _selectedIndexes.add(index);
                }
              });
            },
            child: ListTile(
              selected: _selectedIndexes.contains(index),
              leading: Checkbox(
                value: _selectedIndexes.contains(index),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _selectedIndexes.add(index);
                    } else {
                      _selectedIndexes.remove(index);
                    }
                  });
                },
                checkColor: Colors.white,
              ),
              title: Text(_tasks[index].title),
              subtitle: Text(_tasks[index].description),
              trailing: _selectedIndexes.contains(index)
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editTask(context, index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteTask(index);
                          },
                        ),
                      ],
                    )
                  : null,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskEditScreen(
                onSave: _addTask,
                task: Task(title: ''), // Passing an empty string as title
              ),
            ),
          );
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTask(Task task) {
    setState(() {
      task.title = '${_tasks.length + 1}. ${task.title}';
      _tasks.add(task);
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _selectedIndexes.remove(index);
    });
  }

  void _editTask(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(
          onSave: (editedTask) {
            setState(() {
              _tasks[index] = editedTask;
            });
          },
          task: _tasks[index],
        ),
      ),
    );
  }
}
