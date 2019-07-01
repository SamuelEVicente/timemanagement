import 'Occurence.dart';

class Task {
  String name;
  List<Occurence> occurences;

  Task(String name) {
    this.name = name;
    occurences = [];
  }

  String get nameOfTask {
    return name;
  }

  set nameOfTask(String nameOfTask) {
    this.name = nameOfTask;
  }

  void removeOccurrenceByDay(int day) {
    for (Occurence occurs in this.occurences) {
      if (occurs.daysPerWeek.contains(day)) {
        occurs.daysPerWeek.remove(day);
      }
    }
  }

  void addTaskOccurence(
      List<int> daysPerWeek, List<DateTime> time, bool repeats) {
    for (Occurence occurs in this.occurences) {
      // check whether this new occurence collides with an already existing occurence
      // and if it does not then add the new one to the list
      // otherwise some error message should be displayed
    }
    this.occurences.add(new Occurence(daysPerWeek, time, repeats));
  }
}
