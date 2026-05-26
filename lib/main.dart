import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager().registerPeriodicTask("usage_check", "usageCheckTask", frequency: Duration(hours: 24));
  runApp(DetoxProApp());
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("جاري فحص استخدام التطبيقات...");
    return Future.value(true);
  });
}

class DetoxProApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detox Pro - علاج إدمان الإنترنت',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue.shade900, Colors.cyan.shade700])),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.health_and_safety, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text('Detox Pro', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 10),
            Text('علاج إدمان الإنترنت', style: TextStyle(fontSize: 18, color: Colors.white70)),
            SizedBox(height: 30),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ]),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _screenTimeMinutes = 0;
  
  @override
  void initState() {
    super.initState();
    _loadScreenTime();
  }
  
  Future<void> _loadScreenTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _screenTimeMinutes = prefs.getInt('screenTime') ?? 0);
  }
  
  Future<void> _addScreenTime(int minutes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _screenTimeMinutes += minutes);
    await prefs.setInt('screenTime', _screenTimeMinutes);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      DashboardScreen(screenTime: _screenTimeMinutes),
      StatisticsScreen(),
      SettingsScreen(addScreenTime: _addScreenTime),
    ];
    
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'الإحصائيات'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final int screenTime;
  const DashboardScreen({required this.screenTime});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة التحكم'), backgroundColor: Colors.blue.shade900, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const Text('وقت استخدام الهاتف اليوم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('${screenTime ~/ 60} ساعة ${screenTime % 60} دقيقة', 
                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue.shade700)),
              ]),
            ),
          ),
          const SizedBox(height: 20),
          const Text('نصائح سريعة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Card(child: ListTile(leading: Icon(Icons.lightbulb_outline, color: Colors.amber), title: Text('خذ استراحة 5 دقائق كل ساعة'))),
          const Card(child: ListTile(leading: Icon(Icons.phone_android, color: Colors.green), title: Text('خفض سطوع الشاشة'))),
        ]),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإحصائيات'), backgroundColor: Colors.blue.shade900, foregroundColor: Colors.white),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            const Text('تقدمك في العلاج', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10,
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: Colors.blue)]),
                  BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 6, color: Colors.blue)]),
                  BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 7, color: Colors.blue)]),
                  BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 5, color: Colors.green)]),
                ],
              )),
            ),
          ]),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final Function(int) addScreenTime;
  const SettingsScreen({required this.addScreenTime});
  
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات'), backgroundColor: Colors.blue.shade900, foregroundColor: Colors.white),
      body: ListView(children: [
        const SwitchListTile(title: Text('إشعارات يومية'), subtitle: Text('تلقي تذكيرات يومية'), value: true, onChanged: null),
        ListTile(
          title: const Text('إضافة وقت استخدام تجريبي'),
          subtitle: const Text('للاختبار: أضف 30 دقيقة'),
          trailing: const Icon(Icons.add_circle),
          onTap: () {
            widget.addScreenTime(30);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إضافة 30 دقيقة للاستخدام')));
          },
        ),
        ListTile(
          title: const Text('تسجيل الخروج'),
          trailing: const Icon(Icons.logout),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('تسجيل الخروج'),
                content: const Text('هل أنت متأكد؟'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('تسجيل خروج')),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }
}
