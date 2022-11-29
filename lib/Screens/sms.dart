import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const SMS());
}

class SMS extends StatefulWidget {
  const SMS({Key? key}) : super(key: key);

  @override
  State<SMS> createState() => _SMSState();
}

class _SMSState extends State<SMS> {
  bool isLoading = true;
  final SmsQuery _query = SmsQuery();
var message = List<SmsMessage>;

  @override
  void initState() {
    super.initState();
   
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS'),
      ),
      body:  FutureBuilder(
        future:getallSms() ,
        builder: (context,AsyncSnapshot snapshot) {
            if (snapshot.data==null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text(snapshot.data[index].sender?[0]??"NA"),),
                  title: Text(snapshot.data[index].sender??"No Data Found"),
                  subtitle: Text(snapshot.data[index].body??"No Data Found "),
                );
              },
            ),
          );
        }
      ),
  
    );
  }
   Future<List<SmsMessage>> getallSms() async {
bool isGranted = await Permission.sms.status.isGranted;
if (!isGranted) {
 isGranted= await Permission.sms.request().isGranted;
}
if (isGranted) {
  return  await _query.querySms(
      kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
        
  );
}
return [];

  }
}
