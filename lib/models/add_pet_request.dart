class AddPetRequest{

  final String _name;
  final String _petCategory;
  final String _breed;
  final String _gender;
  final String _bio;

  AddPetRequest(this._name,this._petCategory,this._breed,this._gender,this._bio);


  Map<String, dynamic> toJson() => {
    'petName': _name,
    'petCategory': _petCategory,
    'petBreed':_breed,
    'petGender':_gender,
    'petBio':_bio
  };

}