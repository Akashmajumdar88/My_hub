import 'package:flutter/material.dart';
import '../Core/app_styles.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final TextEditingController _chatController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      "isUser": false,
      "text": "Hi Chaitanya! I'm MyHub AI. I can search smarter, order faster, or book anything for you. What can I do today? 🚀"
    }
  ];

  void _sendMessage() {
    final text = _chatController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"isUser": true, "text": text});
      _chatController.clear();
    });

    // Mock AI reply after a short delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() {
        _messages.add({
          "isUser": false,
          "text": "Analyzing your request to '$text'... As your personal assistant, I'm ready to fetch optimal search results, find the fastest delivery routes, or coordinate your calendar. Let me know which service module you'd like to load!"
        });
      });
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          children: [
            // Dashboard Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: [
                  // User Avatar
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.appPrimaryColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.appPrimaryColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "MC",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  
                  // Greeting titles
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello, Chaitanya!",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          "Your AI workspace is active",
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 13.0,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Notifications Badge Icon
                  IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12.0),
                    
                    // Welcome Banner Card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.appPrimaryColor, Color(0xFF1E60A1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.appPrimaryColor.withOpacity(0.2),
                            blurRadius: 15.0,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Next-Gen Workspace",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            "Coordinate search tools, food deliveries, and transit services inside a unified prompt.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 13.5,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 28.0),
                    
                    // Category Heading
                    const Text(
                      "Explore AI Modules",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    
                    // Responsive Grid of Core Cards
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.25,
                      children: [
                        _buildCategoryCard(
                          context,
                          title: "Search Smarter",
                          icon: Icons.auto_awesome,
                          color: const Color(0xFFE3F2FD),
                          iconColor: const Color(0xFF1E88E5),
                          subtitle: "AI Web Crawl",
                        ),
                        _buildCategoryCard(
                          context,
                          title: "Order Faster",
                          icon: Icons.shopping_bag_outlined,
                          color: const Color(0xFFE8F5E9),
                          iconColor: const Color(0xFF43A047),
                          subtitle: "Food & Items",
                        ),
                        _buildCategoryCard(
                          context,
                          title: "Book Anything",
                          icon: Icons.airplane_ticket_outlined,
                          color: const Color(0xFFFFF3E0),
                          iconColor: const Color(0xFFFB8C00),
                          subtitle: "Rides & Tickets",
                        ),
                        _buildCategoryCard(
                          context,
                          title: "Custom Prompts",
                          icon: Icons.dashboard_customize_outlined,
                          color: const Color(0xFFF3E5F5),
                          iconColor: const Color(0xFF8E24AA),
                          subtitle: "Agent Scripts",
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 28.0),
                    
                    // Console heading
                    const Text(
                      "Live AI Console",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    
                    // Interactive Messages list
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _messages.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12.0),
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        final isUser = msg["isUser"] as bool;
                        return Row(
                          mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            if (!isUser) ...[
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: AppColors.appPrimaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.auto_awesome,
                                  size: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                            ],
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: isUser ? AppColors.appPrimaryColor : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(16.0),
                                    topRight: const Radius.circular(16.0),
                                    bottomLeft: Radius.circular(isUser ? 16.0 : 0),
                                    bottomRight: Radius.circular(isUser ? 0 : 16.0),
                                  ),
                                  border: isUser ? null : Border.all(color: AppColors.borderGrey),
                                ),
                                child: Text(
                                  msg["text"] as String,
                                  style: TextStyle(
                                    color: isUser ? Colors.white : AppColors.textSecondary,
                                    fontSize: 13.5,
                                    height: 1.35,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
            
            // Bottom Prompt Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10.0,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Text field entry
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F3F6),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 14.0),
                          Expanded(
                            child: TextField(
                              controller: _chatController,
                              style: const TextStyle(fontSize: 14.5),
                              onSubmitted: (_) => _sendMessage(),
                              decoration: const InputDecoration(
                                hintText: "Ask MyHub AI anything...",
                                hintStyle: TextStyle(
                                  color: AppColors.textLight,
                                  fontSize: 14.0,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mic_none_rounded,
                              color: AppColors.textLight,
                              size: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  
                  // Send Action Button
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.appPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 18.0,
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
  }

  // Visual card builder for categorized services
  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.borderGrey.withOpacity(0.6)),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 18.0,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.textLight,
                size: 16.0,
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11.5,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
