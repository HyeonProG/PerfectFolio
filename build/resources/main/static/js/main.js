AOS.init();

//submenu
$(".sub--menu").hide();
$(".gnb--item").mouseenter(function () {
/*	$(".gnb--link").css({"color" : "#fff"});*/
    $(this).children(".sub--menu").stop().fadeIn('fast');
});
$(".gnb--item").mouseleave(function () {
	/*$(".gnb--link").css({"color" : "#333"});*/
    $(this).children(".sub--menu").hide();
});

//top--utils
$(".util--sub").hide();
$(".util--item").mouseenter(function () {
    $(this).children(".util--sub").stop().fadeIn('fast');
});
$(".util--item").mouseleave(function () {
    $(this).children(".util--sub").stop().fadeOut('fast');
});