import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/starting_controller.dart';
import 'package:flutter/services.dart';

class StartingView extends GetView<StartingController> {
  const StartingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sistem UI overlay untuk status bar (opsional)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFBE5B50),
              ),
            );
          }
          
          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate([
                  _buildMonthSelector(),
                  _buildAttendanceSummaryCard(),
                  _buildWeeklyChart(context),
                  _buildDailyAttendanceList(),
                ]),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF053158),
                Color(0xFF0A4E8D),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFF053158),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.studentName.value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NIS: ${controller.studentId.value} | ${controller.studentClass.value}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildAttendancePercentageBadge(),
                ],
              ),
            ),
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
      ),
    );
  }

  Widget _buildAttendancePercentageBadge() {
    final percentage = controller.getAttendancePercentage();
    Color badgeColor;
    
    // Warna berdasarkan persentase kehadiran
    if (percentage >= 90) {
      badgeColor = Colors.green;
    } else if (percentage >= 75) {
      badgeColor = Colors.amber;
    } else {
      badgeColor = const Color(0xFFBE5B50);
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: badgeColor.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        'Kehadiran: ${percentage.toStringAsFixed(1)}%',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMonthChangeButton(
            onPressed: () => controller.changeMonth(-1),
            icon: Icons.arrow_back_ios_new_rounded,
          ),
          Obx(() => Text(
            controller.formatMonthYear(controller.selectedMonth.value),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF053158),
            ),
          )),
          _buildMonthChangeButton(
            onPressed: () => controller.changeMonth(1),
            icon: Icons.arrow_forward_ios_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildMonthChangeButton({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F2F5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            size: 18,
            color: const Color(0xFF053158),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceSummaryCard() {
    final monthlySummary = controller.getMonthlySummary();
    
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardTitle('Ringkasan Bulanan', Icons.calendar_month),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusSummary('Hadir', monthlySummary['hadir'] ?? 0, Icons.check_circle, Colors.green),
                _buildStatusSummary('Sakit', monthlySummary['sakit'] ?? 0, Icons.healing, Colors.orange),
                _buildStatusSummary('Izin', monthlySummary['izin'] ?? 0, Icons.event_note, Colors.blue),
                _buildStatusSummary('Alpha', monthlySummary['alpha'] ?? 0, Icons.cancel, const Color(0xFFBE5B50)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF053158),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSummary(String title, int count, IconData icon, Color color) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardTitle('Grafik Mingguan', Icons.bar_chart),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: _buildWeeklyBarChart(context),
            ),
            const SizedBox(height: 16),
            _buildChartLegends(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyBarChart(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final barWidth = (screenWidth - 80) / (controller.weeklyStats.length * 2);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(controller.weeklyStats.length, (index) {
        final weekData = controller.weeklyStats[index];
        final Map<String, int> stats = weekData['stats'];
        
        // Menentukan tinggi maksimum yang aman
        final int maxVal = [
          stats['hadir'] ?? 0,
          stats['sakit'] ?? 0,
          stats['izin'] ?? 0,
          stats['alpha'] ?? 0,
        ].reduce((curr, next) => curr > next ? curr : next);
        
        final int maxHeight = 140;
        final int safeMaxValue = maxVal > 0 ? maxVal : 1; // Mencegah pembagian dengan nol
        
        // Menghitung tinggi bar yang proporsional
        final double hadirHeight = stats['hadir']! > 0 ? (stats['hadir']! / safeMaxValue) * maxHeight : 0;
        final double sakitHeight = stats['sakit']! > 0 ? (stats['sakit']! / safeMaxValue) * maxHeight : 0;
        final double izinHeight = stats['izin']! > 0 ? (stats['izin']! / safeMaxValue) * maxHeight : 0;
        final double alphaHeight = stats['alpha']! > 0 ? (stats['alpha']! / safeMaxValue) * maxHeight : 0;
        
        return Column(
          children: [
            SizedBox(
              width: barWidth * 1.8,
              child: Column(
                children: [
                  if (alphaHeight > 0) _buildStackedBar(alphaHeight, const Color(0xFFBE5B50), barWidth),
                  if (izinHeight > 0) _buildStackedBar(izinHeight, Colors.blue, barWidth),
                  if (sakitHeight > 0) _buildStackedBar(sakitHeight, Colors.orange, barWidth),
                  if (hadirHeight > 0) _buildStackedBar(hadirHeight, Colors.green, barWidth),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Minggu ${weekData['week']}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStackedBar(double height, Color color, double width) {
    // Menerapkan nilai minimum untuk tampilan visual
    final double minHeight = height > 0 && height < 5 ? 5 : height;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: minHeight,
      width: width,
      margin: const EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildChartLegends() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        _buildChartLegend('Hadir', Colors.green),
        _buildChartLegend('Sakit', Colors.orange),
        _buildChartLegend('Izin', Colors.blue),
        _buildChartLegend('Alpha', const Color(0xFFBE5B50)),
      ],
    );
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDailyAttendanceList() {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardTitle('Detail Absensi Harian', Icons.list_alt),
            const SizedBox(height: 16),
            _buildFilterChips(),
            const SizedBox(height: 12),
            ...controller.monthlyAttendance.map((attendance) {
              final DateTime date = attendance['date'];
              final String status = attendance['status'];
              final String notes = attendance['notes'];
              
              // Jika libur, tidak perlu ditampilkan
              if (status == 'libur') {
                return const SizedBox.shrink();
              }
              
              return _buildAttendanceItem(date, status, notes);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final List<String> filters = ['Semua', 'Hadir', 'Sakit', 'Izin', 'Alpha'];
    
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final String filter = filters[index];
          return Obx(() {
            final bool isSelected = controller.selectedFilter.value == filter.toLowerCase();
            
            return FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                controller.selectedFilter.value = selected ? filter.toLowerCase() : 'semua';
              },
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              backgroundColor: Colors.grey.shade100,
              selectedColor: _getStatusColor(filter.toLowerCase()),
              checkmarkColor: Colors.white,
            );
          });
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'hadir':
        return Colors.green;
      case 'sakit':
        return Colors.orange;
      case 'izin':
        return Colors.blue;
      case 'alpha':
        return const Color(0xFFBE5B50);
      default:
        return const Color(0xFF053158);
    }
  }

  Widget _buildAttendanceItem(DateTime date, String status, String notes) {
    // Filter berdasarkan status
    if (controller.selectedFilter.value != 'semua' && 
        controller.selectedFilter.value != status) {
      return const SizedBox.shrink();
    }
    
    // Definisikan warna dan ikon berdasarkan status
    final IconData icon = _getStatusIcon(status);
    final Color color = _getStatusColor(status);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            // Tampilkan detail jika diperlukan
            Get.dialog(
              AlertDialog(
                title: Text('Detail Absensi - ${controller.formatDate(date)}'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status: ${status.capitalize}'),
                    const SizedBox(height: 8),
                    Text('Catatan: $notes'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Tutup'),
                  ),
                ],
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.formatShortDate(date),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        status.capitalize!,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    notes,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'hadir':
        return Icons.check_circle;
      case 'sakit':
        return Icons.healing;
      case 'izin':
        return Icons.event_note;
      case 'alpha':
        return Icons.cancel;
      case 'libur':
        return Icons.weekend;
      default:
        return Icons.help_outline;
    }
  }
}