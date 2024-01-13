import 'package:newsapp_server/src/generated/article.dart';
import 'package:serverpod/database.dart';
import 'package:serverpod/server.dart';

class ArticleEndpoint extends Endpoint {
  Future<List<Article>> getArticle(Session session, {String? keyword}) async {
    return Article.find(
      session,
      where: (article) => keyword != null ? article.title.like("%$keyword%") : Constant(true),
    );
  }

  Future<bool> addArticle(Session session, Article article) async {
    await Article.insert(session, article);
    return true;
  }

  Future<bool> updateArticle(Session session, Article article) async {
    var result = await Article.update(session, article);
    return result;
  }

  Future<bool> deleteArticle(Session session, int id) async {
    var result = await Article.delete(session,
        where: (article) => article.id.equals(id));
    return result == 1;
  }
}
