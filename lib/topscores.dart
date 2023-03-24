import 'package:shared_preferences/shared_preferences.dart';
import 'package:iie_space_station/globals.dart';

class Score implements Comparable<Score>{
  final String _initials;
  final int _score;
  Score (this._initials, this._score);

  String get initials {
    return _initials;
  }

  int get score {
    return _score;
  }

  //Sort in descending order
  @override
  int compareTo(Score other) {
    return other.score - score;
  }
}

class TopScores {
  final List<Score> _scores = [];
  int lowestScoreIndex = 0;

  List<Score> get scores {
    return _scores;
  }

  Future<int> getNumberOfScores() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt('count') ?? 0);
  }

  Future<void> setNumberOfScores(int count) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('count', count);
  }

  Future<int> getScore(int rank) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt('${rank}s') ?? 0);
  }

  Future<void> setScore(int rank, int score) async {
    final prefs = await SharedPreferences.getInstance();
    if (score < await getScore(lowestScoreIndex)){
      lowestScoreIndex = rank;
    }
    prefs.setInt('${rank}s', score);
  }

  Future<String> getInitials(int rank) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString('${rank}i') ?? '   ');
  }

  Future<void> setInitials(int rank, String initials) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('${rank}i', initials);
  }

  Future<void> loadScores() async {
    var count = await getNumberOfScores();
    for(var i =0; i<count; i++) {
      var initials = await getInitials(i);
      var score = await getScore(i);
      _scores.add(Score(initials,score));
    }
  }

  Future<void> saveScores() async {
    var len = _scores.length;

    _scores.sort();

    if (len > maxNumberScores) {
      len = maxNumberScores;
    }

    for (var i=0; i<len; i++) {
      await setInitials(i, _scores[i].initials);
      await setScore(i, _scores[i].score);
    }

    setNumberOfScores(len);
  }

  bool ifInTopScores(int score) {
    if (_scores.length < maxNumberScores) {
      return true;
    }
    else if (score > _scores[_scores.length-1].score){
      return true;
    }
    else {
      return false;
    }
  }

  Future<void> addNewScore(int newscore, String newinitials) async {
    _scores.add(Score(newinitials, newscore));
    _scores.sort();
    if (_scores.length > maxNumberScores) {
      _scores.removeRange(maxNumberScores, _scores.length);
    }
  }

  void printTheTopScores() {
    for (var score in _scores) {
      print('${score.initials} @ ${score.score}');
    }
  }
}

