<!-- ********** Slideshow ********** -->
<div class="slideshow-box">
    <div class="container">
        <div class="row">
            <div id="oct-slideshow<?php echo $module; ?>" class="owl-carousel" style="opacity: 1;">
              <?php foreach ($oct_banners_plus as $banner) { ?>
              <div class="item">
                  <div class="col-sm-4 col-md-offset-1">
                      <h2><?php echo $banner['title']; ?></h2>
                      <p><?php echo $banner['description']; ?></p>
                      <a href="<?php echo $banner['link']; ?>" class="button-more"><?php echo $banner['button']; ?></a>
                  </div>
                  <div class="col-sm-7">
                      <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="" class="img-responsive" /></a>
                  </div>
              </div>
              <?php } ?>
            </div>
            <script><!--
            $('#oct-slideshow<?php echo $module; ?>').owlCarousel({
                items: 1,
                autoPlay: 5000,
                singleItem: true,
                navigation: <?php echo ($arrows[$banner_id]) ? 'true' : 'false'; ?>,
                navigationText: ['<i class="fa fa-angle-left fa-5x" aria-hidden="true"></i>', '<i class="fa fa-angle-right fa-5x" aria-hidden="true"></i>'],
                pagination: <?php echo ($pagination[$banner_id]) ? 'true' : 'false'; ?>
            });
            --></script>
        </div>
    </div>
</div>
<!-- ********** End of slideshow ********** -->