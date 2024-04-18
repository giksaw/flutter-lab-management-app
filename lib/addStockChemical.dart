import 'package:flutter/material.dart';
import 'package:mini/bloc/services/api.dart';
import 'package:mini/homepage.dart';
import 'package:mini/notifiicationHistory.dart';
import 'package:mini/profilePage.dart';

class AddChemicalStock extends StatefulWidget {
  final String chemicalname;
  const AddChemicalStock({Key? key, required this.chemicalname})
      : super(key: key);

  @override
  State<AddChemicalStock> createState() => _AddChemicalStockState();
}

class _AddChemicalStockState extends State<AddChemicalStock> {
  final TextEditingController amountUsedController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  // void subReagent() {
  //   print('in fn'); 
  //   print('Experiment Name: ${widget.chemicalname}');
  // }

  void subReagent() async {
    var name = widget.chemicalname;
    var amountused = amountUsedController.text;
    var expdate = dateController.text;
    var sellername = batchController.text;
    var sellernum = remarkController.text;

    var pdata = {
      "chemicalname": name,
      "addquantity": amountused,
      "expirydate": expdate,
      "sellername": sellername,
      "sellernum": sellernum,
    };
    print(pdata);
    try {
      var response = await Api.addstock(pdata);
      // var msg = response.getMsg();

      print("Message: $response");

      if (response == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('chemical updated successfully!'),
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
          '${widget.chemicalname} Stock Upgrade',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(41, 4, 88, 10),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 3,
                color: const Color.fromRGBO(152, 104, 255, 10),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 8, bottom: 4),
                child: Text(
                  'Enter Updates :',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(104, 200, 255, 10)),
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
                        'Amount to Add :',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: amountUsedController,
                          style: const TextStyle(color: Colors.white),
                         keyboardType: TextInputType.number,
                     
                        decoration: const InputDecoration(
                          hintText: 'Enter amount used',
                          hintStyle: TextStyle(color: Colors.white),
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
                        'EXpiry Date:',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: dateController,
                          style: const TextStyle(color: Colors.white),
                        
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Enter date',

                          hintStyle: TextStyle(color: Colors.white),
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
                        'Seller Name:',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: batchController,
                          style: const TextStyle(color: Colors.white),
                        
                        decoration: const InputDecoration(
                          hintText: 'Enter Name',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'if any change',
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(255, 161, 161, 161)),
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
                        'Seller Contact:',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: remarkController,
                          style: const TextStyle(color: Colors.white),
                         keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter Contact no',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'if any change',
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(255, 161, 161, 161)),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 3,
                color: const Color.fromRGBO(152, 104, 255, 10),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: subReagent,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
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
      ),
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
