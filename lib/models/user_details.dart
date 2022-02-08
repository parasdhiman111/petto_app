class UserDetails{

  final String _firstName;
  final String _lastName;
  final String _email;
  final String _gender;
  UserDetails(this._firstName, this._lastName, this._email,this._gender);
  String get gender => _gender;
  String get email => _email;
  String get lastName => _lastName;
  String get firstName => _firstName;


  factory UserDetails.fromJson(dynamic json) {
    return UserDetails(json['firstName'], json['lastName'], json['email'], json['gender']);
  }

}