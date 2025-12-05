import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/home_welcome_card.dart';
import '../widgets/section_header.dart';
import '../widgets/class_card.dart';
import '../widgets/exam_card.dart';
import '../widgets/study_goal_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/empty_state_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Mock data - replace with your actual data
  final List<Map<String, dynamic>> _classes = [
    {
      'subject': 'Mathematics',
      'time': '09:00 AM - 10:30 AM',
      'teacher': 'Dr. Smith',
      'room': 'Room 301',
      'color': Colors.blue,
    },
    {
      'subject': 'Physics',
      'time': '11:00 AM - 12:30 PM',
      'teacher': 'Prof. Johnson',
      'room': 'Lab 205',
      'color': Colors.red,
    },
  ];

  final Map<String, dynamic> _exam = {
    'subject': 'Mathematics Final',
    'date': 'Dec 20, 2024',
    'daysLeft': 5,
  };

  final List<StudyGoal> _studyGoals = [
    StudyGoal(task: 'Read Physics Chapter 5', progress: 0.6),
    StudyGoal(task: 'Solve Math Problems', progress: 0.3),
    StudyGoal(task: 'Prepare Chemistry Lab', progress: 0.8),
  ];

  final List<QuickAction> _quickActions = [
    QuickAction(
      title: 'Add Routine',
      icon: Icons.schedule,
      color: Colors.blue,
      onTap: () {},
    ),
    QuickAction(
      title: 'Add Exam',
      icon: Icons.assignment,
      color: Colors.red,
      onTap: () {},
    ),
    QuickAction(
      title: 'Add Note',
      icon: Icons.note_add,
      color: Colors.purple,
      onTap: () {},
    ),
    QuickAction(
      title: 'Add Task',
      icon: Icons.task,
      color: Colors.orange,
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Smart Edu',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined),
                  color: Colors.blue,
                ),
              ],
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Card
                    const HomeWelcomeCard(),
                    const SizedBox(height: 20),

                    // Today's Classes Section
                    SectionHeader(
                      title: "Today's Classes",
                      icon: Icons.schedule,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    _buildTodaysClasses(),

                    const SizedBox(height: 24),

                    // Next Exam Section
                    SectionHeader(
                      title: "Next Exam Countdown",
                      icon: Icons.assignment,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    _buildNextExam(),

                    const SizedBox(height: 24),

                    // Study Goals Section
                    SectionHeader(
                      title: "Today's Study Goals",
                      icon: Icons.flag,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 12),
                    _buildStudyGoals(),

                    const SizedBox(height: 24),

                    // Quick Actions
                    SectionHeader(
                      title: "Quick Actions",
                      icon: Icons.bolt,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 12),
                    _buildQuickActions(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaysClasses() {
    if (_classes.isEmpty) {
      return EmptyStateCard(
        icon: Icons.schedule_outlined,
        title: 'No classes today',
        subtitle: 'Tap to add your routine',
        color: Colors.blue,
        onTap: () {},
      );
    }

    return Column(
      children: _classes.map((cls) {
        return ClassCard(
          subject: cls['subject'],
          time: cls['time'],
          teacher: cls['teacher'],
          room: cls['room'],
          color: cls['color'],
        );
      }).toList(),
    );
  }

  Widget _buildNextExam() {
    if (_exam['daysLeft'] == null) {
      return EmptyStateCard(
        icon: Icons.assignment_outlined,
        title: 'No exams yet',
        subtitle: 'Add exam schedule',
        color: Colors.red,
        onTap: () {},
      );
    }

    return ExamCard(
      subject: _exam['subject'],
      date: _exam['date'],
      daysLeft: _exam['daysLeft'],
    );
  }

  Widget _buildStudyGoals() {
    if (_studyGoals.isEmpty) {
      return EmptyStateCard(
        icon: Icons.flag_outlined,
        title: 'No study goals',
        subtitle: 'Set your study goal to stay focused',
        color: Colors.green,
        onTap: () {},
      );
    }

    // Calculate overall progress
    final overallProgress = _studyGoals
        .map((goal) => goal.progress)
        .reduce((a, b) => a + b) /
        _studyGoals.length;

    return StudyGoalsCard(
      goals: _studyGoals,
      overallProgress: overallProgress,
    );
  }

  Widget _buildQuickActions() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: _quickActions.length,
      itemBuilder: (context, index) {
        return QuickActionCard(action: _quickActions[index]);
      },
    );
  }
}