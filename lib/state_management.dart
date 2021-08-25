abstract class StateManagement<T> {
  final _state = <T>[];
  final _listeners = <Function>[];

  List<T> get state => _state;

  void setState(T state) {
    _state.add(state);

    update(state);
  }

  void update(T state) {
    for (var listener in _listeners) {
      listener(state);
    }
  }

  void listen(void Function(T state) onUpdate) {
    _listeners.add(onUpdate);
  }
}
