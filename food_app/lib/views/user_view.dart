import 'package:flutter/material.dart';
import 'package:food_app/Models/UserModel.dart';

import '../Respository/api_service.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  late List<User>? _usersList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _usersList = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: _usersList == null || _usersList!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _usersList!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text('User Name: ${_usersList![index].username!}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Email: ${_usersList![index].email!}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' ${_usersList![index].website!}',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
