<?php if ((isset($oct_analytics_google_status) && $oct_analytics_google_status) && !empty($oct_analytics_google_code)) { ?>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=<?php echo $oct_analytics_google_code; ?>"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', '<?php echo $oct_analytics_google_code; ?>');

  if(typeof dataGoogleLayer != 'undefined') {
      gtag('event', 'purchase', dataGoogleLayer);
  }
</script>
<?php } ?>

<?php if ((isset($oct_analytics_yandex_status) && $oct_analytics_yandex_status) && !empty($oct_analytics_yandex_code)) { ?>
<!-- Yandex.Metrika counter -->
<script>
<?php if ((isset($oct_analytics_yandex_ecommerce) && $oct_analytics_yandex_ecommerce) && (isset($oct_analytics_yandex_container) && $oct_analytics_yandex_container)) { ?>
window.<?php echo $oct_analytics_yandex_container; ?> = window.<?php echo $oct_analytics_yandex_container; ?> || [];
<?php } ?>
(function (d, w, c) {
    (w[c] = w[c] || []).push(function() {
        try {
            w.yaCounter<?php echo $oct_analytics_yandex_code; ?> = new Ya.Metrika2({
                id:<?php echo $oct_analytics_yandex_code; ?>,
                clickmap:true,
                trackLinks:true,
                accurateTrackBounce:true,
                webvisor:true,
                trackHash:true,
                <?php if ((isset($oct_analytics_yandex_ecommerce) && $oct_analytics_yandex_ecommerce) && (isset($oct_analytics_yandex_container) && $oct_analytics_yandex_container)) { ?>
                ecommerce:"<?php echo $oct_analytics_yandex_container; ?>"
                <?php } ?>
            });
        } catch(e) { }
    });

    var n = d.getElementsByTagName("script")[0],
        s = d.createElement("script"),
        f = function () { n.parentNode.insertBefore(s, n); };
    s.type = "text/javascript";
    s.async = true;
    s.src = "https://mc.yandex.ru/metrika/tag.js";

    if (w.opera == "[object Opera]") {
        d.addEventListener("DOMContentLoaded", f, false);
    } else { f(); }
})(document, window, "yandex_metrika_callbacks2");
</script>
<noscript><div><img src="https://mc.yandex.ru/watch/<?php echo $oct_analytics_yandex_code; ?>" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->

<?php if ((isset($oct_analytics_yandex_ecommerce) && $oct_analytics_yandex_ecommerce) && (isset($oct_analytics_yandex_container) && $oct_analytics_yandex_container)) { ?>
<script>
function octYandexEcommerce(value) {
    if(typeof <?php echo $oct_analytics_yandex_container; ?> != 'undefined') {
        var products = [{
            "id": value['oct_analytics_yandex_product_id'],
            "name": value['oct_analytics_yandex_name'],
            "price": value['oct_analytics_yandex_price'],
            "brand": value['oct_analytics_yandex_manufacturer'],
            "category": value['oct_analytics_yandex_category'],
            "quantity": value['oct_analytics_yandex_quantity']
        }];

        <?php echo $oct_analytics_yandex_container; ?>.push({"ecommerce": {"add": {"products": products}}});
    }
}
</script>
<?php } ?>
<?php } ?>

<?php if (isset($oct_analytics_targets) && !empty($oct_analytics_targets)) { ?>
<script>
<?php foreach ($oct_analytics_targets as $target) { ?>
$("<?php echo $target['atribute']; ?>").on( "click", function() {
    <?php if (isset($target['google']) && $target['google']) { ?>
   gtag('event', '<?php echo $target['action']; ?>', {
	  'event_category' : '<?php echo $target['category']; ?>'
	});
    <?php } ?>

    <?php if (isset($target['yandex']) && $target['yandex']) { ?>
    yaCounter<?php echo $oct_analytics_yandex_code; ?>.reachGoal('<?php echo $target['action']; ?>');
    <?php } ?>
});
<?php } ?>
</script>
<?php } ?>