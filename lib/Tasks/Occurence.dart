class Occurence {
  List<int> daysPerWeek;
  List<DateTime> time;
  bool repeats = false;

  Occurence(daysPerWeek, time, repeats) {
    this.daysPerWeek = daysPerWeek;
    this.time = time;
    this.repeats = repeats;
  }
}