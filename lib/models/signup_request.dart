class SignUpRequest{

  final String _firstName;
  final String _lastName;
  final String _email;
  final String _password;
  final String _gender;
  SignUpRequest(this._firstName, this._lastName, this._email,
      this._password, this._gender);

  String get gender => _gender;

  String get password => _password;

  String get email => _email;

  String get lastName => _lastName;

  String get firstName => _firstName;
}