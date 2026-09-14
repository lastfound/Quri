import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/features/profile/presentation/profile_screen.dart';
import 'package:frontend/features/shop/presentation/shop_screen.dart';

/// Layar Leaderboard / Peringkat Liga (Rank Screen) sesuai desain Quri.
class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header Title ──────────────────────────────────────────────
              const Center(
                child: Text(
                  'Leaderboard',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF134A3E),
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Center(
                child: Text(
                  'SISA WAKTU LIGA: 2 HARI 14 JAM',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F6B5C),
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Liga Badges Carousel (Bronze, Silver, Gold, Diamond, Ruby) ──
              const _LeagueBadgesRow(),
              const SizedBox(height: 32),

              // ── Table Column Header ────────────────────────────────────────
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOP LEARNERS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF6B7570),
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      'TOTAL XP',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF6B7570),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ── Zona Naik Liga Indicator ──────────────────────────────────
              _buildZoneIndicator(
                icon: Icons.trending_up_rounded,
                label: 'ZONA NAIK LIGA',
                color: const Color(0xFF4ADE80),
              ),
              const SizedBox(height: 8),

              // ── Rank 1: Ahmad R. ──────────────────────────────────────────
              _buildRankCardWithVerticalBar(
                indicatorColor: const Color(0xFF4ADE80),
                child: const _LearnerCard(
                  rank: 1,
                  name: 'Ahmad R.',
                  xpText: '12,450 XP',
                  imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
                  avatarFallbackText: 'AR',
                ),
              ),
              const SizedBox(height: 12),

              // ── Rank 2: Sarah K. ──────────────────────────────────────────
              _buildRankCardWithVerticalBar(
                indicatorColor: const Color(0xFF4ADE80),
                child: const _LearnerCard(
                  rank: 2,
                  name: 'Sarah K.',
                  xpText: '11,200 XP',
                  imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
                  avatarFallbackText: 'SK',
                ),
              ),
              const SizedBox(height: 14),

              // ── Divider Garis Abu-abu Tengah ─────────────────────────────
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDED8CB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // ── Rank 3: Omar F. ───────────────────────────────────────────
              const _LearnerCard(
                rank: 3,
                name: 'Omar F.',
                xpText: '10,850 XP',
                imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
                avatarFallbackText: 'OF',
              ),
              const SizedBox(height: 12),

              // ── Rank 4: You (Highlighted Card) ────────────────────────────
              const _LearnerCard(
                rank: 4,
                name: 'You',
                xpText: '9,750 XP',
                imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150',
                avatarFallbackText: 'YOU',
                isCurrentUser: true,
              ),
              const SizedBox(height: 20),

              // ── Zona Turun Liga Indicator ─────────────────────────────────
              _buildZoneIndicator(
                icon: Icons.trending_down_rounded,
                label: 'ZONA TURUN LIGA',
                color: const Color(0xFFFCA5A5),
              ),
              const SizedBox(height: 8),

              // ── Rank 5: Mariam T. ─────────────────────────────────────────
              _buildRankCardWithVerticalBar(
                indicatorColor: const Color(0xFFFCA5A5),
                child: const _LearnerCard(
                  rank: 5,
                  name: 'Mariam T.',
                  xpText: '9,100 XP',
                  initialOnly: 'M',
                ),
              ),
              const SizedBox(height: 20),

              // ── Card Promo Quran Pass (Unlimited Hearts) ──────────────────
              _QuranPassBanner(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ShopScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────────────────────────────────
      bottomNavigationBar: _RankBottomNavBar(
        onItemTapped: (index) {
          if (index == 0) {
            // Learn -> Kembali ke HomeScreen
            Navigator.of(context).pop();
          } else if (index == 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🎯 Quests harian segera hadir!'),
                backgroundColor: Color(0xFF134A3E),
              ),
            );
          } else if (index == 3) {
            // Shop
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const ShopScreen()),
            );
          } else if (index == 4) {
            // Profile
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }

  static Widget _buildZoneIndicator({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildRankCardWithVerticalBar({
    required Color indicatorColor,
    required Widget child,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        // Vertical indicator bar di samping kiri
        Positioned(
          left: -4,
          top: 10,
          bottom: 10,
          child: Container(
            width: 4,
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// League Badges Row (Bronze, Silver, Gold, Diamond, Ruby)
// ─────────────────────────────────────────────────────────────────────────────

class _LeagueBadgesRow extends StatelessWidget {
  const _LeagueBadgesRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _BadgeItem(icon: Icons.shield_outlined, label: 'Bronze'),
          _BadgeItem(icon: Icons.shield_outlined, label: 'Silver'),
          _BadgeItem(
            icon: Icons.military_tech_outlined,
            label: 'Gold',
            isCurrent: true,
          ),
          _BadgeItem(icon: Icons.diamond_outlined, label: 'Diamond'),
          _BadgeItem(icon: Icons.diamond_outlined, label: 'Ruby'),
        ],
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isCurrent;

  const _BadgeItem({
    required this.icon,
    required this.label,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isCurrent ? const Color(0xFFD4AF37) : const Color(0xFFE2DDD3);
    final iconColor = isCurrent ? const Color(0xFFC79A26) : const Color(0xFFBEB8AC);
    final textColor = isCurrent ? const Color(0xFFC79A26) : const Color(0xFFA8A296);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCurrent ? const Color(0xFFFFFBEB) : const Color(0xFFF0EBE0),
            border: Border.all(color: borderColor, width: isCurrent ? 2.0 : 1.5),
            boxShadow: isCurrent
                ? [
                    BoxShadow(
                      color: const Color(0xFFC79A26).withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Learner Card (Single Rank Row)
// ─────────────────────────────────────────────────────────────────────────────

class _LearnerCard extends StatelessWidget {
  final int rank;
  final String name;
  final String xpText;
  final String? imageUrl;
  final String? avatarFallbackText;
  final String? initialOnly;
  final bool isCurrentUser;

  const _LearnerCard({
    required this.rank,
    required this.name,
    required this.xpText,
    this.imageUrl,
    this.avatarFallbackText,
    this.initialOnly,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCurrentUser ? const Color(0xFF0F473A) : const Color(0xFFEDE8DD),
          width: isCurrentUser ? 2.5 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isCurrentUser
                ? const Color(0xFF0F473A).withValues(alpha: 0.12)
                : Colors.black.withValues(alpha: 0.03),
            blurRadius: isCurrentUser ? 6 : 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank Number
          SizedBox(
            width: 28,
            child: Text(
              '$rank',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
                color: isCurrentUser ? const Color(0xFF0F473A) : const Color(0xFF8F9893),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Avatar
          _buildAvatar(),
          const SizedBox(width: 14),

          // Name
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isCurrentUser ? const Color(0xFF0F473A) : const Color(0xFF1E2623),
              ),
            ),
          ),

          // XP Text
          Text(
            xpText,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: isCurrentUser ? const Color(0xFF0F473A) : const Color(0xFF26302B),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    if (initialOnly != null) {
      return Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFE5DFD5),
        ),
        alignment: Alignment.center,
        child: Text(
          initialOnly!,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF7A756D),
          ),
        ),
      );
    }

    Widget imageWidget;
    if (imageUrl != null) {
      imageWidget = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallbackAvatar(),
      );
    } else {
      imageWidget = _buildFallbackAvatar();
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isCurrentUser ? const Color(0xFF0F473A) : const Color(0xFFE2DDD3),
          width: isCurrentUser ? 2.5 : 1.5,
        ),
      ),
      child: ClipOval(child: imageWidget),
    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      color: const Color(0xFFD7EFE6),
      alignment: Alignment.center,
      child: Text(
        avatarFallbackText ?? name.substring(0, 1),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: AppColors.teal,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Quran Pass Banner (Unlimited Hearts)
// ─────────────────────────────────────────────────────────────────────────────

class _QuranPassBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _QuranPassBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFECE7DD), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              // Lingkaran Hati Kuning/Emas
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFFBEB),
                ),
                child: const Icon(
                  Icons.favorite_border_rounded,
                  color: Color(0xFFC79A26),
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),

              // Title & Subtitle
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kehabisan nyawa untuk kejar XP?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E2623),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Dapatkan Unlimited Hearts di Quran Pass.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7A8580),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Tombol Emas "Dapatkan Pass"
          SizedBox(
            height: 46,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC79A26),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Dapatkan Pass',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Custom Bottom Navigation Bar
// ─────────────────────────────────────────────────────────────────────────────

class _RankBottomNavBar extends StatelessWidget {
  final ValueChanged<int> onItemTapped;

  const _RankBottomNavBar({required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE8E3D8), width: 1.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.menu_book_rounded,
              label: 'Learn',
              isSelected: false,
              onTap: () => onItemTapped(0),
            ),
            _buildNavItem(
              icon: Icons.military_tech_outlined,
              label: 'Quests',
              isSelected: false,
              onTap: () => onItemTapped(1),
            ),
            // Leaderboard (Aktif - Pill Hijau Gelap)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E6555),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bar_chart_rounded, color: Colors.white, size: 22),
                  SizedBox(height: 2),
                  Text(
                    'Leaderboard',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            _buildNavItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Shop',
              isSelected: false,
              onTap: () => onItemTapped(3),
            ),
            _buildNavItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              isSelected: false,
              onTap: () => onItemTapped(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF7D8782), size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7D8782),
              ),
            ),
          ],
        ),
      ),
    );
  }
}