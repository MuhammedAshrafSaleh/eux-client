// import 'package:eux_client/resources/app_color.dart';
// import 'package:eux_client/resources/app_values.dart';
// import 'package:flutter/material.dart';

// class OrderTrackingPage extends StatelessWidget {
//   const OrderTrackingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: OrderTrackingAppBar(),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: AppSize.s20),
//                   const OrderTimeline(),
//                   const SizedBox(height: AppSize.s20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class OrderTrackingAppBar extends StatelessWidget
//     implements PreferredSizeWidget {
//   const OrderTrackingAppBar({super.key});

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: const Text('Order Time Line'),
//       centerTitle: true,
//     );
//   }
// }

// class OrderTimeline extends StatelessWidget {
//   const OrderTimeline({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Column(
//         children: [
//           TimelineItem(
//             time: '10: 11 PM',
//             title: 'Order Placed',
//             description: 'Your order #4913 was placed for delivery.',
//             isCompleted: true,
//           ),
//           TimelineItem(
//             time: '10: 30 PM',
//             title: 'Pending',
//             description:
//                 'Your order is pending for confirmation. Will confirmed within 5 minutes.',
//             isCompleted: true,
//           ),
//           TimelineItem(
//             time: '10: 35 PM',
//             title: 'Confirmed',
//             description: 'Your order is confirmed. Will deliver soon.',
//             isCompleted: true,
//           ),
//           TimelineItem(
//             time: '',
//             title: 'Processing',
//             description: 'Your order is confirmed. Will deliver soon.',
//             isCompleted: false,
//           ),
//           TimelineItem(
//             time: '',
//             title: 'Delivered',
//             description: 'Your order is confirmed. Will deliver soon.',
//             isCompleted: false,
//             isLast: true,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TimelineItem extends StatelessWidget {
//   final String time;
//   final String title;
//   final String description;
//   final bool isCompleted;
//   final bool isLast;

//   const TimelineItem({
//     super.key,
//     required this.time,
//     required this.title,
//     required this.description,
//     required this.isCompleted,
//     this.isLast = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TimeLabel(time: time),
//         TimelineIndicator(isCompleted: isCompleted, isLast: isLast),
//         const SizedBox(width: 16),
//         TimelineContent(title: title, description: description),
//       ],
//     );
//   }
// }

// class TimeLabel extends StatelessWidget {
//   final String time;

//   const TimeLabel({super.key, required this.time});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 70,
//       child: Text(
//         time,
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }

// class TimelineIndicator extends StatelessWidget {
//   final bool isCompleted;
//   final bool isLast;

//   const TimelineIndicator({
//     super.key,
//     required this.isCompleted,
//     required this.isLast,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         StatusCircle(isCompleted: isCompleted),
//         if (!isLast) const TimelineLine(),
//       ],
//     );
//   }
// }

// class StatusCircle extends StatelessWidget {
//   final bool isCompleted;

//   const StatusCircle({super.key, required this.isCompleted});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 32,
//       height: 32,
//       decoration: BoxDecoration(
//         color: isCompleted ? AppColor.primary : AppColor.grey,
//         shape: BoxShape.circle,
//       ),
//       child: isCompleted
//           ? const Icon(Icons.check, color: Colors.white, size: 20)
//           : null,
//     );
//   }
// }

// class TimelineLine extends StatelessWidget {
//   const TimelineLine({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(width: 2, height: 80, color: Colors.grey[300]);
//   }
// }

// class TimelineContent extends StatelessWidget {
//   final String title;
//   final String description;

//   const TimelineContent({
//     super.key,
//     required this.title,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             description,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//               height: 1.4,
//             ),
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }

import 'package:eux_client/features/home/data/tracking_service.dart';
import 'package:eux_client/resources/app_color.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:flutter/material.dart';

class OrderTrackingPage extends StatefulWidget {
  final String billCode; // رقم الطلب

  const OrderTrackingPage({super.key, required this.billCode});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final _trackingService = TrackingService();
  bool _isLoading = false;
  List<TrackingDetail> _trackingDetails = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTracking();
  }

  Future<void> _loadTracking() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await _trackingService.trackOrder(widget.billCode);

      if (result.isSuccess && result.data.isNotEmpty) {
        setState(() {
          _trackingDetails = result.data.first.details;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = result.msg;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OrderTrackingAppBar(onRefresh: _loadTracking),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColor.error),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadTracking,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_trackingDetails.isEmpty) {
      return const Center(child: Text('No tracking information available'));
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: AppSize.s20),
                OrderTimeline(trackingDetails: _trackingDetails),
                const SizedBox(height: AppSize.s20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OrderTrackingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onRefresh;

  const OrderTrackingAppBar({super.key, required this.onRefresh});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text('Order Timeline'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: onRefresh,
        ),
      ],
    );
  }
}

class OrderTimeline extends StatelessWidget {
  final List<TrackingDetail> trackingDetails;

  const OrderTimeline({super.key, required this.trackingDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: List.generate(trackingDetails.length, (index) {
          final detail = trackingDetails[index];
          final isLast = index == trackingDetails.length - 1;

          return TimelineItem(
            time: _formatTime(detail.scanTime),
            title: detail.scanType,
            description: detail.desc,
            location:
                '${detail.scanNetworkCity}, ${detail.scanNetworkProvince}',
            isCompleted: true,
            isLast: isLast,
          );
        }),
      ),
    );
  }

  String _formatTime(String scanTime) {
    try {
      final dateTime = DateTime.parse(scanTime);
      final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = dateTime.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    } catch (e) {
      return scanTime;
    }
  }
}

class TimelineItem extends StatelessWidget {
  final String time;
  final String title;
  final String description;
  final String location;
  final bool isCompleted;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.time,
    required this.title,
    required this.description,
    required this.location,
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
        TimelineContent(
          title: title,
          description: description,
          location: location,
        ),
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
        color: isCompleted ? AppColor.primary : AppColor.grey,
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
  final String location;

  const TimelineContent({
    super.key,
    required this.title,
    required this.description,
    required this.location,
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
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.location_on, size: 14, color: Colors.grey[400]),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
