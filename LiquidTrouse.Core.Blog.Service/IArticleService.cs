﻿using LiquidTrouse.Core.Blog.Service.DTO;
using LiquidTrouse.Core;
using LiquidTrouse.Core.AccountManager.DTO;

namespace LiquidTrouse.Core.Blog.Service
{
    public interface IArticleService
    {
        ArticleInfo Get(UserInfo userInfo, int articleId);
        ArticleInfo[] GetTopN(UserInfo userInfo, int topN);
        PageOf<ArticleInfo> Get(UserInfo userInfo, int pageIndex, int pageSize);
        PageOf<ArticleInfo> Get(UserInfo userInfo, SortingInfo sortingInfo, int pageIndex, int pageSize);
        void Create(UserInfo userInfo, ArticleInfo articleInfo);
        void Create(UserInfo userInfo, ArticleInfo articleInfo, string[] tagDisplayNames);
        void Delete(UserInfo userInfo, int articleId);
        void Update(UserInfo userInfo, ArticleInfo articleInfo);
        void Update(UserInfo userInfo, ArticleInfo articleInfo, string[] tagDisplayNames);
    }
}
