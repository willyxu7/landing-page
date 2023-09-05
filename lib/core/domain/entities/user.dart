import 'package:equatable/equatable.dart';

class User extends Equatable {
  String? _id;
  late String _name, _email, _phoneNumber, _city;

  // User(this._name, this._email, this._phoneNumber, this._city);

  @override
  List<Object?> get props => [_id, _name, _email, _phoneNumber, _city];

  get city => _city;

  set city(value) {
    _city = value;
  }

  get phoneNumber => _phoneNumber;

  set phoneNumber(value) {
    _phoneNumber = value;
  }

  get email => _email;

  set email(value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }

}
