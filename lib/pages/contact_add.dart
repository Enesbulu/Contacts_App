import 'package:flutter/material.dart';
import 'package:masterapp/daoClasses/PersonDao.dart';
import 'package:masterapp/pages/homePages.dart';
import 'package:masterapp/entity/person.dart';

class ContactAdd extends StatefulWidget {
  late Person person;
  ContactAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactAdd> createState() => _ContactAddState();
}

class _ContactAddState extends State<ContactAdd> {
  var tfpersonName = TextEditingController();
  var tfpersonLastname = TextEditingController();
  var tfContactNum = TextEditingController();
  var tfContactMail = TextEditingController();
  var tfContactCompany = TextEditingController();

  Future<void> save(String personName, String personLastname, String personNum,
      {String personMail = "", String personCompany = ""}) async {
    print("Save edildi");
    await PersonDao().addPerson(tfpersonName.text, tfpersonLastname.text,
        tfContactNum.text, tfContactMail.text, tfContactCompany.text);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => ContactInfo()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.person.name = tfpersonName.text;
    // widget.person.lastname = tfpersonLastname.text;
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets textFiledEdgeInsets =
        const EdgeInsets.only(left: 20, right: 20, bottom: 20);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Contact"),
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
                backgroundColor: const Color.fromARGB(255, 101, 172, 200),
              ),
              onPressed: () {
                print("save basıldı");
                save(
                    tfpersonName.text, tfpersonLastname.text, tfContactNum.text,
                    personMail: tfContactMail.text,
                    personCompany: tfContactCompany.text);
              },
              child: const Text(
                'SAVE',
                style: TextStyle(color: Color.fromARGB(232, 21, 68, 80)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: textFiledEdgeInsets,
              child: Expanded(
                child: TextField(
                  controller: tfpersonName,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    hoverColor: Color.fromARGB(232, 17, 143, 202),
                  ),
                ),
              ),
            ),
            Padding(
              padding: textFiledEdgeInsets,
              child: Expanded(
                child: TextField(
                  controller: tfpersonLastname,
                  decoration: const InputDecoration(
                    hintText: "Last Name",
                    hoverColor: Color.fromARGB(232, 17, 143, 202),
                  ),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
