import '../database/database_helper.dart';
import '../models/member.dart';

class MemberService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  // Add Member
  Future<int> addMember(Member member) async {
    return await _databaseHelper.insertMember(member);
  }

  // Get All Members
  Future<List<Member>> getMembers() async {
    return await _databaseHelper.getMembers();
  }

  // Update Member
  Future<int> updateMember(Member member) async {
    return await _databaseHelper.updateMember(member);
  }

  // Delete Member
  Future<int> deleteMember(int id) async {
    return await _databaseHelper.deleteMember(id);
  }
}