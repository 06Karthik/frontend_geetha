class ErrorResponse {
  final String _timestamp;
  final String _status;
  final String _category;
  final String? _exception;
  final String _message;
  final String? _path;
  final String? _traceId;
  final String? _spanId;
  final InnerResponse? _causedBy;

  const ErrorResponse(
      this._timestamp,
      this._status,
      this._category,
      this._exception,
      this._message,
      this._path,
      this._traceId,
      this._spanId,
      this._causedBy,
      );

  ErrorResponse.fromError(Map<String, dynamic> input)
      : _timestamp = input["timestamp"].toString(),
        _status = input["status"].toString(),
        _category = input["category"].toString(),
        _exception = input["exception"].toString(),
        _message = input["message"].toString(),
        _path = input["path"].toString(),
        _traceId = input["traceId"].toString(),
        _spanId = input["spanId"].toString(),
        _causedBy = input['causedBy'] != null
            ? InnerResponse.fromJson(input['causedBy'])
            : null;

  ErrorResponse.fromMessage(String input)
      : _timestamp = DateTime.now().toIso8601String(),
        _status = "CPY",
        _category = "UI Internal Error",
        _message = input,
        _exception = null,
        _path = null,
        _traceId = null,
        _spanId = null,
        _causedBy = null;

  String get timestamp => _timestamp;
  String get status => _status;
  String get category => _category;
  String? get exception => _exception;
  String get message => _message;
  String? get path => _path;
  String? get traceId => _traceId;
  String? get spanId => _spanId;
  InnerResponse? get causedBy => _causedBy;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['causedBy'] = _causedBy?.toMap();
    map["timestamp"] = _timestamp;
    map["status"] = _status;
    map["category"] = _category;
    map["exception"] = _exception;
    map["message"] = _message;
    map["path"] = _path;
    map["traceId"] = _traceId;
    map["spanId"] = _spanId;
    map["causedBy"] = _causedBy;
    return map;
  }
}

class InnerResponse {
  final String _timestamp;
  final String _status;
  final String _category;
  final String? _exception;
  final String _message;
  final String? _path;
  final String? _traceId;
  final String? _spanId;

  const InnerResponse(
      this._timestamp,
      this._status,
      this._category,
      this._exception,
      this._message,
      this._path,
      this._traceId,
      this._spanId,
      );

  InnerResponse.fromJson(Map<String, dynamic> input)
      : _timestamp = input["timestamp"].toString(),
        _status = input["status"].toString(),
        _category = input["category"].toString(),
        _exception = input["exception"].toString(),
        _message = input["message"].toString(),
        _path = input["path"].toString(),
        _traceId = input["traceId"].toString(),
        _spanId = input["spanId"].toString();

  InnerResponse.fromMessage(String input)
      : _timestamp = DateTime.now().toIso8601String(),
        _status = "CPY",
        _category = "UI Internal Error",
        _message = input,
        _exception = null,
        _path = null,
        _traceId = null,
        _spanId = null;

  String get timestamp => _timestamp;
  String get status => _status;
  String get category => _category;
  String? get exception => _exception;
  String get message => _message;
  String? get path => _path;
  String? get traceId => _traceId;
  String? get spanId => _spanId;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["timestamp"] = _timestamp;
    map["status"] = _status;
    map["category"] = _category;
    map["exception"] = _exception;
    map["message"] = _message;
    map["path"] = _path;
    map["traceId"] = _traceId;
    map["spanId"] = _spanId;
    return map;
  }
}
