import 'package:flutter/material.dart';

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
      // Custom Theme following BatStateU colors (Crimson & Gold)
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(
          0xFFF8F9FA,
        ), // Off-white background
        primaryColor: const Color(0xFF8B0000), // Deep Crimson
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B0000),
          primary: const Color(0xFF8B0000),
          secondary: const Color(0xFFFFBF00), // Amber/Gold
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
  // Global key for form validation
  final _formKey = GlobalKey<FormState>();

  // Text Editing Controllers for extracting input data
  final TextEditingController _officeNameController = TextEditingController();
  final TextEditingController _officeNumberController = TextEditingController();
  final TextEditingController _officeLocationController =
      TextEditingController();

  // Dropdown states
  String? _selectedTransaction;
  final List<String> _transactionTypes = [
    'Document Request',
    'Inquiry',
    'Clearance',
    'Other Administrative Services',
  ];

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _officeNameController.dispose();
    _officeNumberController.dispose();
    _officeLocationController.dispose();
    super.dispose();
  }

  // Resets all form fields and clear inputs
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

  // Validates the form and triggers success dialog
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Show summary dialog if form validations pass successfully
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(Icons.check_circle, color: Theme.of(context).primaryColor),
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
                  foregroundColor: Theme.of(context).primaryColor,
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

  // Helper widget to display clean data rows inside the summary dialog
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
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 3,
                shadowColor: Colors.black12,
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
                          color: Color(0xFF8B0000),
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

  // PART II & IV: HEADER SECTION & GESTURE FEATURES
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          // Wrap image with GestureDetector for Tap and Long Press Requirements
          GestureDetector(
            onTap: () {
              // Feature 1: Brief welcoming motto via SnackBar on Tap
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Welcome to BatStateU Office Portal! Leading Innovations, Transforming Lives.',
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Color(0xFF8B0000),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            onLongPress: () {
              // Feature 2: Display Developer Info inside a Modal Bottom Sheet on Long Press
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
                        Row(
                          children: [
                            const Icon(
                              Icons.account_circle,
                              size: 32,
                              color: Color(0xFFFFBF00),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Developer Information',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
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
                border: Border.all(color: const Color(0xFFFFBF00), width: 3),
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
                // Using a reliable sample university icon logo placeholder
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

  // PART II: FORM FIELDS WITH VALIDATION
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Office Name Field
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

          // Office Number Field
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

          // Office Location Field
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

          // Transaction Type Dropdown
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

  // PART II: ACTION BUTTONS ROW
  Widget _buildActionButtons() {
    return Row(
      children: [
        // Clear Button (Outlined variant)
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _clearForm,
            child: Text(
              'Clear',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Submit Button (Crimson solid background variant)
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Theme.of(context).primaryColor,
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
