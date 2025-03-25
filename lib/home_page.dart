import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tugas_1/contactinfo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);

  int updateindex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts List"),
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Nama',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.numberWithOptions(),
              maxLength: 12,
              controller: phoneController,
              decoration: InputDecoration(
                hintText: 'No. Telpon',
                prefixIcon: Icon(Icons.call),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String phone = phoneController.text.trim();
                    String email = emailController.text.trim();
                    if (name.isNotEmpty &&
                        phone.isNotEmpty &&
                        email.isNotEmpty) {
                      setState(() {
                        nameController.text = '';
                        phoneController.text = '';
                        emailController.text = '';
                        contacts.add(
                          Contact(name: name, phone: phone, email: email),
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String phone = phoneController.text.trim();
                    String email = emailController.text.trim();
                    if (name.isNotEmpty &&
                        phone.isNotEmpty &&
                        email.isNotEmpty) {
                      setState(() {
                        nameController.text = '';
                        phoneController.text = '';
                        emailController.text = '';
                        contacts[updateindex].name = name;
                        contacts[updateindex].phone = phone;
                        contacts[updateindex].email = email;
                        updateindex = -1;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            contacts.isEmpty
                ? const Text(
                  'Tidak ada kontak yang tersimpan',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                )
                : Expanded(
                  child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) => getRow(index),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].phone),
            Text(
              contacts[index].email,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 96,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.amber,
                onPressed: () {
                  nameController.text = contacts[index].name;
                  phoneController.text = contacts[index].phone;
                  emailController.text = contacts[index].email;
                  setState(() {
                    updateindex = index;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.redAccent,
                onPressed: () {
                  setState(() {
                    contacts.removeAt(index);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
