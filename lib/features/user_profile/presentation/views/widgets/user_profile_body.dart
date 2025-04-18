import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';

class UserProfileBody extends StatefulWidget {
  const UserProfileBody({super.key});

  @override
  State<UserProfileBody> createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  // Mock user data - in a real app, this would come from an API or state management
  final Map<String, dynamic> userData = {
    "username": "user432",
    "firstName": "ابراهيم",
    "secondName": "محمد",
    "lastName": "احمد",
    "gender": "M",
    "email": "ibrahim.ahmed@example.com",
    "notes": "مستخدم نشط يحب متابعة آخر التحديثات والاشتراك في الفعاليات المختلفة.",
    "userPoints": 10
  };

  // For edit mode
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: userData['email']);
    notesController = TextEditingController(text: userData['notes']);
  }

  @override
  void dispose() {
    emailController.dispose();
    notesController.dispose();
    super.dispose();
  }

  // Method to save edited information
  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        userData['email'] = emailController.text;
        userData['notes'] = notesController.text;
        isEditing = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ التغييرات بنجاح'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // Toggle edit mode
  void _toggleEditMode(bool edit) {
    setState(() {
      isEditing = edit;
      if (!edit) {
        // Reset controllers when canceling
        emailController.text = userData['email'];
        notesController.text = userData['notes'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          // Background design elements
          _buildBackgroundElements(size),
          
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.02),
                      
                      // User avatar and basic info
                      _buildUserHeader(),
                      
                      const SizedBox(height: 20),
                      
                      // Edit/Save buttons
                      _buildActionButtons(),
                      
                      const SizedBox(height: 30),
                      
                      // Information sections
                      _buildInfoSection(
                        title: 'معلومات الحساب',
                        items: [
                          InfoItem(
                            icon: Icons.email_outlined,
                            title: 'البريد الإلكتروني',
                            value: userData['email'],
                            isEditable: true,
                            editWidget: _buildTextField(
                              controller: emailController,
                              hintText: 'البريد الإلكتروني',
                              validator: _emailValidator,
                            ),
                          ),
                          InfoItem(
                            icon: Icons.badge_outlined,
                            title: 'اسم المستخدم',
                            value: userData['username'],
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      _buildInfoSection(
                        title: 'المعلومات الشخصية',
                        items: [
                          InfoItem(
                            icon: Icons.person_outline,
                            title: 'الاسم الكامل',
                            value: '${userData['firstName']} ${userData['secondName']} ${userData['lastName']}',
                          ),
                          InfoItem(
                            icon: Icons.note_outlined,
                            title: 'ملاحظات',
                            value: userData['notes'],
                            isEditable: true,
                            editWidget: _buildTextField(
                              controller: notesController,
                              hintText: 'ملاحظات',
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Logout button
                      _buildLogoutButton(),
                      
                      SizedBox(height: size.height * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Background elements builder
  Widget _buildBackgroundElements(Size size) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: size.width * 0.6,
            height: size.height * 0.25,
            decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(100),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: size.width * 0.4,
            height: size.height * 0.15,
            decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(100),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  // User avatar and basic information
  Widget _buildUserHeader() {
    return Column(
      children: [
        // Avatar with points badge
        Stack(
          children: [
            // Avatar
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.brown, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _getInitials(),
                  style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            // Points badge
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      userData['userPoints'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        
        // Username
        Text(
          '@${userData['username']}',
          style: const TextStyle(
            color: Colors.brown,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        // Full name
        Text(
          '${userData['firstName']} ${userData['secondName']} ${userData['lastName']}',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 5),
        
        // Gender icon
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              userData['gender'] == 'M' ? Icons.male : Icons.female,
              color: userData['gender'] == 'M' ? Colors.blue : Colors.pink,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text(
              userData['gender'] == 'M' ? 'ذكر' : 'أنثى',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  // Action buttons (Edit/Save/Cancel)
  Widget _buildActionButtons() {
    return !isEditing
      ? ElevatedButton.icon(
          onPressed: () => _toggleEditMode(true),
          icon: const Icon(Icons.edit, size: 20),
          label: const Text('تعديل الملف الشخصي'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        )
      : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.save, size: 20),
              label: const Text('حفظ'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () => _toggleEditMode(false),
              icon: const Icon(Icons.cancel, size: 20),
              label: const Text('إلغاء'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        );
  }
  
  // Information section builder
  Widget _buildInfoSection({required String title, required List<InfoItem> items}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Section items
          ...items.map((item) => Column(
            children: [
              _buildInfoItemWidget(item),
              if (items.indexOf(item) < items.length - 1)
                const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            ],
          )).toList(),
        ],
      ),
    );
  }
  
  // Info item widget
  Widget _buildInfoItemWidget(InfoItem item) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: Colors.brown, size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    if (item.isEditable && !isEditing)
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.edit,
                          color: Colors.brown,
                          size: 14,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                isEditing && item.isEditable
                  ? item.editWidget
                  : Text(
                      item.value,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.right,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Text field builder for edit mode
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: Colors.black87, fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: Colors.brown.withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.brown, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade300, width: 1),
        ),
      ),
    );
  }
  
  // Email validation
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }
  
  // Logout button
  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          GoRouter.of(context).go(AppRouter.rSignIn);
        },
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text(
          'تسجيل الخروج',
          style: TextStyle(color: Colors.red),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
  
  // Get initials for avatar
  String _getInitials() {
    return userData['firstName'].substring(0, 1) + userData['lastName'].substring(0, 1);
  }
}

// Info item model for better structure
class InfoItem {
  final IconData icon;
  final String title;
  final String value;
  final bool isEditable;
  final Widget editWidget;

  InfoItem({
    required this.icon,
    required this.title,
    required this.value,
    this.isEditable = false,
    this.editWidget = const SizedBox(),
  });
}