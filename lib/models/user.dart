class Users {
  final String? userId;
  final String? userNameSurname;
  final String? userNumber;
  final String? userEmail;
  final String? userPassword;
  final String? userState;
  final bool? requestStatus;
  final String? image;

  Users({
    this.userId,
    this.userNameSurname,
    this.userNumber,
    this.userEmail,
    this.userPassword,
    this.userState,
    this.requestStatus,
    this.image,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'nameSurname': userNameSurname,
        'number': userNumber,
        'email': userEmail,
        'password': userPassword,
        'state': userState,
        'requestStatus': requestStatus,
        'image': image,
      };

  //mapten obje oluşturma
  factory Users.fromMap(Map map) => Users(
        userId: map['userId'],
        userNameSurname: map['nameSurname'],
        userNumber: map['number'],
        userEmail: map['email'],
        userPassword: map['password'],
        userState: map['state'],
        requestStatus: map['requestStatus'],
        image: map['image'],
      );
}
