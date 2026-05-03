import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/student_service.dart';
import '../../widgets/language_toggle.dart';
import '../../../app_localization.dart';
import 'home_screen.dart';
import 'applications_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditMode = false;
  final Color primaryBlue = const Color(0xFF229BD8);
  final Color grayBg = const Color(0xFFEBEEF4);

  // Controllers for text editing
  late TextEditingController _nameController;
  late TextEditingController _yearController;
  late TextEditingController _facultyController;
  late TextEditingController _specialtyController;
  late TextEditingController _programController;
  final TextEditingController _skillController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: studentService.name);
    _yearController = TextEditingController(text: studentService.graduationYear);
    _facultyController = TextEditingController(text: studentService.faculty);
    _specialtyController = TextEditingController(text: studentService.specialty);
    _programController = TextEditingController(text: studentService.program ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _yearController.dispose();
    _facultyController.dispose();
    _specialtyController.dispose();
    _programController.dispose();
    _skillController.dispose();
    super.dispose();
  }

  Future<void> _pickCV() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          studentService.cvFileName = result.files.single.name;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("File selected: ${studentService.cvFileName}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to pick file"), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _pickProfileImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true, // Essential for Web to get bytes
      );

      if (result != null) {
        setState(() {
          studentService.profileImageBytes = result.files.single.bytes;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile image updated!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to pick image"), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _pickVerification() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
        withData: true,
      );

      if (result != null) {
        setState(() {
          studentService.verificationFileName = result.files.single.name;
          studentService.verificationFileData = result.files.single.bytes;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Verification document uploaded!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to pick file"), backgroundColor: Colors.red),
      );
    }
  }

  void _toggleEditMode() {
    if (_isEditMode) {
      // Save data back to service
      setState(() {
        studentService.name = _nameController.text;
        studentService.graduationYear = _yearController.text;
        studentService.faculty = _facultyController.text;
        studentService.specialty = _specialtyController.text;
        studentService.program = _programController.text;
        _isEditMode = false;
      });
    } else {
      setState(() {
        _isEditMode = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appLocalization,
      builder: (context, child) {
        bool isAr = appLocalization.locale.languageCode == 'ar';
        return Scaffold(
          backgroundColor: grayBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFFDA00C), size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo.png', 
                      height: 35, width: 35, 
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => const Icon(Icons.business, color: Color(0xFF1E3A5F)),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              LanguageToggle(),
              IconButton(
                icon: const Icon(Icons.notifications_active_outlined, color: Color(0xFFFDA00C)),
                onPressed: () {},
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: Directionality(
            textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildProfileHeader(),
                  const SizedBox(height: 30),
                  const Divider(indent: 50, endIndent: 50, thickness: 1),
                  const SizedBox(height: 20),
                  
                  // Skills and CV Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Skills Section
                        Expanded(child: _buildSkillsSection()),
                        const SizedBox(width: 20),
                        // CV Section
                        Expanded(child: _buildCVSection()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50), 
                ],
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomNav(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _toggleEditMode,
            backgroundColor: primaryBlue,
            icon: Icon(_isEditMode ? Icons.check : Icons.edit),
            label: Text(_isEditMode ? (isAr ? "حفظ" : "Save") : (isAr ? "تعديل" : "Edit")),
          ),
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: 2, // Profile is index 2
          onTap: (index) {
            if (index == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ApplicationsScreen()));
            } else if (index == 1) {
              Navigator.pop(context); // Go back to Home
            }
          },
          backgroundColor: Colors.white,
          selectedItemColor: primaryBlue,
          unselectedItemColor: primaryBlue.withOpacity(0.5),
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.doc_text), label: "Applications"),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    bool isAr = appLocalization.locale.languageCode == 'ar';
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: studentService.profileImageBytes != null
                    ? MemoryImage(studentService.profileImageBytes!)
                    : AssetImage(studentService.profileImage) as ImageProvider,
              ),
            ),
            if (_isEditMode)
              GestureDetector(
                onTap: _pickProfileImage,
                child: Container(
                  margin: const EdgeInsets.only(right: 5, bottom: 5),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                  child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                ),
              ),
          ],
        ),
        const SizedBox(height: 15),
        
        // Name
        if (_isEditMode)
          _buildEditField(_nameController, fontSize: 24, fontWeight: FontWeight.bold)
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(studentService.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              if (studentService.isVerified) ...[
                const SizedBox(width: 8),
                const Icon(Icons.verified, color: Colors.blue, size: 20),
              ],
            ],
          ),
        
        const SizedBox(height: 10),

        // Verification Status Bar
        if (!studentService.isVerified) ...[
          GestureDetector(
            onTap: _pickVerification,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.upload_file, size: 14, color: Colors.orange),
                  const SizedBox(width: 5),
                  Text(
                    isAr ? "ارفع إثبات القيد للتوثيق" : "Upload verification doc",
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        
        // Education Details
        if (_isEditMode) ...[
          _buildEditField(_facultyController, showPencil: true),
          _buildEditField(_specialtyController, showPencil: true),
          _buildEditField(_programController, showPencil: true, hint: isAr ? "البرنامج" : "Program"),
          _buildEditField(_yearController, prefix: isAr ? "سنة التخرج: " : "Graduated in ", showPencil: true),
        ] else ...[
          Text(studentService.faculty, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
          Text(studentService.specialty, style: const TextStyle(color: Colors.grey)),
          if (studentService.program != null && studentService.program!.isNotEmpty)
            Text("${isAr ? "برنامج" : "Program"}: ${studentService.program}", style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text("${isAr ? "سنة التخرج" : "Graduated in"} ${studentService.graduationYear}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 5),
          Text(studentService.email, style: const TextStyle(color: Colors.blueGrey, fontSize: 13)),
        ],
      ],
    );
  }

  Widget _buildEditField(TextEditingController controller, {double fontSize = 14, FontWeight fontWeight = FontWeight.normal, String prefix = "", bool showPencil = false, String hint = ""}) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(bottom: 5),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          prefixText: prefix,
          suffixIcon: showPencil ? const Icon(Icons.edit, size: 14, color: Colors.blueAccent) : null,
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent, width: 1)),
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      children: [
        Text(appLocalization.translate('skills'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: studentService.skills.map((skill) => _buildSkillChip(skill)).toList(),
              ),
              if (_isEditMode) ...[
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _skillController,
                        decoration: const InputDecoration(
                          hintText: "Add skill...",
                          isDense: true,
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.blue),
                      onPressed: () {
                        if (_skillController.text.isNotEmpty) {
                          setState(() {
                            studentService.skills.add(_skillController.text);
                            _skillController.clear();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(skill, style: const TextStyle(fontSize: 12, color: Colors.black87)),
          if (_isEditMode) ...[
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () => setState(() => studentService.skills.remove(skill)),
              child: const Icon(Icons.close, size: 14, color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCVSection() {
    return Column(
      children: [
        Text(appLocalization.translate('cv'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Container(
          height: 150,
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.description, size: 50, color: Colors.grey.shade400),
              if (studentService.cvFileName != null)
                Positioned(
                  top: 10,
                  child: Text(
                    studentService.cvFileName!,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Icon(Icons.visibility, color: Colors.grey.shade600, size: 18),
              ),
              if (_isEditMode)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickCV,
                    child: Icon(Icons.edit, color: Colors.grey.shade600, size: 18),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
