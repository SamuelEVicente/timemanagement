import '../Tasks/Task.dart';

class User {
  List<Task> tasks = [];

  void createTask(
      String name, List<int> daysPerWeek, List<DateTime> time, bool repeats) {
    if (this.getTaskByName(name) == null) {
      this.tasks.add(new Task(name));
    }
    Task theTask = this.getTaskByName(name);
    theTask.addTaskOccurence(daysPerWeek, time, repeats);
  }

  Task getTaskByName(name) {
    if (this.tasks == null) {
      return null;
    }
    for (Task task in this.tasks) {
      if (name == task.name) {
        return task;
      }
    }
    return null;
  }
}
