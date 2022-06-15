class MessageDto {
  MessageDto({
    //required this.file,
    required this.message,
  });
  //late final File file;
  late final String message;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    //_data['file'] = file;
    _data['message'] = message;
    return _data;
  }
}
