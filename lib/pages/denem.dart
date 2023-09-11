// import 'package:flutter/material.dart';
// import 'package:masterapp/daoClasses/PersonDao.dart';
// import 'package:masterapp/pages/homePages.dart';
// import 'package:masterapp/entity/person.dart';

// class denemeInfo extends StatefulWidget {
//   // late var personId = person.id;
//   denemeInfo({Key? key}) : super(key: key);

//   @override
//   State<denemeInfo> createState() => _denemeInfoState();
// }

// class _denemeInfoState extends State<denemeInfo> {
//   Future<Person> getByPerson() async {
//     var getPerson = await PersonDao().getByContact();

//     print("getByPerson metodunun içerisi :: $getPerson");
//     return getPerson;
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var deneme = getByPerson;
//     Person dene2 = deneme as Person;
//     (dene2.name)
//     return Scaffold(
//       //AppBar Area
//       appBar: AppBar(
//         title: const Text("Contacts"),
//         //Arrow_Back Icon Area
//         leading: IconButton(
//           iconSize: 18,
//           color: Colors.blueGrey.shade800,
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             print("Back buton basıldı");
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Home()),
//             );
//           },
//         ),
//         //Delete Icon Area
//       ),
//       body: Container(
//         child: ListView.builder(
//           itemCount: personList.length,
//           itemBuilder: (context, index) {
//             var person = personList[index];
//             return Container(
//               child: Column(
//                 children: [
//                   Text(person.name,
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
//                   Spacer(flex: 50),
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                     Text(person.num, style: TextStyle(fontSize: 17))
//                   ]),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
// /* Container(
//         margin: const EdgeInsets.all(1.0),
//         child: const Column(
//           children: [
//             //Name Text Area
//             Text(
//               // getcontact.name,
//               "<Contact Name>",
//               // tfpersonName.text,

//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//             ),
//             Spacer(
//               flex: 50,
//             ),
//             //Number Area
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "+90 500 000 00 00",
//                   style: TextStyle(color: Colors.cyan, fontSize: 17),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ), */




// //  body: FutureBuilder<List<Person>>(
// //         future: isSearch ? searchMake(searchQuery) : viewAllContact(),
// //         builder: (context, snapshot) {
// //           //Eğer kişi listesi boş değilse çalşır.
// //           if (snapshot.hasData) {
// //             var personList = snapshot.data;
// //             return ListView.builder(
// //               itemCount: personList!.length,
// //               itemBuilder: (context, index) {
// //                 var person = personList[index];
// //                 return Padding(
// //                   padding: const EdgeInsets.only(right: 40, left: 40, top: 5),
// //                   child: GestureDetector(
// //                     onTap: () {
// //                       //karta tıklanınca ilgili sayfaya yönlendirme yapar
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => ContactInfo(),
// //                         ),
// //                       );
// //                     },
// //                     //Kişi kartları
// //                     child: Card(
// //                       child: SizedBox(
// //                         height: 50,
// //                         child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                           children: [
// //                             Column(
// //                               children: [
// //                                 Row(
// //                                   mainAxisAlignment:
// //                                       MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     //Kisi isim
// //                                     Text(
// //                                       person.name,
// //                                       style: const TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                     //kişi soyisim
// //                                     const Padding(padding: EdgeInsets.all(15)),
// //                                     Text(
// //                                       person.lastname,
// //                                       style: const TextStyle(
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 //kisi numarası
// //                                 Row(
// //                                   children: [
// //                                     Text(
// //                                       person.num,
// //                                       style: const TextStyle(fontSize: 12),
// //                                     )
// //                                   ],
// //                                 )
// //                               ],
// //                             ),
// //                             //Kisi kard delete icon
// //                             IconButton(
// //                               onPressed: () {
// //                                 deletePerson(person.id);
// //                               },
// //                               icon: const Icon(
// //                                 Icons.delete,
// //                                 color: Colors.black54,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             );
// //             //Eğer listelenecek eleman bulunamazsa ekrana yazı yazar.
// //           } else {
// //             return const Center(
// //               child: Text("Sonuç Bulunamadı"),
// //             );
// //           }
// //         },
// //       ),