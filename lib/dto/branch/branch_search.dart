class BranchSearch {
  bool? hasRoom;

  BranchSearch({
    this.hasRoom,
  });

  Map<String, dynamic> toJson()  {
    final Map<String, dynamic> data = {};
    if(hasRoom != null) {
      data['hasRoom'] = hasRoom;
    }
    return data;
  }
}