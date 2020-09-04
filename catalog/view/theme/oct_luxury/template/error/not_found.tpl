<?php echo $header; ?>
<?php echo $content_top; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $count=> $breadcrumb) { ?>
		<?php if($count == 0) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } elseif($count+1<count($breadcrumbs)) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } else { ?>
			<li><span><?php echo $breadcrumb['text']; ?></span></li>
		<?php } ?>
	<?php } ?>
  </ul>
</div>
<div class="container">
	<div class="row top-row">
	  <div class="col-sm-12">
		  <h1 class="cat-header"><?php echo $heading_title; ?></h1>
	  </div>
  </div>
  <div class="row">
    <div id="content">
      <?php if (isset($oct_404_image) && !empty($oct_404_image)) { ?>
          <div class="text-center oct-404-image"><img class="img-responsive" src="<?php echo $oct_404_image; ?>" /></div>
      <?php } ?>
      <div class="text-center"><?php echo $text_error; ?></div>
      </div>
    </div>
</div><?php echo $content_bottom; ?>
<?php echo $footer; ?>