import 'package:equatable/equatable.dart';

class ErrorResponseModel extends Equatable {
  const ErrorResponseModel({required this.msg});

  final String msg;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      msg: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = <String, dynamic>{};
    _data['message'] = msg;

    return _data;
  }

  @override
  List<Object?> get props => [msg];
}
