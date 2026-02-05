import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../domain/models/nutrition_topic.dart';
import 'nutrition_detail_screen.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'Саломатӣ ва Ғизо',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 24),
                _buildTabs(),
                const SizedBox(height: 32),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: _selectedTab == 0 ? _buildNutritionGrid() : _buildExercisesGrid(),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              text: 'Ғизо',
              isSelected: _selectedTab == 0,
              onTap: () => setState(() => _selectedTab = 0),
            ),
          ),
          Expanded(
            child: _TabButton(
              text: 'Машқҳо',
              isSelected: _selectedTab == 1,
              onTap: () => setState(() => _selectedTab = 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionGrid() {
    final items = [
      NutritionTopic(
        imagePath: 'assets/images/nutrition/fruit_bowl.png',
        title: 'Меваҳои фоиданок',
        subtitle: 'Витаминҳо ва маъданҳо',
        color: const Color(0xFFE8F5E9),
        content:
            'Меваҳо манбаи асосии витаминҳо ва нахҳо (клетчатка) мебошанд. Дар давраи ҳомиладорӣ, истеъмоли меваҳои тару тоза ба монанди себ, нок, банан ва ангур хеле муҳим аст.\n\n'
            '1. Себ: Оҳан ва витамини C дорад, ки барои системаи иммунӣ муфид аст.\n'
            '2. Банан: Калий дорад, ки барои кори дил ва пешгирии судоргаҳо кумак мекунад.\n'
            '3. Цитрусӣ: Лимон ва афлесун бой аз витамини C мебошанд.\n\n'
            'Кӯшиш кунед, ки меваҳоро шуста ва тоза карда истеъмол намоед. Беҳтараш меваҳои мавсимии маҳаллиро интихоб кунед.',
      ),
      NutritionTopic(
        imagePath: 'assets/images/nutrition/water_bottle.png',
        title: 'Реҷаи обнӯшӣ',
        subtitle: 'Нӯшидани об',
        color: const Color(0xFFE3F2FD),
        content:
            'Об барои саломатии модар ва кӯдак ҳаётан муҳим аст. Нӯшидани оби кофӣ барои ташаккули оби ҳомила (амниотикӣ) ва гардиши хун зарур аст.\n\n'
            'Тавсияҳо:\n'
            '• Рӯрона 2-3 литр тоза об нӯшед.\n'
            '• Аз нӯшокиҳои ширин ва газнок худдорӣ кунед.\n'
            '• Ҳар саҳарро бо як стакан оби ширгарм оғоз кунед.\n\n'
            'Агар варам карданро ҳис кунед, миқдори намакро дар хӯрок кам кунед, аммо нӯшидани обро қатъ накунед.',
      ),
      NutritionTopic(
        imagePath: 'assets/images/nutrition/junk_food_prohibited.png',
        title: 'Маҳсулоти зараровар',
        subtitle: 'Аз чӣ парҳез кунед',
        color: const Color(0xFFFFEBEE),
        content:
            'Дар давраи ҳомиладорӣ баъзе маҳсулот метавонанд ба саломатии кӯдак зарар расонанд. Лутфан аз инҳо худдорӣ кунед:\n\n'
            '1. Хӯрокҳои тезтайёр (Fast Food): Бургер, чипс ва ғайра, ки равғани зиёд ва намаки зиёд доранд.\n'
            '2. Гӯшт ва моҳии нимхом: Хавфи бактерияҳо дорад (масалан, суши ё стейки хундор).\n'
            '3. Кофеин: Миқдори қаҳва ва чойи сиёҳро маҳдуд кунед.\n'
            '4. Алкогол ва тамоку: Қатъиян манъ аст!',
      ),
      NutritionTopic(
        imagePath: 'assets/images/nutrition/healthy_meal.png',
        title: 'Ғизоҳои солим',
        subtitle: 'Рецептҳои осон',
        color: const Color(0xFFFFF3E0),
        content:
            'Ғизои мутавозин бояд сафедаҳо (протеин), карбогидратҳо ва равғанҳои муфид дошта бошад.\n\n'
            'Намунаи табақи солим:\n'
            '• 1/2 қисми табақ: Сабзавот ва меваҳо\n'
            '• 1/4 қисми табақ: Ғалладонагӣ (биринҷ, гречка, нони сиёҳ)\n'
            '• 1/4 қисми табақ: Сафедаҳо (гӯшт, мурғ, моҳӣ, лӯбиё)\n\n'
            'Хӯрокро дар буғ ё дар об пухтан беҳтар аст, на бирён кардан.',
      ),
      NutritionTopic(
        imagePath: 'assets/images/nutrition/dairy_products.png',
        title: 'Кальсий',
        subtitle: 'Устухонҳои қавӣ',
        color: const Color(0xFFF3E5F5),
        content:
            'Кальсий барои инкишофи устухонҳо ва дандонҳои кӯдак зарур аст. Агар модар кальсий кам истеъмол кунад, организмаш онро аз устухонҳои худ мегирад.\n\n'
            'Манбаъҳои беҳтарини кальсий:\n'
            '• Шир ва ҷурғот\n'
            '• Панир ва творог\n'
            '• Бодом ва кунҷит\n'
            '• Сабзавотҳои баргсабз\n\n'
            'Кӯшиш кунед, ки ҳар рӯз маҳсулоти ширӣ истеъмол кунед.',
      ),
      NutritionTopic(
        imagePath: 'assets/images/nutrition/leafy_greens.png',
        title: 'Фолат аситӣ',
        subtitle: 'Барои инкишоф',
        color: const Color(0xFFF1F8E9),
        content:
            'Кислотаи фолий (Vitamin B9) барои пешгирии нуқсонҳои модарзодии системаи асаби кӯдак хеле муҳим аст, махсусан дар 3 моҳи аввал.\n\n'
            'Манбаъҳои табиӣ:\n'
            '• Исфаноҷ (шпинат) ва кабудиҳо\n'
            '• Лӯбиё ва нахӯд\n'
            '• Брокколи\n'
            '• Авокадо\n'
            '• Ҷигар\n\n'
            'Илова бар ин, духтур одатан ҳабҳои иловагии фолий таъин мекунад.',
      ),
    ];

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.70,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildNutritionCard(items[index]),
        childCount: items.length,
      ),
    );
  }

  Widget _buildExercisesGrid() {
    final items = [
      NutritionTopic(
        imagePath: 'assets/images/nutrition/pregnancy_yoga.png',
        title: 'Йога',
        subtitle: 'Машқҳои осон',
        color: const Color(0xFFFCE4EC),
        content:
            'Йога барои ҳомиладорон хеле муфид аст. Он ба оромшавӣ, беҳтар шудани нафаскашӣ ва омодагӣ ба таваллуд кумак мекунад.\n\n'
            'Фоидаҳо:\n'
            '• Кам кардани дарди миён\n'
            '• Беҳтар кардани хоб\n'
            '• Кам кардани стресс\n\n'
            'Муҳим: Ҳангоми машқҳо ҳаракатҳои тез ва фишороварро иҷро накунед. Агар дард ҳис кунед, фавран машқро бас кунед.',
      ),
      NutritionTopic(
        imagePath: 'assets/images/nutrition/walking_pregnant.png',
        title: 'Пиёдаравӣ',
        subtitle: 'Ҳар рӯз 30 дақиқа',
        color: const Color(0xFFE0F2F1),
        content:
            'Пиёдаравӣ – машқи беҳтарин ва бехатартарин барои ҳамаи занони ҳомиладор аст. Он дилро қавӣ мегардонад ва вазни зиёдаро пешгирӣ мекунад.\n\n'
            'Тавсияҳо:\n'
            '• Ҳар рӯз 20-30 дақиқа дар ҳавои тоза гардиш кунед.\n'
            '• Либос ва пойафзоли бароҳат пӯшед.\n'
            '• Об ҳамроҳ гиред.\n'
            '• Тез роҳ нагардед, нафасгирии муқаррариро нигоҳ доред.',
      ),
      NutritionTopic(
        imagePath: 'assets/images/nutrition/meditation.png',
        title: 'Релаксатсия',
        subtitle: 'Истироҳат',
        color: const Color(0xFFEDE7F6),
        content:
            'Саломатии рӯҳӣ ба саломатии ҷисмонӣ баробар муҳим аст. Стресс метавонад ба кӯдак таъсир расонад.\n\n'
            'Роҳҳои релаксатсия:\n'
            '• Гӯш кардани мусиқии ором\n'
            '• Нафаскашии чуқур\n'
            '• Хондани китоб\n'
            '• Медитацияи сабук\n\n'
            'Кӯшиш кунед, ки ҳар рӯз ҳадди ақал 15 дақиқа барои худатон вақт ҷудо кунед.',
      ),
      NutritionTopic(
        imagePath: 'assets/images/nutrition/swimming.png',
        title: 'Шинокунӣ',
        subtitle: 'Бехатар ва муфид',
        color: const Color(0xFFE1F5FE),
        content:
            'Шинокунӣ (бозиҳои обӣ) вазнро аз сутунмӯҳра мебардорад ва баданро сабук мекунад. Ин барои рафъи варамҳо хеле муфид аст.\n\n'
            'Фоидаҳо:\n'
            '• Мустаҳкам кардани мушакҳо\n'
            '• Беҳтар кардани гардиши хун\n'
            '• Салкинӣ дар рӯзҳои гарм\n\n'
            'Эҳтиёт бошед: Дар обҳои тоза ва на он қадар сард шино кунед. Ҳаракатҳои шадид накунед.',
      ),
    ];

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.70,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildNutritionCard(items[index]),
        childCount: items.length,
      ),
    );
  }

  Widget _buildNutritionCard(NutritionTopic item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NutritionDetailScreen(
              title: item.title,
              subtitle: item.subtitle,
              imagePath: item.imagePath,
              color: item.color,
              content: item.content,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Container(
                  color: item.color,
                  child: Hero(
                    tag: item.imagePath,
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Icon(Icons.broken_image, color: Colors.black26),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textLight,
                        fontSize: 11,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.coral : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.coral.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textDark.withOpacity(0.7),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

