class Contact{
  int? id;
  String name;
  String phone;
  String email;
  String address;
  bool isFavorite;


  Contact({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    this.isFavorite = false,
  });

// object theke map e convert korar jonno
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name' : name,
      'phone' : phone,
      'email' : email,
      'address' : address,
      'isFavorite' : isFavorite ? 1 : 0,
    };
}

// map theke OBJECT e convert korar jonno

factory Contact.fromMap(Map<String, dynamic> map){
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      address: map['address'],
      isFavorite: map['isFavorite']==1,);

}


}

