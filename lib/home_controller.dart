import 'shared/models/todo_item.dart';
import 'state_management.dart';

class HomeController extends StateManagement<ToDoItem> {
  void onRemoveItem(ToDoItem state) {
    super.state.remove(state);

    super.update(state);
  }

  void onAddItem(ToDoItem state) {
    super.state.add(state);

    super.update(state);
  }
}
