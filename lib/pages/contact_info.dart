import 'package:flutter/material.dart';
import 'package:masterapp/daoClasses/PersonDao.dart';
import 'package:masterapp/pages/contact_update.dart';
import 'package:masterapp/pages/homePages.dart';
import 'package:masterapp/entity/person.dart';

class ContactInfo extends StatefulWidget {
  late int personId;
  ContactInfo({Key? key, required this.personId}) : super(key: key);

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  Person? person_;

  Future<Person> getByPerson() async {
    Person getPerson =
        await PersonDao().getByIdPersonWithId(perId: widget.personId);
    print("getByPerson metodunun içerisi :: ${widget.personId}");

// getPerson değişkeninin Null bir değer döndürme olasılığını ele alarak hatayı önle.
    getPerson = await getPerson;

    if (getPerson == null) {
      // getPerson değişkeni Null ise, boş bir dizi döndür.
      getByPerson();
      return Future.error("Person not found");
    } else {
      // getPerson değişkeni Null değilse, değeri döndür.
      return getPerson;
    }

    // return getPerson;
  }

  @override
  void initState() {
    super.initState();
    getByPerson().then(
      (value) {
        setState(() {
          person_ = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(getByPerson());
    return Scaffold(
      //AppBar Area
      appBar: AppBar(
        title: const Text("Contacts"),
        //Arrow_Back Icon Area
        leading: IconButton(
          iconSize: 18,
          color: Colors.blueGrey.shade800,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print("Back buton basıldı");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),
        //Delete Icon Area
        actions: [
          IconButton(
            iconSize: 18,
            onPressed: () {
              //SnacBar Widget Area - 1
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                      "Are you sure you want the contact to be deleted? "),
                  action: SnackBarAction(
                    label: "Yes",
                    onPressed: () {
                      print("Delete tuluna basıldı");
                      //SnacBar Widget Area - 2
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Contact is deleted."),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.delete),
          ),
          //Edit Icon Area
          IconButton(
              iconSize: 18,
              onPressed: () {
                print("Edit buton basıldı");
                print(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactUpdate(
                            personId: person_!.id,
                          )),
                );
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(1.0),
        // color: Colors.blueGrey,
        child: Column(
          children: [
            const Spacer(flex: 20),
            // Image Area
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/img/1.jpg",
                )
              ],
            ),
            const Spacer(
              flex: 10,
            ),
            //Name Text Area
            Text(
              person_ != null
                  ? '${person_!.name} ${person_!.lastname}'
                  : 'No Name',
              style: const TextStyle(
                  fontSize: 25,
                  // fontFamily: "bold",
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(
              flex: 20,
            ),
            //Number Area
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  person_ != null ? person_!.num : 'No Number',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 88, 8, 88), fontSize: 22),
                ),
              ],
            ),
            //Divider Line
            const DividerLine(),
            //Buttons Area
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Call Button Area
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      print("Arama tuşuna basıldı.");
                    },
                    icon: const Icon(
                      Icons.call,
                      size: 25,
                    ),
                  ),
                ),
                //Message Button Area
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow.shade700,
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      print("Mesaj tuşuna basıldı.");
                    },
                    icon: const Icon(
                      Icons.message,
                      size: 25,
                    ),
                  ),
                ),
                //Mail Button Area
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightBlue,
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      print("Mail tuşuna basıldı.");
                    },
                    icon: const Icon(
                      Icons.mail_outline,
                      size: 25,
                    ),
                  ),
                ),
                //Shared Button Area
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange.shade700,
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      print("Arama tuşuna basıldı.");
                    },
                    icon: const Icon(
                      Icons.share_rounded,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            //Divider Line
            const DividerLine(),
            const Spacer(flex: 5),
            //Mail Area
            Row(
              children: [
                const Spacer(
                  flex: 5,
                ),
                const Column(
                  children: [Icon(Icons.mail)],
                ),
                const Spacer(
                  flex: 7,
                ),
                Column(
                  children: [
                    Text(
                      person_ != null ? "Mail:   ${person_!.mail}" : '',
                      style: const TextStyle(
                          fontSize: 20,
                          // fontFamily: "bold",
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 80,
                ),
              ],
            ),
            const Spacer(flex: 5),
            //Company Area
            Row(
              children: [
                const Spacer(
                  flex: 5,
                ),
                const Column(
                  children: [Icon(Icons.business_sharp)],
                ),
                const Spacer(
                  flex: 7,
                ),
                Column(
                  children: [
                    Text(
                      person_ != null ? "Company:    ${person_!.company}" : '',
                      style: const TextStyle(
                          fontSize: 20,
                          // fontFamily: "bold",
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 80,
                ),
              ],
            ),
            const Spacer(flex: 15),
          ],
        ),
      ),
    );
  }
}

class DividerLine extends StatelessWidget {
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.black,
      height: 50,
      thickness: 1,
    );
  }
}
