<!-- ********** Reviews ********** -->
<?php if ($position == "column_left" OR $position == "column_right") { ?>

<?php } else { ?> 
<div class="container">
  <div class="row reviews-row">
    <div class="carousel-module-row-header"><?php echo $heading_title; ?></div>
    <div id="reviews-<?php echo $module; ?>" class="owl-carousel owl-theme">
      <?php foreach ($reviews as $review) { ?>
      <div class="item"> 
        <div class="image">
          <a href="<?php echo $review['href']; ?>"><img src="<?php echo $review['thumb']; ?>" alt="<?php echo $review['name']; ?>" /></a>
        </div>
        <div class="name">
        <a href="<?php echo $review['href']; ?>"><?php echo $review['name']; ?></a>
        </div>
        <?php if ($review['rating']) { ?>
          <div class="rating">
            <?php for ($i = 1; $i <= 5; $i++) { ?>
            <?php if ($review['rating'] < $i) { ?>
            <i class="fa fa-star-o" aria-hidden="true"></i>
            <?php } else { ?>
            <i class="fa fa-star" aria-hidden="true"></i>
            <?php } ?>
            <?php } ?>
          </div>
        <?php } ?>
        <div class="text"><?php echo $review['text']; ?></div>
      </div>
      <?php } ?>
    </div>
  </div>
</div>
<script>
$('#reviews-<?php echo $module; ?>').owlCarousel({
	items: <?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 4; } ?>,
	itemsDesktop : [1199,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 3; } ?>],
	itemsDesktopSmall : [979,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 2; } ?>],
	itemsMobile : [480,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 1; } ?>],
	autoPlay: false,
	navigation: true,
	slideMargin: 10,
	navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
	stopOnHover:true,
	smartSpeed: 800,
	loop: true,
	pagination: false
});
</script>
<?php } ?> 
<!-- ********** End of reviews ********** -->