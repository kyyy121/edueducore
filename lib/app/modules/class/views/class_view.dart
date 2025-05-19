import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/class_controller.dart';

class ClassView extends GetView<ClassController> {
  const ClassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Tab Bar
            _buildTabBar(),
            
            // Tab Content
            Expanded(
              child: Obx(() => controller.currentTabIndex.value == 0
                ? _buildSubjectsTab()
                : _buildAssignmentsTab(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFBE5B50),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppBar Row
          Row(
            children: [
              GestureDetector(
                onTap: controller.backToHome,
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/logo/images/profil.png'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Class information
          Obx(() => Text(
            controller.className.value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )),
          const SizedBox(height: 4),
          
          // Wali kelas
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.white70,
                size: 16,
              ),
              const SizedBox(width: 4),
              Obx(() => Text(
                "Wali Kelas: ${controller.waliKelas.value}",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.changeTab(0),
              child: Container(
                decoration: BoxDecoration(
                  color: controller.currentTabIndex.value == 0
                    ? const Color(0xFF053158)
                    : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Mata Pelajaran",
                    style: TextStyle(
                      color: controller.currentTabIndex.value == 0
                        ? Colors.white
                        : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            )),
          ),
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.changeTab(1),
              child: Container(
                decoration: BoxDecoration(
                  color: controller.currentTabIndex.value == 1
                    ? const Color(0xFF053158)
                    : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Tugas",
                    style: TextStyle(
                      color: controller.currentTabIndex.value == 1
                        ? Colors.white
                        : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSubjectsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      itemCount: controller.subjects.length,
      itemBuilder: (context, index) {
        final subject = controller.subjects[index];
        return GestureDetector(
          onTap: () => controller.viewSubjectDetail(index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header with subject name and completion rate
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Color(subject['color']),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        subject['icon'],
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          subject['name'],
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${subject['completion']}%",
                          style: TextStyle(
                            color: const Color(0xFF053158),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Subject details
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Teacher
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            subject['teacher'],
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Next session
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            subject['next_session'],
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Current material
                      Row(
                        children: [
                          const Icon(
                            Icons.book_outlined,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            subject['material'],
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: subject['completion'] / 100,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(subject['color']),
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildAssignmentsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      itemCount: controller.assignments.length,
      itemBuilder: (context, index) {
        final assignment = controller.assignments[index];
        return GestureDetector(
          onTap: () => controller.viewAssignmentDetail(index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header with subject tag
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(assignment['color']),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          assignment['subject'],
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Status tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: assignment['submitted']
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFFF5722),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          assignment['submitted'] ? "Submitted" : "Pending",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Assignment details
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        assignment['title'],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      // Teacher
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            assignment['teacher'],
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Deadline
                      Row(
                        children: [
                          const Icon(
                            Icons.event,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Deadline: ${assignment['deadline']}",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Description
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.description_outlined,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              assignment['description'],
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Action button
                      if (!assignment['submitted'])
                        GestureDetector(
                          onTap: () => controller.submitAssignment(index),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF053158),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF053158).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "Submit Tugas",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF4CAF50),
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Tugas Telah Dikumpulkan",
                              style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}