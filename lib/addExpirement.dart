import 'package:flutter/material.dart';
import 'package:mini/bloc/services/api.dart';
import 'package:mini/homepage.dart';

class AddExpirement extends StatefulWidget {
  const AddExpirement({super.key});

  @override
  State<AddExpirement> createState() => _AddExpirementState();
}

class _AddExpirementState extends State<AddExpirement> {
  final TextEditingController expirementNameController = TextEditingController();
  final TextEditingController defaultAmountController = TextEditingController();
  final List<Map<String, TextEditingController>> chemicalFields = [];
  final List<Map<String, TextEditingController>> reagentFields = [];
    Map<String, dynamic>? _data;
  bool _isLoading = false;
  String? _errorMessage;


  List<String> chemicalList = [];
  List<String> ReagentList = [];

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

  void _addReagentField() {
    setState(() {
      reagentFields.add({
        'name': TextEditingController(),
        'quantity': TextEditingController(),
      });
    });
  }

  void _removeReagentField(int index) {
    setState(() {
      reagentFields.removeAt(index);
    });
  }

  // void _confirmAndLog() {
  //   print('Expirement Name: ${expirementNameController.text}');
  //   print('Added Chemicals:');
  //   for (var chemical in chemicalFields) {
  //     print('${chemical['name']!.text}: ${chemical['quantity']!.text} ml');
  //   }

  //   print('Added reagents:');
  //   for (var reagent in reagentFields) {
  //     print('${reagent['name']!.text}: ${reagent['quantity']!.text} ml');
  //   }
  // }
   void _confirmAndLog() async {

  var expirementname = expirementNameController.text;

  var chemicals = <Map<String, dynamic>>[];
  for (var chemical in chemicalFields) {
    var chemicalname = chemical['name']!.text;
    var quantity = double.parse(chemical['quantity']!.text);
    chemicals.add({
      "chemicalname": chemicalname,
      "quantity": quantity
    });
  }

  var reagents = <Map<String, dynamic>>[];
  for (var reagent in reagentFields) {
    var reagentname = reagent['name']!.text;
    var quantity = double.parse(reagent['quantity']!.text);
    reagents.add({
      "reagentname": reagentname,
      "quantity": quantity
    });
  }

  var pdata = {
    "name": expirementname,
    "chemicalsUsed": chemicals,
    "reagentsUsed": reagents
  };
   print(pdata);
    try {
      var response = await Api.addexp(pdata);
      // var msg = response.getMsg();

      print("Message: $response");

      if (response == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('expirement added successfully!'),
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

  List<String> _getFilteredReagent(String searchQuery) {
    if (searchQuery.isEmpty) {
      return ReagentList;
    }
    return ReagentList.where((reagent) {
      return reagent.toLowerCase().contains(searchQuery.toLowerCase());
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
        ReagentList = List<String>.from(data['reagents']);

        print(
          chemicalList,
        );
        print(
          ReagentList,
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
          'Add New Expirement',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(41, 4, 88, 10),
      ),
      body: SingleChildScrollView(
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
                                'Expirement Name : ',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: expirementNameController,
                                 style: const TextStyle(color: Colors.white),
       
                                decoration: const InputDecoration(
                                  hintText: 'Enter expirement name',
                                  hintStyle: TextStyle(color: Colors.white),
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
                        color: const Color.fromRGBO(152, 104, 255, 10),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
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
                    fontSize: 12, color: Color.fromARGB(255, 161, 161, 161)),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: chemicalFields.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, TextEditingController> chemical = entry.value;
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
                            fieldViewBuilder: (context, controller, focusNode,
                                onFieldSubmitted) {
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                 style: const TextStyle(color: Colors.white),
                   
                                decoration: const InputDecoration(
                                  hintText: 'Enter chemical name',
                                  hintStyle: TextStyle(color: Colors.white),
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
                                hintStyle: TextStyle(color: Colors.white),
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
                              borderRadius: BorderRadius.circular(8.0),
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
                  backgroundColor: const Color.fromRGBO(104, 201, 255, 10),
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
                      fontSize: 12, color: Color.fromARGB(255, 161, 161, 161)),
                ),
              ),
            ),
            const SizedBox(height: 16),
           

             const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 8, bottom: 4),
              child: Text(
                'Add Required reagents :',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(104, 200, 255, 10)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Individual reagents for ${defaultAmountController.text.isEmpty ? '0' : defaultAmountController.text} ml solution',
                style: const TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 161, 161, 161)),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: reagentFields.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, TextEditingController> reagent = entry.value;
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
                              return _getFilteredReagent(
                                  textEditingValue.text);
                            },
                            onSelected: (String selection) {
                              setState(() {
                                reagent['name']!.text = selection;
                              });
                            },
                            fieldViewBuilder: (context, controller, focusNode,
                                onFieldSubmitted) {
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                 style: const TextStyle(color: Colors.white),
                 
                                decoration: const InputDecoration(
                                  hintText: 'Enter reagent name',
                                  hintStyle: TextStyle(color: Colors.white),
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
                            controller: reagent['quantity']!,
                             style: const TextStyle(color: Colors.white),
                         keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Quantity',
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            _removeReagentField(index);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
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
                onPressed: _addReagentField,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(104, 201, 255, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Add reagent'),
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
                  'reagents should be declared before it can be added',
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(255, 161, 161, 161)),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
