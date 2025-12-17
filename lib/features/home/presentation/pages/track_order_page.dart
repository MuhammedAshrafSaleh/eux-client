import 'package:eux_client/resources/app_color.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OrderTrackingAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: AppSize.s20),
                  const OrderTimeline(),
                  const SizedBox(height: AppSize.s20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTrackingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const OrderTrackingAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text('Order Time Line'),
      centerTitle: true,
    );
  }
}

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          TimelineItem(
            time: '10: 11 PM',
            title: 'Order Placed',
            description: 'Your order #4913 was placed for delivery.',
            isCompleted: true,
          ),
          TimelineItem(
            time: '10: 30 PM',
            title: 'Pending',
            description:
                'Your order is pending for confirmation. Will confirmed within 5 minutes.',
            isCompleted: true,
          ),
          TimelineItem(
            time: '10: 35 PM',
            title: 'Confirmed',
            description: 'Your order is confirmed. Will deliver soon.',
            isCompleted: true,
          ),
          TimelineItem(
            time: '',
            title: 'Processing',
            description: 'Your order is confirmed. Will deliver soon.',
            isCompleted: false,
          ),
          TimelineItem(
            time: '',
            title: 'Delivered',
            description: 'Your order is confirmed. Will deliver soon.',
            isCompleted: false,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String time;
  final String title;
  final String description;
  final bool isCompleted;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.time,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TimeLabel(time: time),
        TimelineIndicator(isCompleted: isCompleted, isLast: isLast),
        const SizedBox(width: 16),
        TimelineContent(title: title, description: description),
      ],
    );
  }
}

class TimeLabel extends StatelessWidget {
  final String time;

  const TimeLabel({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Text(
        time,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class TimelineIndicator extends StatelessWidget {
  final bool isCompleted;
  final bool isLast;

  const TimelineIndicator({
    super.key,
    required this.isCompleted,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatusCircle(isCompleted: isCompleted),
        if (!isLast) const TimelineLine(),
      ],
    );
  }
}

class StatusCircle extends StatelessWidget {
  final bool isCompleted;

  const StatusCircle({super.key, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFF4CAF50) : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: isCompleted
          ? const Icon(Icons.check, color: Colors.white, size: 20)
          : null,
    );
  }
}

class TimelineLine extends StatelessWidget {
  const TimelineLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 2, height: 80, color: Colors.grey[300]);
  }
}

class TimelineContent extends StatelessWidget {
  final String title;
  final String description;

  const TimelineContent({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
