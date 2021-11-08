import 'package:mobx/mobx.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  final String title;

  _TodoStore(this.title);

  @observable
  bool done = false;

  @action
  void toggleDone() => done = !done;
}
