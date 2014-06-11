/**
 * Created by p on 2014/5/14.
 */
var class_ids = new Array();
var blog_type = true//ture is public(whiteboard),false is class
$(document).ready(function (){


    init_blogs();//获取blogs列表

    init_favors();
    $('.schooltools').find('input').on('click',function(){
        class_ids.length = 0;
        $('#class-list').find('li[clzid]').each(select_class);
    });

    $('#share-group').on('click',function(){
        blog_type = false;
    });
    $('#share-public').on('click',function(){
        blog_type = true;
    });
    $('#send-blog').on('click',send_blog);
    $('#search-favor-icon').on('click',search_favor);
    $('#myb-pre').on('click',myb_pre);
    $('#myb-next').on('click',myb_next);
    $('#apb-pre').on('click',apb_pre);
    $('#apb-next').on('click',apb_next);
    $('#favor-pre').on('click',favor_pre);
    $('#favor-next').on('click',favor_next);

});
var my_blog_start = 0;
var blog_step = 5;
var ap_blog_start = 0;
var favor_start = 0;
var csmb_num = 0;
var csab_num = 0;
var cf_num = 0;
function favor_pre() {
    if(favor_start == 0){
        alert('no previous page!');
        return;
    }
    favor_start -= blog_step;
    handle_favors('/api/blog/listfav.do?'+'start='+favor_start+'&num='+blog_step);
}
function favor_next() {
    if(cf_num < blog_step){
        alert('no next page!');
        return;
    }
    favor_start += blog_step;
    handle_favors('/api/blog/listfav.do?'+'start='+favor_start+'&num='+blog_step);
}
function myb_pre(){
    if(my_blog_start == 0){
        alert('no previous page!');
        return;
    }
    my_blog_start -= blog_step;
    handle_blog('/api/blog/list.do?'+'start='+my_blog_start+'&num='+blog_step,'#blog-myself')

}
function myb_next() {
    if(csmb_num < blog_step){
        alert('no next page!');
        return;
    }
    my_blog_start += blog_step;
    handle_blog('/api/blog/list.do?'+'start='+my_blog_start+'&num='+blog_step,'#blog-myself')
}
function apb_pre() {
    if(ap_blog_start == 0){
        alert('no previous page!');
        return;
    }
    ap_blog_start -= blog_step;
    handle_blog('/api/blog/list.do?clzid=0&'+'start='+ap_blog_start+'&num='+blog_step,'#blog-allpeople');

}
function apb_next(){
    if(csab_num < blog_step){
        alert('no next page!');
        return;
    }
    ap_blog_start += blog_step;
    handle_blog('/api/blog/list.do?clzid=0&'+'start='+ap_blog_start+'&num='+blog_step,'#blog-allpeople');

}
function search_favor(){
    var mask_text = $(this).parent('.favorite-search').find('input').val();
    var favor_list = $('#favor-ul');
    favor_list.find('li[id^=favoritem-]').each(function () {
        $(this).show();
        if($(this).find('.favorite-name').text().indexOf(mask_text) < 0)
            $(this).hide();
    });
}
function handle_favors(url) {
    $.ajax({
        url: url,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success:function (msg){
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {
                var favor_model = $('#favor-model');
                var blogs = msg.blogs;

                cf_num = blogs.length;
                if(blogs.length == 0){
                    if(favor_start > 0){
                        favor_start -= blog_step;
                        alert('no next page!');
                    }
                    return;
                }
                $('#favor-ul').find('li[blogid]').remove();
                for(var i=0;i<blogs.length;++i){
                    var tem_favor = favor_model.clone();
                    tem_favor.attr('id','favoritem-'+blogs[i].id);
                    tem_favor.attr('blogid',blogs[i].id);
                    tem_favor.removeAttr('style');
                    tem_favor.find('.favorite-name').text(blogs[i].title);
                    tem_favor.find('.favorite-tooles').find('a').click(function(){
                        var ali = $(this).parent('.favorite-tooles').parent('li');
                        var url = '/api/blog/unfavorite.do?id='+ali.attr('blogid');
                        $.ajax({
                            url: url,
                            type: 'POST',
                            data: '',
                            dataType: 'json',
                            async: false,
                            success:function (msg){
                            },
                            error: function(jqXHR, status, err) {
                                alert(err);
                            }
                        });
                        ali.remove();
                    });

                    favor_model.after(tem_favor);
                    tem_favor.show();

                }

            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}
function init_favors(){

    favor_start = 0;
    var url = '/api/blog/listfav.do?'+'start='+favor_start+'&num='+blog_step;

    handle_favors(url);

}
function do_send_blog(url,data,func){
    $.ajax({
        url: url,
        type: 'POST',
        data: data,
        dataType: 'json',
        async: false,
        success:func,
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}

function addappendix(blogid) {
    var form = $('#attaform');
    form.ajaxForm({
        url: '/api/blog/appendix/add.do?blogid='+blogid,
        dataType: 'json',
        beforeSend: function(jqXHR) {
            form.find('#progress').show();

            var percentVal = '0%';
            form.find('#bar').width(percentVal);
            form.find('#percent').html(percentVal);
        },
        uploadProgress: function(event, position, total, percentComplete) {
            var percentVal = percentComplete + '%';
            form.find('#bar').width(percentVal);
            form.find('#percent').html(percentVal);
        },
        success: function(msg, status) {

            var percentVal = '100%';
            form.find('#bar').width(percentVal);
            form.find('#percent').html(percentVal);

            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {

            } else {
                alert(err);
            }
            form.find('#progress').hide();
            init_blogs();
        },
        error: function (jqXHR, status, err) {
            alert(err);
        },
        complete: function(jqXHR, status) {
        }
    });

    form.submit();
}
function send_blog(){
    var url_to = '/api/blog/add.do';
    var data_to = '';
    var blog_text = $('#blog-text');

    if(blog_type == true){//public

        data_to = 'clzid=0&title='+blog_text.val();
        if(blog_text.val().length < 1){
            alert('please say something');
            return;
        }
        do_send_blog(url_to,data_to,function(msg){
            var err = msg.err;

            if (typeof(err) == 'undefined' || err == '') {
                var f1 = $('#attaform').find('#1-file-input');
                var f2 = $('#attaform').find('#2-file-input');

                if(f1.val().length > 0 || f2.val().length > 0)
                    addappendix(msg.id);
                else  init_allpeople();
            }
        });

    }else {//specify class

        if(class_ids.length > 0){

            data_to = 'clzid='+class_ids[0]+'&title='+blog_text.val();
            do_send_blog(url_to,data_to,function(msg){
                var err = msg.err;

                if (typeof(err) == 'undefined' || err == '') {
                    var bid = msg.id;

                    var f1 = $('#attaform').find('#1-file-input');
                    var f2 = $('#attaform').find('#2-file-input');

                    if(f1.val().length > 0 || f2.val().length > 0)
                        addappendix(msg.id);
                    if(class_ids.length == 1)
                        init_blogs();
                    for(var i=1;i<class_ids.length;++i){
                        var url = '/api/blog/share.do?id='+bid+"&clzid="+class_ids[i];
                        var cindex = i;
                        $.ajax({
                            url: url,
                            type: 'POST',
                            data: '',
                            dataType: 'json',
                            async: false,
                            success:function (msg){
                                if(cindex == class_ids.length-1){
                                    init_blogs();
                                }

                            },
                            error: function(jqXHR, status, err) {
                                alert(err);
                            }
                        });
                    }

                }
            });
        }




    }
}
function select_class(){

    if($(this).find('input').is(':checked'))
        class_ids[class_ids.length] = $(this).attr('clzid');
}
function like_click(){
    var url;
    var othis = $(this);
    var type = $(this).attr('liked');

    if(type == 'yes') {
        url = '/api/blog/unlike.do?id=' + $(this).attr('blogid');
        type = 'no'
    }else{
        url = '/api/blog/like.do?id=' + $(this).attr('blogid');
        type = 'yes';
    }
    $.ajax({
        url: url,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success:function (msg){

            var like_num = parseInt(othis.parent('.send-info').find('.likemuch').text());
            if(type == 'yes'){
                othis.text('unlike ');
                othis.parent('.send-info').find('.likemuch').text(like_num+1);
            }
            else {
                othis.text('like ');
                othis.parent('.send-info').find('.likemuch').text(like_num-1);
            }
            othis.attr('liked',type);
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}
function share_click(){

    var url = '/api/blog/share.do?id='+$(this).attr('blogid');
    alert(url);
    $.ajax({
        url: url,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success:function (msg){
            init_blogs();
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}
function send_commet(){
    var send_text = $(this).parent('.mycomment').find('.comment-edit').find('textarea').val();
    var url = '/api/blog/comment.do';
    var data = 'blogid='+$(this).attr('blogid')+'&followid='+$('#userid').text()+'&msg='+send_text;

    $.ajax({
        url: url,
        type: 'POST',
        data: data,
        dataType: 'json',
        async: false,
        success:function (msg){
            if (typeof(err) == 'undefined' || err == '') {
                init_blogs();

            }
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}
function add_favor() {
    var url ;
    var othis = $(this);
    var type = $(this).attr('favored');
    if(type == 'yes') {
        url = '/api/blog/unfavorite.do?id=' + $(this).attr('blogid');
        type = 'no'
    }else{
        url = '/api/blog/favorite.do?id=' + $(this).attr('blogid');
        type = 'yes';
    }
    $.ajax({
        url: url,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success:function (msg){
            init_favors();
            if(type == 'yes')
                othis.attr('src','css/image/hssc.jpg');
            else othis.attr('src','css/image/nosc.jpg');
            othis.attr('favored',type);
        },
        error: function(jqXHR, status, err) {
            alert(err);
        }
    });
}
function handle_blog(url,blog_box){
    var url_to =url;

    $.ajax({
        url: url_to,
        type: 'POST',
        data: '',
        dataType: 'json',
        async: false,
        success: function(msg, status) {
            var err = msg.err;
            if (typeof(err) == 'undefined' || err == '') {

                var blogs = msg.blogs;

                if(blog_box == '#blog-myself'){
                    csmb_num = blogs.length;
                    if(blogs.length == 0){
                        if(my_blog_start > 0){
                            my_blog_start -= blog_step;
                            alert('no next page!');
                        }
                        $(blog_box).find('#newblog-1').hide();
                        return;
                    }
                }else {
                    csab_num = blogs.length;
                    if(blogs.length == 0){
                        if(ap_blog_start > 0){
                            ap_blog_start -= blog_step;
                            alert('no next page!');
                        }
                        $(blog_box).find('#newblog-1').hide();
                        return;
                    }
                }

                $(blog_box).find('div[id^=div_article_]').remove();
                for (var i = blogs.length-1 ; i >= 0 ; i--) {
                    var divart = $(blog_box).find('#newblog-1').clone();
                    divart.show();
                    divart.attr('id', 'div_article_' + blogs[i].id);
                    divart.find('.userimg').find('img').attr('src', blogs[i].userphoto);
                    divart.find('.mycomment').find('.comment-user').find('img').attr('src',$('#userphoto').text());
                    divart.find('.blog-title').text(blogs[i].username);
                    divart.find('.blog-intro').text(blogs[i].title);
                    divart.find('.send-time').text(blogs[i].uptime);
                    divart.find('.send-where').text(blogs[i].location);

                    divart.find('#likemuch').text(blogs[i].likes);
                    divart.find('#likemuch').attr('id','likemuch'+blogs[i].id);

                    $(blog_box).prepend(divart);

                    var alike = divart.find('#like');
                    alike.attr('id', 'btn_like_'+blogs[i].id);
                    alike.attr('blogid', blogs[i].id);
                    alike.attr('liked','no');
                    alike.click(like_click);

                    var ashare = divart.find('#send-share');
                    ashare.attr('id', 'btn_share_'+blogs[i].id);
                    ashare.attr('blogid', blogs[i].id);
                    ashare.click(share_click);

                    var aphoto = divart.find('#aphotoitem');

                    apds = blogs[i].appendixes;
                    for (var j = 0; j < apds.length; j++) {
                        if (apds[j].atype == 1) {
                            var ph = aphoto.clone();

                            ph.find('img').attr('src',apds[j].apath);

                            aphoto.after(ph);
                        } else {
                            aphoto.after('<a href="###" id="btn_apd_' + apds[j].id
                                + '" apdid="' + apds[j].id + '">' + apds[j].aname + '</a>');
                        }
                    }
                    if(apds.length == 0){//没有附件
                        divart.find('.blog-photo').hide();
                    }
                    aphoto.hide();

                    cmts = blogs[i].comments;
                    var comment_model = divart.find('#comment-model');
                    var comment_list = divart.find('#comment-list');
                    for (var j = 0; j < cmts.length; j++) {
                        var divcmt = comment_model.clone();
                        divcmt.attr('id', 'div_comment_'+cmts[j].id);
                        divcmt.show();
                        divcmt.find('.comment-user').find('img').attr('src', cmts[j].userphoto);
                        divcmt.find('#comment-user-name').text(cmts[j].username);
                        divcmt.find('.comment-user-zhiye').text(cmts[j].msg);
                        divcmt.find('.comment-tiem').text(cmts[j].uptime + ' - ' + cmts[j].location);
                        comment_model.after(divcmt);
                    }
                    comment_model.hide();

                    var commet_send = divart.find('#comment-send-button');
                    commet_send.attr('blogid', blogs[i].id);
                    commet_send.click(send_commet);

                    var favor_icon = divart.find('#favor-icon');
                    favor_icon.attr('blogid', blogs[i].id);
                    favor_icon.attr('favored','no');
                    favor_icon.click(add_favor);
                }
                $(blog_box).find('#newblog-1').hide();
            } else {
                //alert(err);
            }
        },
        error: function(jqXHR, status, err) {
            //alert(err);
        }
    });
}
function init_allpeople(){

    handle_blog('/api/blog/list.do?clzid=0&'+'start='+ap_blog_start+'&num='+blog_step,'#blog-allpeople');
}
function init_myself(){

    handle_blog('/api/blog/list.do?'+'start='+my_blog_start+'&num='+blog_step,'#blog-myself')
}
function init_blogs() {

    init_allpeople();
    init_myself();
}