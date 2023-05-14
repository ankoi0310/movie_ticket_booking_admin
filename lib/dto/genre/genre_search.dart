class GenreSearch {
  String? name;

  GenreSearch({
    this.name,
  });

  GenreSearch.empty() : name = null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (name != null) {
      data['name'] = name;
    }

    return data;
  }
}
