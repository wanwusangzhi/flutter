class Movie {
  int count;
  int start;
  int total;
  List subjects;

  Movie(this.count, this.start, this.total, this.subjects);

  Movie.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    start = json['start'];
    total = json['total'];
    subjects = json['subjects'];
  }
  Map<String, dynamic> toJson() {
    return {
      "count": count,
      "start": start,
      "total": total,
      "subjects": subjects
    };
  }
}
