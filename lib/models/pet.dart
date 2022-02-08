class Pet{

  final String _petId;
  final String _userId;
  final String _name;
  final String _petCategory;
  final String _breed;
  final String _gender;
  final String _profileUrl;
  final String _bio;



  Pet(this._petId,this._userId,this._name,this._petCategory,this._breed,this._gender,this._profileUrl,this._bio);

  factory Pet.fromJson(dynamic json) {
    return Pet(json['petId'], json['userId'], json['name'], json['petCategory'],json['breed'],json['gender'],json['profileUrl'],json['bio']);
  }


  String get petId => _petId;
  String get userId => _userId;
  String get name => _name;
  String get petCategory => _petCategory;
  String get breed => _breed;
  String get gender => _gender;
  String get profileUrl => _profileUrl;
  String get bio => _bio;

}