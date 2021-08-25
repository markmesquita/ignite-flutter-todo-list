import 'package:flutter/material.dart';
import 'builder_widget.dart';
import 'home_controller.dart';

import 'screens/done_screen.dart';
import 'screens/task_screen.dart';
import 'shared/models/todo_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _toDoItemController = HomeController();
  final _doneDoItemController = HomeController();

  final _pageViewController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  var _selectedIndex = 0;

  void onAddItem(String itemTitle) {
    _toDoItemController.onAddItem(ToDoItem(title: itemTitle));
  }

  void onResetItem(ToDoItem item) {
    _doneDoItemController.onRemoveItem(item);

    _toDoItemController.onAddItem(ToDoItem(
      title: item.title,
    ));
  }

  void onRemoveToDoItem(ToDoItem item) {
    _toDoItemController.onRemoveItem(item);
  }

  void onRemoveDoneItem(ToDoItem item) {
    _doneDoItemController.onRemoveItem(item);
  }

  void onCompleteItem(ToDoItem item) {
    _toDoItemController.onRemoveItem(item);

    _doneDoItemController.onAddItem(
      ToDoItem(
        title: item.title,
        isDone: true,
      ),
    );
  }

  // @override
  // void dispose() {
  //   _pageViewController.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: <Widget>[
          BuilderWidget<ToDoItem>(
              controller: _toDoItemController,
              builder: (context, state) {
                return TaskScreen(
                  itemList: state,
                  onAddItem: onAddItem,
                  onCompleteItem: onCompleteItem,
                  onRemoveItem: onRemoveToDoItem,
                );
              }),
          BuilderWidget<ToDoItem>(
              controller: _doneDoItemController,
              builder: (context, state) {
                return DoneScreen(
                  itemList: state,
                  onRemoveItem: onRemoveDoneItem,
                  onResetItem: onResetItem,
                );
              }),
        ],
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);

          _pageViewController.animateToPage(
            _selectedIndex,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeOut,
          );
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            label: 'Pendentes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Concluídas',
          ),
        ],
      ),
    );
  }
}
