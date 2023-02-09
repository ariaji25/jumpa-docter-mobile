class DataValueEntities {
  DataValueEntities({
    this.lastUpdated,
    this.created,
    this.dataElement,
    this.value,
    this.providedElsewhere,
  });

  DateTime? lastUpdated;
  DateTime? created;
  String? dataElement;
  String? value;
  bool? providedElsewhere;

}