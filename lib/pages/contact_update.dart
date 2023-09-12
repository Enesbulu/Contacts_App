import 'package:flutter/material.dart';
import 'package:masterapp/pages/homePages.dart';
// import 'package:masterapp_/person.dart';

class ContactUpdate extends StatefulWidget {
  // Person person;
  late int personId;
  ContactUpdate({Key? key, required this.personId}) : super(key: key);

  @override
  State<ContactUpdate> createState() => _ContactUpdateState();
}

class _ContactUpdateState extends State<ContactUpdate> {
  var tfContactName = TextEditingController(); //tf => textfield
  var tfContactLastName = TextEditingController();
  var tfContactNum = TextEditingController();
  var tfContactMail = TextEditingController();
  var tfContactCompany = TextEditingController();

  Future<void> personUpdate(
      // int personId,
      String tfContactName,
      String tfContactLastName,
      String tfContactNum,
      String tfContactMail,
      String tfContactCompany) async {
    print("$tfContactName - $tfContactLastName kayit edildi");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets textFiledEdgeInsets = const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom:
            20); //textField nesnelerinin paddin değerlerini standartlaştırmak için oluşturulmuş değişken.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Contact"),
        leading: IconButton(
          iconSize: 18,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print("Back buton basıldı");
            print(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
              ),
              onPressed: () {
                print("save basıldı");
                personUpdate(
                    tfContactName.text,
                    tfContactLastName.text,
                    tfContactNum.text,
                    tfContactMail.text,
                    tfContactCompany.text);
              },
              child: Icon(
                Icons.check,
                color: Colors.purple[800],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Textfield-Name
          Padding(
            padding: textFiledEdgeInsets,
            child: Expanded(
              child: TextField(
                controller: tfContactName,
                decoration: const InputDecoration(
                  // hintText: "Name",
                  hoverColor: Color.fromARGB(232, 17, 143, 202),
                ),
              ),
            ),
          ),
          //Textfield-LastName
          Padding(
            padding: textFiledEdgeInsets,
            child: TextField(
              controller: tfContactLastName,
              decoration: const InputDecoration(
                hintText: "Last Name",
                hoverColor: Color.fromARGB(232, 3, 63, 91),
              ),
            ),
          ),
          //Textfield-Number
          Padding(
            padding: textFiledEdgeInsets,
            child: TextField(
              controller: tfContactNum,
              decoration: const InputDecoration(
                hintText: "Phone (+90 0500 000 00 00) ",
                hoverColor: Color.fromARGB(232, 3, 63, 91),
              ),
            ),
          ),
          //Textfield-Email
          Padding(
            padding: textFiledEdgeInsets,
            child: TextField(
              controller: tfContactMail,
              decoration: const InputDecoration(
                hintText: "Email",
                hoverColor: Color.fromARGB(232, 3, 63, 91),
              ),
            ),
          ),
          //Textfield-Company
          Padding(
            padding: textFiledEdgeInsets,
            child: Expanded(
              child: TextField(
                controller: tfContactCompany,
                decoration: const InputDecoration(
                  hintText: "Company",
                  hoverColor: Color.fromARGB(232, 3, 63, 91),
                ),
              ),
            ),
          ),
          // Spacer(
          //   flex: 10,
          // )
        ],
      ),
    );
  }
}
