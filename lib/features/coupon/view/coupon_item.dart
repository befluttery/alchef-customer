import 'dart:ui';
import 'package:alchef/core/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:alchef/config/app_images.dart';
import 'dart:math' as math;

import 'package:alchef/features/coupon/model/coupon_model.dart';

class CouponItem extends StatelessWidget {
  const CouponItem({super.key, required this.coupon, required this.onSelect});

  final Coupon coupon;
  final Function(Coupon coupon) onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect(coupon),
      child: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CustomPaint(
            painter: DashedBorderPainter(
              color: Theme.of(context).colorScheme.primary,
              strokeWidth: 2,
              dashWidth: 6,
              dashSpace: 4,
              borderRadius: 12,
              notchRadius: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  SizedBox(width: 24),
                  Image.asset(AppImages.percentageIcon, height: 40),
                  // Offer details
                  SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Code with copy button
                        Row(
                          children: [
                            Text(
                              coupon.couponCode,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                            // const SizedBox(width: 8),
                            // InkWell(
                            //   onTap: () {
                            //     Clipboard.setData(
                            //       ClipboardData(text: coupon.code),
                            //     );
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //         content: Text(
                            //           'Code copied: ${coupon.code}',
                            //         ),
                            //         duration: const Duration(seconds: 2),
                            //         behavior: SnackBarBehavior.floating,
                            //       ),
                            //     );
                            //   },
                            //   borderRadius: BorderRadius.circular(4),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(4),
                            //     child: Image.asset(
                            //       AppImages.copyIcon,
                            //       height: 20.sp,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Title
                        Text(
                          coupon.couponName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6),
                        if (coupon.couponPercentage > 0) ...[
                          Text(
                            'Percentage (%) : ${coupon.couponPercentage}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 6),
                        ],
                        Text(
                          'Valid Until : ${DateHelper.formatDate(coupon.isExpire)}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Ticket shape clipper with notches on left and right
class TicketClipper extends CustomClipper<Path> {
  final double notchRadius;
  final double borderRadius;

  TicketClipper({this.notchRadius = 12.0, this.borderRadius = 12.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    final double midHeight = size.height / 2;

    // Start from top-left (after corner radius)
    path.moveTo(borderRadius, 0);

    // Top edge
    path.lineTo(size.width - borderRadius, 0);

    // Top-right corner
    path.arcToPoint(
      Offset(size.width, borderRadius),
      radius: Radius.circular(borderRadius),
      clockwise: true,
    );

    // Right edge - top part (before notch)
    path.lineTo(size.width, midHeight - notchRadius);

    // Right notch (semicircle cutout going inward)
    path.arcToPoint(
      Offset(size.width, midHeight + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Right edge - bottom part (after notch)
    path.lineTo(size.width, size.height - borderRadius);

    // Bottom-right corner
    path.arcToPoint(
      Offset(size.width - borderRadius, size.height),
      radius: Radius.circular(borderRadius),
      clockwise: true,
    );

    // Bottom edge
    path.lineTo(borderRadius, size.height);

    // Bottom-left corner
    path.arcToPoint(
      Offset(0, size.height - borderRadius),
      radius: Radius.circular(borderRadius),
      clockwise: true,
    );

    // Left edge - bottom part (before notch)
    path.lineTo(0, midHeight + notchRadius);

    // Left notch (semicircle cutout going inward)
    path.arcToPoint(
      Offset(0, midHeight - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Left edge - top part (after notch)
    path.lineTo(0, borderRadius);

    // Top-left corner
    path.arcToPoint(
      Offset(borderRadius, 0),
      radius: Radius.circular(borderRadius),
      clockwise: true,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) => false;
}

// Dashed border painter
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;
  final double notchRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 2,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.borderRadius = 12,
    this.notchRadius = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = _createTicketPath(size);
    final dashPath = _createDashedPath(path);
    canvas.drawPath(dashPath, paint);
  }

  Path _createTicketPath(Size size) {
    final path = Path();
    final double midHeight = size.height / 2;

    path.moveTo(borderRadius, 0);
    path.lineTo(size.width - borderRadius, 0);
    path.arcToPoint(
      Offset(size.width, borderRadius),
      radius: Radius.circular(borderRadius),
      clockwise: true,
    );
    path.lineTo(size.width, midHeight - notchRadius);
    path.arcToPoint(
      Offset(size.width, midHeight + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height - borderRadius);
    path.arcToPoint(
      Offset(size.width - borderRadius, size.height),
      radius: Radius.circular(borderRadius),
      clockwise: true,
    );
    path.lineTo(borderRadius, size.height);
    path.arcToPoint(
      Offset(0, size.height - borderRadius),
      radius: Radius.circular(borderRadius),
      clockwise: true,
    );
    path.lineTo(0, midHeight + notchRadius);
    path.arcToPoint(
      Offset(0, midHeight - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(0, borderRadius);
    path.arcToPoint(
      Offset(borderRadius, 0),
      radius: Radius.circular(borderRadius),
      clockwise: true,
    );
    path.close();

    return path;
  }

  Path _createDashedPath(Path source) {
    final Path dashPath = Path();
    final PathMetrics pathMetrics = source.computeMetrics();

    for (final PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;

      while (distance < pathMetric.length) {
        final double length = draw ? dashWidth : dashSpace;
        if (distance + length > pathMetric.length) {
          if (draw) {
            dashPath.addPath(
              pathMetric.extractPath(distance, pathMetric.length),
              Offset.zero,
            );
          }
          break;
        }

        if (draw) {
          dashPath.addPath(
            pathMetric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }

        distance += length;
        draw = !draw;
      }
    }

    return dashPath;
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) => false;
}

// Star badge painter
class StarBadgePainter extends CustomPainter {
  final Color color;

  StarBadgePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final path = Path();
    const int points = 8;
    const double outerRadius = 1.0;
    const double innerRadius = 0.88;

    for (int i = 0; i < points * 2; i++) {
      final double angle = (i * math.pi) / points - math.pi / 2;
      final double r = (i % 2 == 0 ? outerRadius : innerRadius) * radius;
      final double x = center.dx + r * math.cos(angle);
      final double y = center.dy + r * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(StarBadgePainter oldDelegate) => false;
}
