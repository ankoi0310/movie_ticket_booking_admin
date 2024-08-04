abstract class LocalDataProviderContract {
  Future delete({
    required String table,
    String? whereClauseValue,
    List<dynamic> whereClauseArgs = const [],
    List<String> keys = const [],
  }) async {}

Future<void> insert({
    required String table,
    required Map<String, dynamic> values,
  }) async {}

Future<Map<String, dynamic>> read({
    required String table,
    bool distinct = false,
    List<String> keys = const [],
    List<String> columns = const [],
    String? whereClauseValue,
    List<dynamic> whereClauseArgs = const [],
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
  });

  Future update({
    required String table,
    required Map<String, dynamic> values,
    String? whereClauseValue,
    List<dynamic> whereClauseArgs = const [],
  }) async {}

}