import 'package:flutter/material.dart';
import 'package:mini/addChemical.dart';
import 'package:mini/addExpirement.dart';
import 'package:mini/addReagent.dart';
import 'package:mini/addStockChemical.dart';
import 'package:mini/bloc/services/api.dart';
import 'package:mini/notifiicationHistory.dart';
import 'package:mini/profilePage.dart';
import 'package:mini/usagehistory.dart';
import 'package:mini/useChemical.dart';
import 'package:mini/useExpirement.dart';
import 'package:mini/useReagent.dart';
import 'package:mini/viewStock.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isLoading = false;
  String? _errorMessage;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String activeButton = 'Chemicals';
  final TextEditingController _searchController = TextEditingController();

  late List<String> list = [];
  // ignore: non_constant_identifier_names
  List<String> ExpirementList = [];

  List<String> chemicalList = [];
  List<String> reagentlist = [];
  late String chem1;
  late String chem2;
  late String chem3;

  void updateList() {
    setState(() {
      if (activeButton == 'Chemicals') {
        list = chemicalList;
      } else if (activeButton == 'Reagents') {
        list = reagentlist;
      } else {
        list = ExpirementList;
      }
    });
  }

  List<String> filteredList() {
    String searchText = _searchController.text.toLowerCase();
    if (searchText.isEmpty) {
      return list;
    } else {
      return list
          .where((item) => item.toLowerCase().contains(searchText))
          .toList();
    }
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
      final data = await getChemicalReagentExperiment();
      setState(() {
        chemicalList = List<String>.from(data['chemicals']);
        reagentlist = List<String>.from(data['reagents']);
        ExpirementList = List<String>.from(data['experiments']);
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
    updateList();
    var name = "Suby Maam";
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromRGBO(11, 0, 35, 10),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(11, 0, 35, 10),
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            child: const Icon(
              Icons.menu,
              size: 26.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: const Color.fromRGBO(11, 0, 35, 10),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: const Color.fromRGBO(11, 0, 35, 10),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Usage History',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigate to Usage History page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UsageHistory(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Check Stock',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigate to Check Stock page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewStock(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigate to Settings page
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _errorMessage != null
              ? Center(
                  child: Text('Error: $_errorMessage'),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    activeButton = 'Chemicals';
                                    updateList();
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (activeButton == 'Chemicals') {
                                        return const Color.fromRGBO(
                                            155,
                                            102,
                                            255,
                                            10); // Background color when active
                                      }
                                      return Colors
                                          .transparent; // Background color when inactive
                                    },
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (activeButton == 'Chemicals') {
                                        return Colors
                                            .black; // Text color when active
                                      }
                                      return Colors
                                          .white; // Text color when inactive
                                    },
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 13),
                                  child: Text(
                                    'Chemicals',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    activeButton = 'Reagents';
                                    updateList();
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (activeButton == 'Reagents') {
                                        return const Color.fromRGBO(
                                            155,
                                            102,
                                            255,
                                            10); // Background color when active
                                      }
                                      return Colors
                                          .transparent; // Background color when inactive
                                    },
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (activeButton == 'Reagents') {
                                        return Colors
                                            .black; // Text color when active
                                      }
                                      return Colors
                                          .white; // Text color when inactive
                                    },
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 13),
                                  child: Text(
                                    'Reagents',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    activeButton = 'Experiments';
                                    updateList();
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (activeButton == 'Experiments') {
                                        return const Color.fromRGBO(
                                            155,
                                            102,
                                            255,
                                            10); // Background color when active
                                      }
                                      return Colors
                                          .transparent; // Background color when inactive
                                    },
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (activeButton == 'Experiments') {
                                        return Colors
                                            .black; // Text color when active
                                      }
                                      return Colors
                                          .white; // Text color when inactive
                                    },
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 13),
                                  child: Text(
                                    'Experiments',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Recently Used',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                              ),
                              child: const Text('Ch 123',
                                  style: TextStyle(fontSize: 18.0)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                              ),
                              child: const Text('Ch 456',
                                  style: TextStyle(fontSize: 18.0)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                              ),
                              child: const Text('Ch 789',
                                  style: TextStyle(fontSize: 18.0)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _searchController,
                        onChanged: (_) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            activeButton == 'Chemicals'
                                ? 'Chemicals'
                                : activeButton == 'Reagents'
                                    ? 'Reagents'
                                    : 'Experiments',
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (activeButton == 'Chemicals') {
                                // Navigate to Add Chemical page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddChemical(),
                                  ),
                                );
                              } else if (activeButton == 'Reagents') {
                                // Navigate to Add Reagent page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddReagentPage(),
                                  ),
                                );
                              } else {
                                // Navigate to Add Experiment page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddExpirement(),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(104, 201, 255, 10),
                            ),
                            child: Text(
                              activeButton == 'Chemicals'
                                  ? '+ Add Chemical'
                                  : activeButton == 'Reagents'
                                      ? '+ Add Reagent'
                                      : '+ Add Experiment',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredList().isEmpty
                              ? 1
                              : filteredList().length,
                          itemBuilder: (context, index) {
                            if (filteredList().isEmpty) {
                              return const Center(
                                child: Text('No matching items'),
                              );
                            } else {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(26, 0, 80, 10),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(
                                    filteredList()[index],
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (activeButton == 'Chemicals')
                                        ElevatedButton(
                                          onPressed: () {
                                            String chemicalname =
                                                filteredList()[index];
                                            // Navigate to Add Chemical page
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddChemicalStock(
                                                        chemicalname:
                                                            chemicalname),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255, 249, 163, 72),
                                          ),
                                          child: const Text(
                                            'ADD',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      const SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (activeButton == 'Chemicals') {
                                            String chemicalname =
                                                filteredList()[index];
                                            // Navigate to Use Chemical page
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UseChemicalPage(
                                                        chemicalname:
                                                            chemicalname),
                                              ),
                                            );
                                          } else if (activeButton ==
                                              'Reagents') {
                                            String reagentname =
                                                filteredList()[index];
                                            // Navigate to Use Reagent page
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ReagentUse(
                                                        reagentname:
                                                            reagentname),
                                              ),
                                            );
                                          } else {
                                            String expirementName =
                                                filteredList()[index];
                                            // Navigate to Use Experiment page
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UseExperimentPage(
                                                        expirementName:
                                                            expirementName),
                                              ),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 108, 255, 113),
                                        ),
                                        child: const Text(
                                          'USE',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
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
