<div class="oct-category-wall">
	<div class="container">
		<div class="row carousel-module-row">
			<div class="oct-category-wall-header carousel-module-row-header col-sm-12"><?php echo $heading_title; ?></div>
		</div>
		<div class="row oct-category-wall-items-box">
		  <?php foreach ($categories as $category) { ?>
		  		<div class="oct-category-wall-item col-lg-3 col-md-3 col-sm-4 col-xs-6">
		  			<?php if ($category['thumb']) { ?>
		  			<div class="oct-category-wall-item-icon">
		  				<a href="<?php echo $category['href']; ?>"><img class="img-responsive" src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" title="<?php echo $category['name']; ?>" /></a>
		  			</div>
				    <?php } ?>
				    <div class="oct-category-wall-item-text">
				    		<a href="<?php echo $category['href']; ?>" class="oct-category-wall-item-header"><?php echo $category['name']; ?></a>
				    		<?php if ($category['children']) { ?>
				    		<ul>
					      <?php $countstop = 1; foreach ($category['children'] as $child) { $countstop++; ?>
					        <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
					        <?php if ($countstop > $limit) { ?>
					        <li class="oct-category-wall-see-more"><a href="<?php echo $category['href']; ?>" ><?php echo $text_see_more; ?></a></li>
					        <?php break; } ?>
					      <?php } ?>
					    </ul>
					    <?php } ?>
				    </div>
				</div>
		  <?php } ?>
		</div>
	</div>
</div>