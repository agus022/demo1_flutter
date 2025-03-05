class UserModel {
  int? idUser;
  String fullName;
  String email;
  String password;
  String? picture;

//constructor sin cuerpo 
  UserModel({required this.idUser,required this.fullName,required this.email,required this.password,this.picture});
  
  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(
      idUser:map['idUser'],
      fullName:map['fullName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      picture: map['picture']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'fullName': fullName,
      'email': email,
      'password': password,
      'picture': picture,
    };
  }

}