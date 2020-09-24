import 'package:flutter/material.dart';
import 'package:medium_app/models/profileModel.dart';
import 'package:medium_app/services/networkHelper.dart';

class MainProfileScreen extends StatefulWidget {
  @override
  _MainProfileScreenState createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  bool _loading = true;
  NetworkHelper networkHelper = NetworkHelper();
  ProfileModel profileModel = ProfileModel();
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    var response = await networkHelper.getData('/api/users/profile/getData');
    print(response['data']);
    setState(() {
      profileModel = ProfileModel.fromJson(response['data']);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.blue,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                head(),
                Divider(
                  thickness: 0.8,
                ),
                otherDetails('About', profileModel.about),
                otherDetails('Full Name', profileModel.name),
                otherDetails('Profession', profileModel.profession),
                otherDetails('DOB', profileModel.dob),
              ],
            ),
    );
  }

  Widget head() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
            ),
          ),
          Text(
            ' profileModel.username',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('profileModel.title'),
        ],
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
