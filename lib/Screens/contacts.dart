import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:permission_handler/permission_handler.dart';


class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getphoneContacts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Contacts"),
        ),
        body: 
            
             FutureBuilder(
              future: getphoneContacts(),
               builder: (context,AsyncSnapshot snapshot) {
                if (snapshot.data==null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                 return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(snapshot.data[index].givenName?[0]??"NA"),
                        ),
                        title: Text(snapshot.data[index].givenName??"No Data Found"),
                        subtitle: Text(snapshot.data[index].phones!.length == 0
                            ? "No number Found"
                            : snapshot.data[index].phones![0].value!),
                      );
                    }));
               }
             )
                
                );
  }

  
 Future<List<Contact>> getphoneContacts() async {
bool isGranted = await Permission.contacts.status.isGranted;
if (!isGranted) {
 isGranted= await Permission.contacts.request().isGranted;
}
if (isGranted) {
  return  await ContactsService.getContacts();
}
return [];

  }
}
