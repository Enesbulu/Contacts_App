import 'package:flutter/material.dart';
import 'package:masterapp/daoClasses/PersonDao.dart';
import 'package:masterapp/pages/contact_add.dart';
import 'package:masterapp/pages/contact_info.dart';
import 'package:masterapp/entity/person.dart';
import 'package:permission_handler/permission_handler.dart';

// **Bu sınıf, uygulamanın ana sınıfıdır. Ana ekranı tanımlar.**
class Home extends StatefulWidget {
  // **The constructor of the class.**
  Home({Key? key}) : super(key: key);

  // **Bu method, sınıfın durumunu oluşturur.**
  @override
  State<Home> createState() => _HomeState();
}

// **Bu sınıf, Home sınıfının durum sınıfıdır.**
class _HomeState extends State<Home> {
  // **Bu değişken, kişilerin listesini tutar.**
  // final personList = Person.personList();

  // **Bu değişken, arama çubuğunun görünür olup olmadığını gösterir.**
  bool isSearch = false;

// **Bu değişken, arama sorgusunu tutar.**
  String searchQuery = "";
  late Person person_;

  // **Bu method, kişilerin listesini alır.**
  Future<List<Person>> viewAllContact() async {
    var personList = await PersonDao().allPerson();
    print("'//\\viewAllContact' metodu çalışıyor!!");
    // var personList = <Person>[];
    // // Add some people to the list.
    // var k1 =
    //     Person(id: 0, name: "Mehmet", lastname: "Seyran", num: "+905000000000");
    // var k2 =
    //     Person(id: 1, name: "Selim", lastname: "Ceylan", num: "+905001111111");
    // var k3 =
    //     Person(id: 2, name: "Ayhan", lastname: "Boz", num: "+905002222222");
    // var k4 =
    //     Person(id: 3, name: "Nuray", lastname: "Genç", num: "+905003333333");
    // var k5 =
    //     Person(id: 4, name: "Nil", lastname: "Serin", num: "+905004444444");
    // var k6 =
    //     Person(id: 5, name: "Bengü", lastname: "Kolay", num: "+905005555555");
    // // Add the people to the list.
    // personList.add(k1);
    // personList.add(k2);
    // personList.add(k3);
    // personList.add(k4);
    // personList.add(k5);
    // personList.add(k6);
    // Return the list of people.
    return personList;
  }

  Future<List<Person>> searchMake(String searchQuery) async {
    var personList = await PersonDao().searchPerson(searchQuery);
    return personList;
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

//Db  bağlantı istek metodu
  void _requestPermissions() {
    Permission.storage.request();
  }

// **Bu method, bir kişiyi siler.**
  Future<void> deletePerson(int personId) async {
    await PersonDao().personDelete(personId);
    // Print the ID of the person to be deleted.
    print("$personId silindi");

// Sınıfın durumunu yeniden oluştur.
    setState(
      () {
        // viewAllContact   //kişi silinince kişiler listesinden silinmesi gerekli. gerekli kod yazılacak!
      },
    );
  }

// **Bu method, ana ekranın UI'ini oluşturur.**
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: AppBar(
        //Menu button
        leading: IconButton(
          tooltip: "Menu icon",
          icon: const Icon(Icons.dehaze),
          onPressed: () {
            print("Menuye basıldı");
          },
        ),
        //Search alanı
        title: isSearch
            ? TextField(
                //arama yapılıyorsa ? search bar : search icon;
                decoration: const InputDecoration(
                  hintText: "Search",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                onChanged: (searchResult) {
                  print("Arama sonucu : $searchResult");
                  setState(() {
                    //ekranı günceller
                    searchQuery =
                        searchResult; //arama sonucunu aranan kelimeye aktardım.
                  });
                },
              )
            : const Text('Masters'),
        actions: [
          isSearch
              ? IconButton(
                  onPressed: () {
                    setState(
                      () {
                        isSearch = false;
                        searchQuery = "";
                      },
                    );
                    print("Search close basıldı.");
                    // SearchPage();
                  },
                  // icon: SearchPage(),
                  icon: const Icon(Icons.close),
                )
              : IconButton(
                  onPressed: () {
                    setState(
                      () {
                        isSearch = true;
                      },
                    );
                    print("Search basıldı.");
                    // SearchPage();
                  },
                  // icon: SearchPage(),
                  icon: const Icon(Icons.search),
                ),
          IconButton(
              iconSize: 22,
              onPressed: () {
                print("more_vert_rounded basıldı.");
              },
              icon: const Icon(Icons.more_vert_rounded))
        ],
      ),
      //Body
      body: FutureBuilder<List<Person>>(
        future: isSearch ? searchMake(searchQuery) : viewAllContact(),
        builder: (context, snapshot) {
          //Eğer kişi listesi boş değilse çalışır.
          if (snapshot.hasData) {
            var personList = snapshot.data;
            return ListView.builder(
              physics:
                  const AlwaysScrollableScrollPhysics(), //sayfanın scrollable özelliğini veriyor.
              itemCount: personList!.length,
              itemBuilder: (context, index) {
                var person = personList[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40, top: 5),
                  child: GestureDetector(
                    onTap: () {
                      //karta tıklanınca ilgili sayfaya yönlendirme yapar
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactInfo(
                            personId: person.id,
                          ),
                        ),
                      );
                    },
                    //Kişi kartları
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "images/1.png",
                            ),
                            const Spacer(
                              flex: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //Kisi isim
                                Text(
                                  person.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                //kişi soyisim
                                const Padding(
                                    padding: EdgeInsets.only(right: 7)),
                                Text(
                                  person.lastname,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Spacer(
                              flex: 90,
                            ),
                            //kisi numarası
                            // Row(
                            //   children: [
                            //     Text(
                            //       person.num,
                            //       style: const TextStyle(fontSize: 12),
                            //     )
                            //   ],
                            // ),
                            //Kisi kard delete icon
                            IconButton(
                              onPressed: () {
                                deletePerson(person.id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
            //Eğer listelenecek eleman bulunamazsa ekrana yazı yazar.
          } else {
            return const Center(
              child: Text("Sonuç Bulunamadı"),
            );
          }
        },
      ),

      //Add button
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(
          onPressed: () async {
            print("Add buton basıldı");
            await Future.delayed(const Duration(milliseconds: 500));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactAdd()),
            );
          },
          tooltip: "Add Contact",
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
