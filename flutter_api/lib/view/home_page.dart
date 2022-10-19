import 'package:flutter/material.dart';
import 'package:flutter_api/controller/controller.dart';
import 'package:flutter_api/view/loading_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

final controller = ChangeNotifierProvider((ref) => Controller());

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(controller).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var read = ref.read(
        controller); //dosya uzeerınde işlem gercekeleştırmemızı saglıyor//buton tıklanma ıslemı yapılır örnek olarak
    var watch = ref.watch(
        controller); // anlık degısııklerı gorebılıyoruz.//sayı yazılır örn. olarak
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Riverpod",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: LoadingWidget(
        isLoading: watch.isLoading,
        child: Padding(
          padding: 20.horizontalP,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: OutlinedButton(
                      onPressed: () => read.notSavedButton(),
                      child: Text(
                        "Kullanıcılar(${watch.users.length})",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 6,
                    child: OutlinedButton(
                      onPressed: () => read.savedButton(),
                      child: Text(
                        "Kaydedilenler(${watch.saved.length})",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: PageView(
                  controller: watch.pageController,
                  children: [
                    notSaved(watch),
                    saved(watch),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView saved(Controller watch) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: watch.saved.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 15);
      },
      itemBuilder: (BuildContext context, int index) {
        return Card(
            shape: RoundedRectangleBorder(borderRadius: 15.allBR),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(watch.saved[index]!.avatar!),
                radius: 20,
              ),
              title: Text(
                "${watch.saved[index]?.firstName ?? ""} ${watch.saved[index]?.lastName ?? ""}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "${watch.saved[index]?.email ?? ""}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey.shade400),
              ),
            ));
      },
    );
  }

  ListView notSaved(Controller watch) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: watch.users.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 15);
      },
      itemBuilder: (BuildContext context, int index) {
        return Card(
            shape: RoundedRectangleBorder(borderRadius: 15.allBR),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(watch.users[index]!.avatar!),
                radius: 20,
              ),
              title: Text(
                "${watch.users[index]?.firstName ?? ""} ${watch.users[index]?.lastName ?? ""}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "${watch.users[index]?.email ?? ""}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.grey.shade400,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.send_and_archive_outlined),
                onPressed: () => watch.addSaved(watch.users[index]!),
              ),
            ));
      },
    );
  }
}
