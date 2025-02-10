

class Urls{
    //https://localhost:443/user/login
    // static var url = "http://localhost:80";

    //本地的环境
    static var url = "https://localhost:443";

    
    // 邮箱注册
    static var url_email_register = url + "/user/email-register";
    //发送邮件验证码
    static var url_email_code = url + "/code/email-code";


    //发送手机验证码
    static var url_phone_code = url + "/code/phone-code";
    static var url_phone_register = url + "/user/phone-register";



    static var url_login = url + "/user/login";
    //获取某一个用户的全部的note
    static var url_content_list = url + "/api/content/content-list";
    //搜索note
    static var url_content_search = url + "/api/content/content_search";


    //根据更新时间updated_at,获取某一个用户的全部的note
    static var url_content_list_updateAt = url + "/api/content/content-list-updateat";
    //提交图片
    static var url_upload_images = url + "/api/common/uploadArrayFile";
    //插入内容
    static var url_upload_note = url + "/api/content/insert-content";
    //根据某一用户和他的标签tags添加笔记和标签
    static var url_upload_note_tag = url + "/api/content/insert-content-tagsId";

    //根据id查询某一条note
    static var url_query_note_id = url + "/api/content/query-content-id";

    //删除笔记
    static var url_delete_note = url + "/api/content/delete-content";
    static var url_delete_image = url + "/api/common/deleteFiles";
    //获取标签列表
    static var url_tags = url + "/api/tag/tag-list";
    //根据tagid获取当前用户的笔记
    static var url_tags_bytagId = url + "/api/tag/get_content_id";


    static var url_update_note = url + "/api/content/update-content";


    static var url_user_info = url + "/user/queryUserByUid";

    static var url_user_dismiss = url + "/user/deleteAccount";



}