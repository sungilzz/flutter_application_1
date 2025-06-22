import 'package:flutter/material.dart';

class SocialSignInButton extends StatelessWidget {
  final String provider;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final String? imageUrl; // For more specific brand logos
  final VoidCallback? onPressed;

  const SocialSignInButton({
    super.key,
    required this.provider,
    required this.backgroundColor,
    this.textColor = Colors.white,
    this.icon,
    this.imageUrl,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          onPressed ??
          () {
            // Mock action
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Sign in with $provider')));
          },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: textColor == Colors.black
              ? BorderSide(color: Colors.grey[300]!)
              : BorderSide.none, // For white buttons with black text
        ),
        elevation: 2,
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 24.0),
            const SizedBox(width: 12.0),
          ] else if (imageUrl != null) ...[
            // Using a basic Image.network for external icons; for a real app,
            // consider SVG assets or dedicated icon packages.
            Image.network(
              imageUrl!,
              height: 24.0,
              width: 24.0,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ); // Fallback icon
              },
            ),
            const SizedBox(width: 12.0),
          ],
          Text('Sign in with $provider'),
        ],
      ),
    );
  }
}
