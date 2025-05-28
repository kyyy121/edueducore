import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../controllers/calendar_controller.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCalendar(),
            _buildEventsList(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF5E5C4),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        "Kalender SpenMa",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black, size: 20),
          onPressed: () => controller.searchEvents(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF5E5C4),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Aktivitas Sekolah",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Obx(() => Text(
                    "${controller.selectedMonth.value} ${controller.selectedYear.value}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  )),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                const Icon(
                  Icons.event_note,
                  color: Colors.black,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Obx(() => Text(
                      "${controller.totalEvents.value} Acara",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() => TableCalendar(
              focusedDay: controller.focusedDay.value,
              firstDay: DateTime(2023, 1, 1),
              lastDay: DateTime(2027, 12, 31),
              calendarFormat: controller.calendarFormat.value,
              eventLoader: controller.getEventsForDay,
              selectedDayPredicate: (day) {
                return isSameDay(controller.selectedDay.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                controller.onDaySelected(selectedDay, focusedDay);
              },
              onFormatChanged: (format) {
                controller.calendarFormat.value = format;
              },
              onPageChanged: (focusedDay) {
                controller.focusedDay.value = focusedDay;
                controller.updateSelectedMonthYear(focusedDay);
              },
              calendarStyle: CalendarStyle(
                outsideDaysVisible: true,
                markersMaxCount: 2,
                markerSize: 5,
                markerDecoration: const BoxDecoration(
                  color: Color(0xFF053158),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Color(0xFFBE5B50),
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: const Color(0xFFBE5B50).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                cellMargin: const EdgeInsets.all(4),
                cellPadding: const EdgeInsets.all(2),
                defaultTextStyle: const TextStyle(fontSize: 12),
                weekendTextStyle: const TextStyle(fontSize: 12, color: Color(0xFFBE5B50)),
                outsideTextStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                selectedTextStyle: const TextStyle(fontSize: 12, color: Colors.white),
                todayTextStyle: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFF053158), size: 18),
                rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFF053158), size: 18),
                headerPadding: EdgeInsets.symmetric(vertical: 8),
                headerMargin: EdgeInsets.only(bottom: 8),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                weekendStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFBE5B50)),
              ),
              rowHeight: 36,
              daysOfWeekHeight: 20,
            )),
      ),
    );
  }

  Widget _buildEventsList() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Kegiatan Terjadwal",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF053158),
                  ),
                ),
                TextButton(
                  onPressed: () => controller.viewAllEvents(),
                  child: const Text(
                    "Lihat Semua",
                    style: TextStyle(
                      color: Color(0xFFBE5B50),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (controller.selectedEvents.isEmpty) {
                  return _buildEmptyState();
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.selectedEvents.length,
                  itemBuilder: (context, index) {
                    final event = controller.selectedEvents[index];
                    return _buildEventCard(event);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo/icons/empty_calendar.png',
            width: 80,
            height: 80,
            color: Colors.grey.withOpacity(0.6),
          ),
          const SizedBox(height: 12),
          Obx(() => Text(
                "Tidak ada kegiatan pada ${DateFormat('d MMMM yyyy', 'id_ID').format(controller.selectedDay.value)}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              )),
          const SizedBox(height: 6),
          const Text(
            "Pilih tanggal lain untuk melihat kegiatan",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    Color categoryColor = _getCategoryColor(event['category']);
    IconData categoryIcon = _getCategoryIcon(event['category']);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => controller.viewEventDetails(event),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  categoryIcon,
                  color: categoryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 12,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${event['startTime']} - ${event['endTime']}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          event['location'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  event['category'],
                  style: TextStyle(
                    color: categoryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'akademik':
        return Colors.blue;
      case 'lomba':
        return Colors.amber;
      case 'perayaan':
        return Colors.purple;
      case 'rapat':
        return Colors.teal;
      case 'upacara':
        return const Color(0xFF053158);
      default:
        return const Color(0xFFBE5B50);
    }
  }
  
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'akademik':
        return Icons.school;
      case 'lomba':
        return Icons.emoji_events;
      case 'perayaan':
        return Icons.celebration;
      case 'rapat':
        return Icons.groups;
      case 'upacara':
        return Icons.flag;
      default:
        return Icons.event;
    }
  }
}