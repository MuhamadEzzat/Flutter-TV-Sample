class BooleanResult {
  bool isSuccess;
  ErrorResult? error;

  BooleanResult({this.isSuccess = false, this.error});

  BooleanResult.success() : isSuccess = true;

  BooleanResult.notSuccess() : isSuccess = false;

  BooleanResult.error(this.error) : isSuccess = false;

  BooleanResult.stringError(String error)
      : error = ErrorResult(errorMessage: error, errorCode: error),
        isSuccess = false;
}

class ErrorResult {
  String? errorCode;
  String? errorMessage;

  ErrorResult({this.errorCode, this.errorMessage});
}
