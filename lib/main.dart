import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'google_sheets_api.dart';
import 'homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  runApp(MainMenuApp());
}

class MainMenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Menu',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MainMenuPage(),
    );
  }
}

class MainMenuPage extends StatefulWidget {
  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  String _currentDate = '';
  String _selectedFeeling = '';

  @override
  void initState() {
    super.initState();
    _getCurrentDate();
  }

  void _getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, MMMM d, yyyy');
    final formattedDate = formatter.format(now);
    setState(() {
      _currentDate = formattedDate;
    });
  }

  void _selectFeeling(String feeling) {
    setState(() {
      _selectedFeeling = feeling;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {
        //     // Perform the desired action when the back button is pressed
        //   },
        //
        // ),
        title: Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              _currentDate,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 32),
            Text(
              'How are you feeling?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FeelingButton(
                  text: '😢',
                  isSelected: _selectedFeeling == 'Sad',
                  //onPressed: () => _selectFeeling('Sad'),
                  ///////////////////////////////////////////////////////////////////////
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color(0xfffff203),
                            title: Text("Do not let what you cannot do interfere with what you can do 🎠 "),
                            // content: TextField(
                            //   decoration: InputDecoration(hintText: "Notes"),
                            // ),
                          );
                        }
                    );
                  }
                  ////////////////////////////////////////////////////////////////////
                ),
                SizedBox(width: 16),
                FeelingButton(
                  text: '😎',
                  isSelected: _selectedFeeling == 'Happy',
                  //onPressed: () => _selectFeeling('Happy'),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Color(0xfffff203),
                              title: Text("Happiness is a warm puppy 😎 "),
                              // content: TextField(
                              //   decoration: InputDecoration(hintText: "Notes"),
                              // ),
                            );
                          }
                      );
                    }
                ),
                SizedBox(width: 16),
                FeelingButton(
                  text: '😠',
                  isSelected: _selectedFeeling == 'Angry',
                  //onPressed: () => _selectFeeling('Angry'),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Color(0xfffff203),
                              title: Text("For every minute you are angry you lose sixty seconds of happiness 😫 "),
                              // content: TextField(
                              //   decoration: InputDecoration(hintText: "Notes"),
                              // ),
                            );
                          }
                      );
                    }
                ),
              ],
            ),
            SizedBox(height: 32, width: 60),
            ElevatedButton(
              onPressed: () {
                // Perform action for Button 1
                print('Button 1 pressed');
                Navigator.push(context, MaterialPageRoute(builder: (_) => todoApp(),),);
              },
              child: Text('To do',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)
              ),

            ),
            SizedBox(height: 32, width: 60),
            ElevatedButton(
              onPressed: () {
                // Perform action for Button 2
                print('Button 2 pressed');
                Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp(),),);
              },
              child: Text('Notes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)
            ),
            ),
            SizedBox(height: 32, width: 60),
            ElevatedButton(
              onPressed: () {
                // Perform action for Button 3
                print('Button 3 pressed');
                print('Selected feeling: $_selectedFeeling');
                Navigator.push(context, MaterialPageRoute(builder: (_) => financeApp(),),);
              },
              child: Text('Finance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeelingButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const FeelingButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.yellow : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xfffff203),
        scaffoldBackgroundColor: Color(0xffffffff),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String input = " ";
  List<String> notes = [];
  List<String> editednotes = [];

  @override
  void initState() {
    // notes.add("Cycling");
    // notes.add("Add");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "NOTES",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontStyle: FontStyle.italic,
              letterSpacing: 4,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back , color: Colors.black,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => MainMenuApp(),),);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.yellow[500],
            size: 35,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Color(0xfffff203),
                  title: Text("Add notes"),
                  content: TextField(
                    decoration: InputDecoration(hintText: "Notes"),
                    onChanged: (String value) {
                      setState(() {
                        input = value;
                      });
                    },
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          notes.add(input);
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "ADD",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(notes[index]),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        editednotes.add(notes[index]); // Add the original todo to the edited list
                        String displaynotes = notes[index]; // Display the original todo in the dialog
                        return AlertDialog(
                          backgroundColor: Color(0xfffff203),
                          title: Text("Edit notes"),
                          content: TextField(
                            decoration: InputDecoration(hintText: "Notes"),
                            onChanged: (String value) {
                              setState(() {
                                editednotes[index] = value; // Update edited notes
                              });
                            },
                            controller: TextEditingController(text: displaynotes),
                          ),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "CANCEL",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  notes[index] = editednotes[index]; // Update original notes with edited version
                                  editednotes.removeAt(index); // Remove the edited notes from the list
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "SAVE",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      title: Text(
                        notes[index],
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.yellow,
                        ),
                        onPressed: () {
                          setState(() {
                            notes.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  _removenotes(index);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _removenotes(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }
}

//////////////////////////////////////////////////////////////

class todoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListScreen(),

    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> todoItems = [];
  List<String> categories = ['Personal', 'Work', 'Shopping', 'Others'];
  String selectedCategory = 'All';

  String todoValue = '';
  DateTime? dueDate;
  String selectedCategoryFilter = 'All';

  final TextEditingController _textEditingController = TextEditingController();

  void addTodoItem(String todo, DateTime? dueDate, IconData icon, String category) {
    setState(() {
      todoItems.add(TodoItem(todo, dueDate, icon, category, completed: false));
    });
  }

  void removeTodoItem(TodoItem todoItem) {
    setState(() {
      todoItems.remove(todoItem);
    });
  }

  void editTodoItem(TodoItem oldTodoItem, TodoItem newTodoItem) {
    setState(() {
      final index = todoItems.indexOf(oldTodoItem);
      if (index != -1) {
        todoItems[index] = newTodoItem;
      }
    });
  }

  void filterTodoItems(String category) {
    setState(() {
      selectedCategoryFilter = category;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<TodoItem> filteredTodoItems = todoItems;
    if (selectedCategoryFilter != 'All') {
      filteredTodoItems =
          todoItems.where((todoItem) => todoItem.category == selectedCategoryFilter).toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back , color: Colors.black,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MainMenuApp(),),);
          },
        ),

        title: Text(
          'To-Do List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.black,// Sini Part kalau nak tukar colour header TODOLIST
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Category:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  items: [...categories, 'All']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Filter By Category'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text('All'),
                                leading: Radio<String>(
                                  value: 'All',
                                  groupValue: selectedCategoryFilter,
                                  onChanged: (value) {
                                    filterTodoItems(value!);
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              ...categories.map((category) {
                                return ListTile(
                                  title: Text(category),
                                  leading: Radio<String>(
                                    value: category,
                                    groupValue: selectedCategoryFilter,
                                    onChanged: (value) {
                                      filterTodoItems(value!);
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text('Filter'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTodoItems.length,
              itemBuilder: (context, index) {
                final todoItem = filteredTodoItems[index];
                return ListTile(
                  title: Text(
                    todoItem.todo,
                    style: TextStyle(
                      color: todoItem.completed ? Colors.green : null,  // Kalau dh complete kt sini berubah hijau
                      decoration: todoItem.completed ? TextDecoration.lineThrough : null, //staright line
                    ),
                  ),
                  subtitle: Text(
                    'Due: ${_formatDate(todoItem.dueDate)}',
                    style: TextStyle(
                      color: todoItem.completed ? Colors.green : null, //
                      decoration: todoItem.completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  leading: Icon(
                    todoItem.icon,
                    color: todoItem.completed ? Colors.lightGreen : null, //icon tick sebelah taskk todolist
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: todoItem.completed,
                        onChanged: (value) {
                          setState(() {
                            todoItem.completed = value!;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.orange[900]),
                        onPressed: () {
                          _editTodoItem(context, todoItem);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.blueGrey),
                        onPressed: () {
                          removeTodoItem(todoItem);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'New To-Do',
                labelStyle: TextStyle(color: Colors.indigo[400]),
                hintStyle: TextStyle(color: Colors.blue),
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  todoValue = value;
                });
              },
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.indigoAccent,
                ),
                Text(
                  'Due Date:',
                  style: TextStyle(
                    color: Colors.indigo[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        dueDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    dueDate != null ? _formatDate(dueDate) : 'Select Due Date',
                    style: TextStyle(
                      color: Colors.indigoAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                ////////////////////////////////////////////////////
                // floatingActionButton: FloatingActionButton(
                //   backgroundColor: Colors.black,
                //   child: Icon(
                //     Icons.add,
                //     color: Colors.yellow[500],
                //     size: 35,
                //   ),
                //   onPressed: () {
                //     if (todoValue.isNotEmpty && dueDate != null) {
                //       addTodoItem(todoValue, dueDate, Icons.check_circle,
                //           selectedCategory);
                //       setState(() {
                //         _textEditingController.clear();
                //         todoValue = '';
                //         dueDate = null;
                //       })
                //     }
                //   },
                // ),
                ///////////////////////////////////////////////////////
                IconButton(
                  icon: Icon(Icons.add,
                    color: Colors.yellow[500],
                    size: 35,
                  ),
                  color: Colors.black,
                  iconSize: 45,
                  onPressed: () {
                    if (todoValue.isNotEmpty && dueDate != null) {
                      addTodoItem(todoValue, dueDate, Icons.check_circle, selectedCategory);
                      setState(() {
                        _textEditingController.clear();
                        todoValue = '';
                        dueDate = null;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      return '${date.day}/${date.month}/${date.year}';
    }
    return 'No Due Date';
  }

  Future<void> _editTodoItem(BuildContext context, TodoItem todoItem) async {
    String editedTodoValue = todoItem.todo;
    DateTime? editedDueDate = todoItem.dueDate;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Todo Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: todoItem.todo),
                onChanged: (value) {
                  editedTodoValue = value;
                },
                decoration: InputDecoration(labelText: 'Todo'),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: editedDueDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      editedDueDate = pickedDate;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 8),
                    Text(
                      'Due Date: ${_formatDate(editedDueDate)}',
                      style: TextStyle(
                        color: Colors.indigo[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                final newTodoItem = TodoItem(
                  editedTodoValue,
                  editedDueDate,
                  todoItem.icon,
                  todoItem.category,
                  completed: todoItem.completed,
                );
                editTodoItem(todoItem, newTodoItem);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class TodoItem {
  final String todo;
  final DateTime? dueDate;
  final IconData icon;
  final String category;
  bool completed;

  TodoItem(this.todo, this.dueDate, this.icon, this.category, {this.completed = false});
}

///////////////////////////////////////////////////////////////

class financeApp extends StatelessWidget {
  const financeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}