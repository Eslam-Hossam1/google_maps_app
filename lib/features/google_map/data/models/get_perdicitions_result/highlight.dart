class Highlight {
  int? start;
  int? length;

  Highlight({this.start, this.length});

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
        start: json['start'] as int?,
        length: json['length'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'start': start,
        'length': length,
      };
}
