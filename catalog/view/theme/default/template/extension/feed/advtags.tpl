<?php
/**
 * Шаблон модуля Advtags
 */
?>
<?php if($advtags_fbq_status && $advtags_fbq_pixel) { ?>
<script>
  !function(f,b,e,v,n,t,s)
  {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
  n.callMethod.apply(n,arguments):n.queue.push(arguments)};
  if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
  n.queue=[];t=b.createElement(e);t.async=!0;
  t.src=v;s=b.getElementsByTagName(e)[0];
  s.parentNode.insertBefore(t,s)}(window, document,'script',
  'https://connect.facebook.net/en_US/fbevents.js');
  fbq('init', '<?=$advtags_fbq_pixel?>');
  fbq('track', 'PageView');
</script>
<noscript><img height="1" style="display:none"
  src="https://www.facebook.com/tr?id=<?=$advtags_fbq_pixel?>&ev=PageView&noscript=1"
/></noscript>
<?php if(isset($_SESSION['fbq_events'])) { ?>
	<script>
	<?php foreach ($_SESSION['fbq_events'] as $event) { ?>
		fbq('track', '<?=$event['type']?>', <?=json_encode($event['params'],JSON_UNESCAPED_SLASHES)?>);
	<?php } ?>
	</script>
<?php
} ?>
<?php } ?>
<?php if($advtags_gtag_status && $advtags_gtag_tracker) { ?>
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-962931253"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '<?=$advtags_gtag_tracker?>');
</script>
<?php if(isset($_SESSION['gtag_events'])) { ?>
  <script>
  <?php foreach ($_SESSION['gtag_events'] as $event) {
    if($event['type'] == 'conversion') {
      $event['params']['send_to'] = $advtags_gtag_conversion;
    } else {
      $event['params']['send_to'] = $advtags_gtag_tracker;
    }
    ?>
    gtag('event', '<?=$event['type']?>', <?=json_encode($event['params'],JSON_UNESCAPED_SLASHES)?> );
  <?php } ?>
  </script>
<?php } ?>
<?php } ?>
<?php if(isset($_SESSION['fbq_events'])) { unset($_SESSION['fbq_events']); }?>
<?php if(isset($_SESSION['gtag_events'])) { unset($_SESSION['gtag_events']); }?>