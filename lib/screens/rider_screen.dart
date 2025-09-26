import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({Key? key}) : super(key: key);

  @override
  State<RiderHomePage> createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage> {
  String segmentedValue = 'รับงาน';
  int _selectedIndex = 0;

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 72,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 6),
            Text(
              'สวัสดีคุณ',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            Text(
              'Allan Smith',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blueGrey.shade100,
              child: const Text('AS', style: TextStyle(color: Colors.black87)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),

              // Title
              Center(
                child: Text(
                  'Rider',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 12),

              // Segmented control
              CupertinoSegmentedControl<String>(
                children: const {
                  'รับงาน': Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 24.0,
                    ),
                    child: Text('รับงาน'),
                  ),
                  'ค้นหาผู้รับ': Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 24.0,
                    ),
                    child: Text('ค้นหาผู้รับ'),
                  ),
                },
                groupValue: segmentedValue,
                unselectedColor: Colors.grey.shade100,
                borderColor: Colors.grey.shade300,
                pressedColor: Colors.grey.shade200,
                selectedColor: Colors.black,
                onValueChanged: (v) => setState(() => segmentedValue = v),
              ),

              const SizedBox(height: 16),

              // Small action cards
              Row(
                children: [
                  Expanded(
                    child: _SmallActionCard(
                      title: 'รับงาน',
                      icon: Icons.assignment_turned_in_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SmallActionCard(
                      title: 'ค้นหาผู้รับ',
                      icon: Icons.search,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Section Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'รับงาน',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextButton(onPressed: () {}, child: const Text('View all')),
                ],
              ),

              const SizedBox(height: 8),

              // Job list
              Expanded(
                child: ListView.separated(
                  itemCount: 2,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return JobCard(
                      title: 'Food Items/Groceries',
                      recipient: 'Paul Pogba',
                      dropOff: 'Maryland bustop, Anthony Ikeja',
                      onAccept: () {},
                      onReject: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        backgroundColor: Colors.white,
        elevation: 8,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _SmallActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SmallActionCard({Key? key, required this.title, required this.icon})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.black54),
          ),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String title;
  final String recipient;
  final String dropOff;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const JobCard({
    Key? key,
    required this.title,
    required this.recipient,
    required this.dropOff,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.local_grocery_store_outlined,
                    size: 22,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 16,
                  color: Colors.black54,
                ),
                const SizedBox(width: 6),
                Text(
                  'Recipient: $recipient',
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.place_outlined,
                  size: 16,
                  color: Colors.black54,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    dropOff,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.redAccent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Reject',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
