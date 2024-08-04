import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/auth/app_user.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/firebase_storage_service.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/string_util.dart';

class UserDataTableSource extends DataTableSource {
  final BuildContext context;
  final UserProvider provider;
  late final FirebaseStorageService _firebaseStorageService;

  UserDataTableSource({required this.context, required this.provider}) : _firebaseStorageService = FirebaseStorageService();

  @override
  DataRow2 getRow(int index) {
    assert(index >= 0);
    final AppUser appUser = provider.appUsers[index];
    return DataRow2.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Center(child: Text(appUser.id.toString()))),
        DataCell(Center(child: Text(appUser.email))),
        DataCell(Center(child: Text(appUser.phone))),
        DataCell(Center(child: Text(appUser.accountNonLocked ? 'Không khoá' : 'Đã khoá'))),
        DataCell(Center(child: Text(appUser.enabled ? 'Có' : 'Chưa'))),
        DataCell(Center(child: Text(appUser.appRoles.map((e) => StringUtil.changeRoleUser(e.name)).join(', ')))),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.remove_red_eye_rounded,
                    color: Colors.blue,
                  ),
                  tooltip: 'Xem chi tiết',
                  onPressed: () {
                    if (Responsive.isDesktop(context)) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Thông tin tài khoản người dùng'),
                          content: Container(
                            padding: const EdgeInsets.only(top: 10),
                            width: SizeConfig.screenWidth * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth * 0.7 * 0.7,
                                  child: Wrap(
                                    spacing: 5,
                                    runSpacing: 5,
                                    direction: Axis.horizontal,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'ID: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(appUser.id.toString()),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Họ tên : ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(appUser.userInfo.fullName),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Số điện thoại: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(appUser.phone),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Giới tính: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(appUser.userInfo.isMale ? 'Nam' : 'Nữ'),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Ngày sinh: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(DateFormat('dd/MM/yyyy').format(appUser.userInfo.dateOfBirth)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Kích hoạt tài khoản: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(appUser.enabled ? 'Đã kích hoạt' : 'Chưa kích hoạt'),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Tài khoản bị khoá: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(appUser.accountNonLocked ? 'Không' : 'Đã khoá'),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Email: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(appUser.email),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Google Id: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(appUser.googleId ?? 'Chưa liên kết'),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Facebook Id: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(appUser.facebookId ?? 'Chưa liên kết'),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Ngày tạo tài khoản: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(DateFormat('dd/MM/yyyy HH:mm:ss').format(appUser.createdDate)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.7 * 0.45,
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Quyền: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(appUser.appRoles.map((e) => StringUtil.changeRoleUser(e.name)).join(', ')),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                !appUser.userInfo.avatar.contains("robohash")
                                    ? FutureBuilder(
                                        future: _firebaseStorageService.getImages([appUser.userInfo.avatar]),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Container(
                                              width: SizeConfig.screenWidth * 0.7 * 0.3,
                                              height: 230,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: Image.memory(
                                                    _firebaseStorageService.mapImage[appUser.userInfo.avatar]!,
                                                  ).image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          }
                                          return Container(
                                            width: SizeConfig.screenWidth * 0.7 * 0.3,
                                            height: 230,
                                            child: Center(child: CircularProgressIndicator()),
                                          );
                                        })
                                    : Container(
                                        width: SizeConfig.screenWidth * 0.7 * 0.3,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.grey, width: 1),
                                          image: DecorationImage(
                                            image: Image.network(
                                              appUser.userInfo.avatar,
                                            ).image,
                                            fit: BoxFit.fill,
                                          ),
                                        ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    !appUser.accountNonLocked ? Icons.lock_rounded : Icons.lock_open_rounded,
                    color: !appUser.accountNonLocked ? Colors.red : Colors.green,
                  ),
                  tooltip: !appUser.accountNonLocked ? 'Nhấn để mở khoá tài khoản' : 'Nhấn để khoá tài khoản',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(!appUser.accountNonLocked ? 'Mở khoá tài khoản' : 'Khoá tài khoản'),
                          content: Text(!appUser.accountNonLocked ? 'Bạn có chắc chắn muốn mở' : 'Bạn có chắc chắn muốn khoá?'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Hủy'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: Text(!appUser.accountNonLocked ? 'Mở khoá' : 'Khoá'),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await provider.lockUser(appUser.id);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => provider.appUsers.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
