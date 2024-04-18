import 'package:flutter/material.dart';
import 'package:mini/bloc/services/api.dart';
import 'package:mini/homepage.dart';

class AddReagentPage extends StatefulWidget {
  const AddReagentPage({super.key});

  @override
  State<AddReagentPage> createState() => _AddReagentPageState();
}

class _AddReagentPageState extends State<AddReagentPage> {
  final TextEditingController reagentNameController = TextEditingController();
  final TextEditingController defaultAmountController = TextEditingController();
  final List<Map<String, TextEditingController>> chemicalFields = [];
 
  bool _isLoading = false;
  String? _errorMessage;

  List<String> chemicalList = [];

  void _addChemicalField() {
    setState(() {
      chemicalFields.add({
        'name': TextEditingController(),
        'quantity': TextEditingController(),
      });
    });
  }

  void _removeChemicalField(int index) {
    setState(() {
      chemicalFields.removeAt(index);
    });
  }

  // void _confirmAndLog() {
  //   print('Reagent Name: ${reagentNameController.text}');
  //   print('quantityName: ${defaultAmountController.text}');
  //   print('Added Chemicals:');
  //   for (var chemical in chemicalFields) {
  //     print('${chemical['name']!.text}: ${chemical['quantity']!.text} ml');
  //   }
  // }

  

 void _confirmAndLog() async {
    var reagentname = reagentNameController.text;
  var defaultamount = double.parse(defaultAmountController.text);
  var chemicals = <Map<String, dynamic>>[];

  for (var chemical in chemicalFields) {
    var chemicalname = chemical['name']!.text;
    var quantity = double.parse(chemical['quantity']!.text) / defaultamount;
    chemicals.add({
      "chemicalname": chemicalname,
      "addquantity": quantity
    });
  }

  var pdata = {
    "reagentname": reagentname,
    "chemicals": chemicals
  };
   print(pdata);
    try {
      var response = await Api.addreagent(pdata);
      // var msg = response.getMsg();

      print("Message: $response");

      if (response == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('reagent added successfully!'),
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

  List<String> _getFilteredChemicals(String searchQuery) {
    if (searchQuery.isEmpty) {
      return chemicalList;
    }
    return chemicalList.where((chemical) {
      return chemical.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

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
      final data = await getchemicals();
      setState(() {
        chemicalList = List<String>.from(data['chemicals']);

        print(
          chemicalList,
        );
      });
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 0, 35, 10),
      appBar: AppBar(
        title: const Text(
          'Add New Reagent',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
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
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 3,
                        color: const Color.fromRGBO(152, 104, 255, 10),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Reagent Name : ',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: reagentNameController,
                                          style: const TextStyle(color: Colors.white),
                   
                                          decoration: const InputDecoration(
                                            hintText: 'Enter reagent name',
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  height: 3,
                                  color:
                                      const Color.fromRGBO(152, 104, 255, 10),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Default Amount: ',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: defaultAmountController,
                                          style: const TextStyle(color: Colors.white),
                         keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText: 'Enter default amount',
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //const SizedBox(height: 8),
                                const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'This will be the amount to set the chemical amount for',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 161, 161, 161)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 3,
                        color: const Color.fromRGBO(152, 104, 255, 10),
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, top: 8, bottom: 4),
                        child: Text(
                          'Add Required Chemicals :',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(104, 200, 255, 10)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Individual chemicals for ${defaultAmountController.text.isEmpty ? '0' : defaultAmountController.text} ml solution',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 161, 161, 161)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: chemicalFields.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, TextEditingController> chemical =
                              entry.value;
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Autocomplete<String>(
                                      optionsBuilder:
                                          (TextEditingValue textEditingValue) {
                                        return _getFilteredChemicals(
                                            textEditingValue.text);
                                      },
                                      onSelected: (String selection) {
                                        setState(() {
                                          chemical['name']!.text = selection;
                                        });
                                      },
                                      fieldViewBuilder: (context, controller,
                                          focusNode, onFieldSubmitted) {
                                        return TextField(
                                          controller: controller,
                                          focusNode: focusNode,
                                          style: const TextStyle(color: Colors.white),
                   
                                          decoration: const InputDecoration(
                                            hintText: 'Enter chemical name',
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            border: OutlineInputBorder(),
                                          ),
                                          onSubmitted: (value) {
                                            onFieldSubmitted();
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: chemical['quantity']!,
                                      style: const TextStyle(color: Colors.white),
                         keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          hintText: 'Quantity',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      _removeChemicalField(index);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: const Text('Remove'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: _addChemicalField,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromRGBO(104, 201, 255, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Add Chemical'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 3,
                        color: const Color.fromRGBO(152, 104, 255, 10),
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'chemicals should be declared before it can be added',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 161, 161, 161)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _confirmAndLog,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Text(
                            'CONFIRM',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
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
              // Navigate to Notification History page
              break;
            case 1:
              // Navigate to Home page
              break;
            case 2:
              // Navigate to Profile page
              break;
          }
        },
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade400,
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AddReagentPage(),
  ));
}
