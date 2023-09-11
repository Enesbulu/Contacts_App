class Person {
  late int id;
  late String name;
  late String lastname;
  late String num;
  late String mail;
  late String company;

  // late String image;
  late bool isDelete;

  Person({
    required this.id,
    required this.name,
    required this.lastname,
    this.isDelete = false,
    required this.num,
    this.mail = "",
    this.company = "",
  });

  // static List<Person> personList() {
  //   return [
  //     Person(id: 0, name: "Mehmet", lastname: "Seyran"),
  //     Person(id: 1, name: "Ayhan", lastname: "Boz"),
  //     Person(id: 3, name: "Nil", lastname: "Serin")
  //   ];
  // }
}
