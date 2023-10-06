import 'package:flutter/material.dart';
import 'package:masterapp/daoClasses/PersonDao.dart';
import 'package:masterapp/pages/contact_info.dart';
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
  bool nullTest = false;

  Future<void> save(
    String personName,
    String personLastname,
    String personNum, {
    String personMail = "",
    String personCompany = "",
  }) async {
    if (nullTest) {
      print("-------asdasdasd $nullTest");
    }
    if (personName != "" || personNum != "") {
      print("Save edildi");
      await PersonDao().addPerson(
        tfpersonName.text,
        tfpersonLastname.text,
        tfContactNum.text,
        tfContactMail.text,
        tfContactCompany.text,
      );

      int lastAddPerson = await PersonDao().getByIdPerson();

      print("---!!!----Last personId parametresi : $lastAddPerson");
      // Navigator.pop(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ContactInfo(personId: lastAddPerson)));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ContactInfo(personId: lastAddPerson)));
    } else {}

    // Navigator.of(context).pop();
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
                backgroundColor: const Color.fromARGB(255, 147, 242, 255),
              ),
              onPressed: () {
                print("save basıldı");
                if (tfpersonName.text != "" || tfContactNum.text != "") {
                  save(tfpersonName.text, tfpersonLastname.text,
                      tfContactNum.text,
                      personMail: tfContactMail.text,
                      personCompany: tfContactCompany.text);
                }
              },
              child: const Text(
                'SAVE',
                style: TextStyle(color: Color.fromARGB(255, 70, 44, 10)),
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
                  decoration: InputDecoration(
                    hintText: "Name",
                    hoverColor: const Color.fromARGB(232, 17, 143, 202),
                    errorText:
                        tfpersonName.text == "" ? "Please enter a name" : null,
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
                  hintText: "Phone ( 0 500 000 00 00 ) ",
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
                  controller:
                      tfContactCompany, //.text==null ? ErrorHint("Giriş yapmadınız"):,
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
