enum ServiceMessage {
  getDataError(1, 'Get Data Error'),
  sendDataError(1, 'Send Data Error'),
  getDataSuccess(1, 'Get Data Success'),
  sendDataSuccess(1, 'Send Data Success'),
  unExpectedError(1, 'Unexpected error');

  final int code;
  final String message;
  const ServiceMessage(this.code, this.message);
}
