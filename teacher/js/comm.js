/**
 * Created by p on 2014/6/10.
 */
function isNumber(str) {
    var regu = /^\d+$/;
    return regu.test(str);
}

function isLetter(str) {
    var regu = /^[a-zA-Z]+$/;
    return regu.test(str);
}

function isNumberOrLetter(str) {
    var regu = /^[0-9a-zA-Z]+$/;
    return regu.test(str);
}

function isEmail(str) {
    var regu = /^[\w-]+([.][\w-]+)*@[\w-]+([.][\w-]+)+$/;
    return regu.test(str);
}

function isMobile(str) {
    var regu = /^[1][3578][0-9]{9}$/;
    return regu.test(str);
}

function isPhone(str) {
    var phoneRegWithArea = /^[0][1-9]{2,3}-[0-9]{5,10}$/;
    var phoneRegNoArea = /^[1-9]{1}[0-9]{5,8}$/;
    if (str.length > 9) {
        return phoneRegWithArea.test(str);
    } else {
        return phoneRegNoArea.test(str);
    }
}

function isSqlDate(str) {
    var regu = /^(\d{4})[-](\d{1,2})[-](\d{1,2})$/;
    if (regu.test(str)) {
        var date = new Date(RegExp.$1, RegExp.$2-1, RegExp.$3);
        return (date.getFullYear() == RegExp.$1 && date.getMonth() == RegExp.$2-1 && date.getDate() == RegExp.$3);
    }
    return false;
}

function alertobj(obj) {
    $.each(obj, function(key, val) {
        if ($.isPlainObject(val) || $.isArray(val)) {
            alertobj(val);
        } else {
            alert(key + '=' + val);
        }
    });
}

function MM_swapImgRestore() { //v3.0
    var i, x, a = document.MM_sr;
    for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++) x.src = x.oSrc;
}

function MM_preloadImages() { //v3.0
    var d = document;
    if (d.images) {
        if (!d.MM_p) d.MM_p = new Array();
        var i, j = d.MM_p.length,
            a = MM_preloadImages.arguments;
        for (i = 0; i < a.length; i++) if (a[i].indexOf("#") != 0) {
            d.MM_p[j] = new Image;
            d.MM_p[j++].src = a[i];
        }
    }
}

function MM_findObj(n, d) { //v4.01
    var p, i, x;
    if (!d) d = document;
    if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
        d = parent.frames[n.substring(p + 1)].document;
        n = n.substring(0, p);
    }
    if (! (x = d[n]) && d.all) x = d.all[n];
    for (i = 0; ! x && i < d.forms.length; i++) x = d.forms[i][n];
    for (i = 0; ! x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
    if (!x && d.getElementById) x = d.getElementById(n);
    return x;
}

function MM_swapImage() { //v3.0
    var i, j = 0,
        x, a = MM_swapImage.arguments;
    document.MM_sr = new Array;
    for (i = 0; i < (a.length - 2); i += 3) if ((x = MM_findObj(a[i])) != null) {
        document.MM_sr[j++] = x;
        if (!x.oSrc) x.oSrc = x.src;
        x.src = a[i + 2];
    }
}

function clearCookie(){
    var keys = document.cookie.match(/[^ =;]+(?=\=)/g);
    if (keys) {
        for (var i = keys.length; i--;)
            document.cookie = keys[i] + '=0;expires=' + new Date(0).toUTCString();
    }
}
