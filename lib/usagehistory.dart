import 'package:flutter/material.dart';
import 'package:mini/bloc/services/api.dart';
import 'package:mini/homepage.dart';
import 'package:mini/notifiicationHistory.dart';
import 'package:mini/profilePage.dart';


class UsageHistory extends StatefulWidget {
  const UsageHistory({super.key});

  @override
  _UsageHistoryState createState() => _UsageHistoryState();
}

class _UsageHistoryState extends State<UsageHistory> {
  List<Map<String, dynamic>> _histories = [];
  List<Map<String, dynamic>> _filteredHistories = [];
  String _filterBy = 'All';
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final historyData = await getUsageHistory();
      setState(() {
        _histories = historyData['histories'];
        _filteredHistories = List.from(_histories);
        _isLoading = false;
      });
    } catch (e) {
      // Handle any errors that occurred during the API call
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  double get _totalUsage {
    return _filteredHistories.fold(
      0.0,
      (total, history) => total + history['quantity'],
    );
  }

  void _filterData() {
    setState(() {
      _filteredHistories = _histories.where((history) {
        if (_filterBy == 'Chemical' && history['usedAs'] != 'Chemical') {
          return false;
        } else if (_filterBy == 'Reagent' && history['usedAs'] != 'Reagent') {
          return false;
        } else if (_filterBy == 'Experiment' && history['usedAs'] != 'Experiment') {
          return false;
        }

        if (_startDate != null && DateTime.parse(history['date']).isBefore(_startDate!)) {
          return false;
        }

        if (_endDate != null && DateTime.parse(history['date']).isAfter(_endDate!)) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usage History', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(11, 0, 35, 10),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: const Color.fromRGBO(11, 0, 35, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          value: _filterBy,
                          dropdownColor: const Color.fromRGBO(11, 0, 35, 10),
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              _filterBy = value!;
                            });
                            _filterData();
                          },
                          items: const [
                            DropdownMenuItem(value: 'All', child: Text('All')),
                            DropdownMenuItem(value: 'Chemical', child: Text('Chemical')),
                            DropdownMenuItem(value: 'Reagent', child: Text('Reagent')),
                            DropdownMenuItem(value: 'Experiment', child: Text('Experiment')),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'From: ',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 8.0),
                            GestureDetector(
                              onTap: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _startDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (selectedDate != null) {
                                  setState(() {
                                    _startDate = selectedDate;
                                  });
                                  _filterData();
                                }
                              },
                              child: Text(
                                _startDate?.toString().substring(0, 10) ?? 'Select',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            const Text(
                              'To: ',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 8.0),
                            GestureDetector(
                              onTap: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _endDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (selectedDate != null) {
                                  setState(() {
                                    _endDate = selectedDate;
                                  });
                                  _filterData();
                                }
                              },
                              child: Text(
                                _endDate?.toString().substring(0, 10) ?? 'Select',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total Usage: $_totalUsage',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredHistories.length,
                      itemBuilder: (context, index) {
                        final history = _filteredHistories[index];
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                history['chemicalname'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text('Quantity: ${history['quantity']}'),
                              const SizedBox(height: 8.0),
                              Text('Batch: ${history['batch']}'),
                              const SizedBox(height: 8.0),
                              Text('Date: ${history['date']}'),
                              const SizedBox(height: 8.0),
                              Text('Used As: ${history['usedAs']}'),
                              const SizedBox(height: 8.0),
                              Text('Remark: ${history['remark']}'),
                            ],
                          ),
                        );
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