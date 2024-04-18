import 'package:flutter/material.dart';
import 'package:mini/bloc/services/api.dart';
import 'package:mini/homepage.dart';
import 'package:mini/notifiicationHistory.dart';
import 'package:mini/profilePage.dart';

class UseExperimentPage extends StatefulWidget {
  final String expirementName;

  const UseExperimentPage({Key? key, required this.expirementName})
      : super(key: key);

  @override
  _UseExperimentPageState createState() => _UseExperimentPageState();
}

class _UseExperimentPageState extends State<UseExperimentPage> {
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _experimentData;

  final TextEditingController batchController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await getexpirementdetails(widget.expirementName);
      setState(() {
        _experimentData = data;
      });
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void useexp() async {
    var name = widget.expirementName;

    var date = dateController.text;
    var batch = batchController.text;
    var remark = remarkController.text;

    var pdata = {
      "expname": name,
      "batch": batch,
      "date": date,
      "remark": remark
    };
    print(pdata);
    try {
      var response = await Api.useexp(pdata);
      // var msg = response.getMsg();

      print("Message: $response");

      if (response == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Expirement Use successfull!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Display a popup message with the error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text("input error"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error registering user: $e');
      // Display a generic error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 0, 35, 10),
      appBar: AppBar(
        title: Text(
          'Using ${widget.expirementName}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromRGBO(41, 4, 88, 10),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _errorMessage != null
              ? Center(
                  child: Text('Error: $_errorMessage'),
                )
              : _experimentData != null
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              height: 3,
                              color: const Color.fromRGBO(152, 104, 255, 10),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Chemicals Used:',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  ..._experimentData!['chemicalsUsed']
                                      .map<Widget>((chemical) => Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    chemical['chemicalName'],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Text(
                                                  '${chemical['quantity']} units',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 3,
                              color: const Color.fromRGBO(152, 104, 255, 10),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Reagents Used:',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  ..._experimentData!['reagentsUsed']
                                      .map<Widget>((reagent) => Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 221, 221, 1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    reagent['reagentName'],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Text(
                                                  '${reagent['quantity']} units',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 3,
                              color: const Color.fromRGBO(152, 104, 255, 10),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Batch:',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: 3,
                                    child: TextField(
                                      controller: batchController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: 'Enter batch',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Date:',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: 3,
                                    child: TextField(
                                      controller: dateController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter date',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Remark:',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: 3,
                                    child: TextField(
                                      controller: remarkController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: 'Enter remark',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 3,
                              color: const Color.fromRGBO(152, 104, 255, 10),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                useexp();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.green,
                                minimumSize: const Size(double.infinity, 50),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                ),
                              ),
                              child: const Text(
                                'CONFIRM',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: 1,
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationHistory(),
                    ),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Homepage(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                  break;
              }
            },
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
