class FlowSaved {
  String savedID;
  String savedDescription;
  String savedDistance;
  bool savedFlowing;
  String savedTypeTap;
  //bool savedisSaved;

  FlowSaved({
    this.savedID,
    this.savedDescription,
    this.savedDistance,
    this.savedFlowing,
    this.savedTypeTap,
    // this.savedisSaved,
  });

  ///convert from map to flowSaved object
  FlowSaved.fromMap(Map map)
      : this.savedID = map[
            'ID'], // assigning ths SavedID from the constructor to the 'ID' property/Variable of our map
        this.savedDescription = map['Description'],
        this.savedDistance = map['Distance'],
        this.savedFlowing = map['Flowing'],
        this.savedTypeTap = map['TypeTap'];
  //  this.savedisSaved = map['isSaved'];

  ///convert from flowSaved Object to a map
  Map toMap() {
    return {
      'ID': this.savedID,
      'Description': this.savedDescription,
      'Distance': this.savedDistance,
      'Flowing': this.savedFlowing,
      'TypeTap': this.savedTypeTap,
      // 'isSaved': this.savedisSaved,
    };
  }
}
