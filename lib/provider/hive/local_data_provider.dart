/// Local Data Provider Interface class
abstract class LocalDataProviderContract {
  Future delete(
    String table, {
    String? whereClauseValue,
    List<dynamic> whereClauseArgs = const [],
    List<String> keys = const [],
  }) async {}

  Future<void> insert(String table, Map<String, dynamic> values) async {}

  Future<Map<String, dynamic>> read(
    String table, {
    bool distinct,
    List<String> keys = const [],
    List<String> columns = const [],
    String whereClauseValue,
    List<dynamic> whereClauseArgs = const [],
    String groupBy,
    String having,
    String orderBy,
    int limit,
  });

  Future update(
    String table,
    Map<String, dynamic> values, {
    String? whereClauseValue,
    List<dynamic> whereClauseArgs = const [],
  }) async {}
}
