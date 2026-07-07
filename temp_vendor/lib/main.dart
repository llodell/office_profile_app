import 'package:flutter/material.dart';

// app colors
const appRed = Color(0xFF8B0000);
const appGold = Color(0xFFFFBF00);
const appBg = Color(0xFFF8F9FA);

void main() {
  runApp(const OfficeProfileApp());
}

class OfficeProfileApp extends StatelessWidget {
  const OfficeProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BatStateU Office Profile',
      debugShowCheckedModeBanner: false,
      // theme settings
      theme: ThemeData(
        scaffoldBackgroundColor: appBg,
        primaryColor: appRed,
        colorScheme: ColorScheme.fromSeed(
          seedColor: appRed,
          primary: appRed,
          secondary: appGold,
        ),
        useMaterial3: true,
      ),
      home: const OfficeProfileScreen(),
    );
  }
}

class OfficeProfileScreen extends StatefulWidget {
  const OfficeProfileScreen({super.key});

  @override
  State<OfficeProfileScreen> createState() => _OfficeProfileScreenState();
}

class _OfficeProfileScreenState extends State<OfficeProfileScreen> {
  // form key to check stuff
  final _formKey = GlobalKey<FormState>();

  // input grabbers
  final TextEditingController _officeNameController = TextEditingController();
  final TextEditingController _officeNumberController = TextEditingController();
  final TextEditingController _officeLocationController =
      TextEditingController();

  // dropdown choice
  String? _selectedTransaction;
  final List<String> _transactionTypes = [
    'Document Request',
    'Inquiry',
    'Clearance',
    'Other Administrative Services',
  ];

  @override
  void dispose() {
    // clean up memory
    _officeNameController.dispose();
    _officeNumberController.dispose();
    _officeLocationController.dispose();
    super.dispose();
  }

  // clear the form out
  void _clearForm() {
    _formKey.currentState?.reset();
    _officeNameController.clear();
    _officeNumberController.clear();
    _officeLocationController.clear();
    setState(() {
      _selectedTransaction = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form cleared successfully.'),
        backgroundColor: Colors.grey,
      ),
    );
  }

  // check and submit
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // show the pop-up if all good
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                const Icon(Icons.check_circle, color: appRed),
                const SizedBox(width: 10),
                const Text('Submission Summary'),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  _buildSummaryRow('Office Name:', _officeNameController.text),
                  _buildSummaryRow(
                    'Office Number:',
                    _officeNumberController.text,
                  ),
                  _buildSummaryRow('Location:', _officeLocationController.text),
                  _buildSummaryRow(
                    'Transaction:',
                    _selectedTransaction ?? 'N/A',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: appRed,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  // row builder for the pop-up
  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 15),
          children: [
            TextSpan(
              text: '$label ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BatStateU Office Portal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: appRed,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Registration Form',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: appRed,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildForm(),
                      const SizedBox(height: 24),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // top part and tap actions
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          // handle image taps
          GestureDetector(
            onTap: () {
              // show motto on tap
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Welcome to BatStateU Office Portal! Leading Innovations, Transforming Lives.',
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: appRed,
                  duration: Duration(seconds: 3),
                ),
              );
            },
            onLongPress: () {
              // show dev info when held
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(24.0),
                    height: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: 32,
                              color: appGold,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Developer Information',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: appRed,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        const SizedBox(height: 8),
                        const Text(
                          'Name: Juan Dela Cruz',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Course: Bachelor of Science in Information Technology (BSIT)',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const Text(
                          'Campus: Alangilan Campus',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: appGold, width: 3),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                // random stock image
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1592280771190-3e2e4d571952?q=80&w=200&auto=format&fit=crop',
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Office Profile & Registration',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const Text(
            'Batangas State University',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // the form inputs
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // office name
          TextFormField(
            controller: _officeNameController,
            decoration: InputDecoration(
              labelText: 'Office Name',
              prefixIcon: const Icon(Icons.business),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter the office name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // office number
          TextFormField(
            controller: _officeNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Office Number',
              prefixIcon: const Icon(Icons.numbers),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter the office number';
              }
              if (int.tryParse(value) == null) {
                return 'Office number must be numeric numbers only';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // location field
          TextFormField(
            controller: _officeLocationController,
            decoration: InputDecoration(
              labelText: 'Office Location',
              prefixIcon: const Icon(Icons.location_on),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter the office location';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // transaction picker
          DropdownButtonFormField<String>(
            initialValue: _selectedTransaction,
            hint: const Text('Select Transaction Type'),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.assignment),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: _transactionTypes.map((String type) {
              return DropdownMenuItem<String>(value: type, child: Text(type));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedTransaction = newValue;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a transaction type';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // the buttons at the bottom
  Widget _buildActionButtons() {
    return Row(
      children: [
        // clear stuff out
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(
                color: appRed,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _clearForm,
            child: const Text(
              'Clear',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: appRed,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // send it
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: appRed,
              foregroundColor: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _submitForm,
            child: const Text(
              'Submit',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
