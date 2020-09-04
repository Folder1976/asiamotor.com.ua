<!-- ********** Brands ********** -->
<div class="brands-box">
  <div class="container">
  <div class="row">
    <div class="carousel-module-row-header"><?php echo $heading_title; ?></div>
    <div id="carousel-brand-<?php echo $module; ?>" class="owl-carousel">
      <?php foreach ($banners as $banner) { ?>
      <div class="item text-center">
        <?php if ($banner['link']) { ?>
        <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
        <?php } else { ?>
        <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
        <?php } ?>
      </div>
      <?php } ?>
    </div>
    <a href="<?php echo $manufacturer_url; ?>" class="brands-button"><?php echo $button_more; ?></a>
  </div>
  </div>
</div>
<script><!--
$('#carousel-brand-<?php echo $module; ?>').owlCarousel({
	items: 6,
	itemsDesktop : [1599,6],
	itemsDesktop : [1199,6],
	itemsDesktopSmall : [979,5],
	itemsTablet : [768,2],
	itemsMobile : [479,2],
	autoPlay: 3000,
	navigation: true,
	navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
	pagination: false
});
--></script>
<!-- ********** End of brands ********** -->