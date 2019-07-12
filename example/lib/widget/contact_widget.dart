import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_plugin_example/bloc/contact_bloc.dart';
import 'package:flutter_plugin_example/model/contact.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
        ),
        body: Provider<ContactBloc>(
          builder: (context) => ContactBloc(),
          dispose: (context, bloc) => bloc.dispose(),
          child: ContactListWidget(),
        ),
      ),
    );
  }
}

class ContactListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactListState();
  }
}

class ContactListState extends State<ContactListWidget> {
  @override
  Widget build(BuildContext context) {
    final ContactBloc contactBloc = Provider.of<ContactBloc>(context);
    return StreamBuilder<List<Contact>>(
      stream: contactBloc.getContactsStream(),
      builder: (context, contacts) {
        if (contacts.hasData) {
          if (contacts.data.isNotEmpty) {
            return ListView.builder(
                itemCount: contacts.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(contacts.data[index].name),
                    subtitle: Text(contacts.data[index].number),
                  );
                });
          } else {
            return Center(
              child: Text("No contact found"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}