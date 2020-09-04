<!-- ********** News ********** -->
<?php if($position == "column_left" OR $position == "column_right") { ?>
<div class="carousel-module-container">
<?php } else { ?>
<div class="container carousel-module-container">
<?php } ?>
  <div class="row news-row">
    <div class="carousel-module-row-header">
      <?php if ($link == '#') { ?>
        <?php echo $heading_title; ?>
      <?php } else { ?>
        <a href="<?php echo $link; ?>"><?php echo $heading_title; ?></a>
      <?php } ?>
    </div>
    <div id="news-<?php echo $module; ?>" class="owl-carousel owl-theme">
      <?php foreach ($articles as $article) { ?>
        <div class="item col-md-12">
            <?php if ($article['thumb']) { ?>
	            <a href="<?php echo $article['href']; ?>">
	            	<div class="blog-img-box">
		              	<img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" class="img-responsive" />
					  	<span><?php echo $article['date_added']; ?></span>
				  	</div>
	            </a>
            <?php } ?>
            <div class="blog-text-box">
            	<a href="<?php echo $article['href']; ?>"><h3><?php echo $article['name']; ?></h3></a>
            	<div class="blog-text-item"><?php echo $article['description']; ?></div>
            </div>
        </div>
      <?php } ?>
    </div>
  </div>
</div>
<script>
$('#news-<?php echo $module; ?>').owlCarousel({
	items: <?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 4; } ?>,
	itemsDesktop : [1199,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 3; } ?>],
	itemsDesktopSmall : [979,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 2; } ?>],
	itemsMobile : [480,<?php if($position == "column_left" OR $position == "column_right") { echo 1; } else { echo 1; } ?>],
	autoPlay: false,
	navigation: false,
	slideMargin: 10,
	navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
	stopOnHover:true,
	smartSpeed: 800,
	loop: true,
	pagination: true
});
</script>
<!-- ********** End of news ********** -->