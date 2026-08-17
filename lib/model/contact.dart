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

}

