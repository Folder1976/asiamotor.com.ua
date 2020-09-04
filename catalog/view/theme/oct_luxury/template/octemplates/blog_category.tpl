<?php echo $header; ?>
<div class="container">
    <ul class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
		    <?php foreach ($breadcrumbs as $count => $breadcrumb) { ?>
			    <?php if($count == 0) { ?>
				  <li>
					<a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $oct_home_text; ?>">
					  <?php echo $breadcrumb['text']; ?>
					</a>
				  </li>
		        <?php } elseif($count+1<count($breadcrumbs)) { ?>
		        	<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
					<a itemscope itemtype="https://schema.org/Thing" itemprop="item" href="<?php echo $breadcrumb['href']; ?>" itemid="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>">
					  <span itemprop="name"><?php echo $breadcrumb['text']; ?></span>
					</a>
					<meta itemprop="position" content="<?php echo $count; ?>" />
					</li>
		        <?php } else { ?>
		        	<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
		        	<span itemscope itemtype="https://schema.org/Thing" itemprop="item" itemid="<?php echo $breadcrumb['href']; ?>">
					  <span itemprop="name"><?php echo $breadcrumb['text']; ?></span>
					</span>
					<meta itemprop="position" content="<?php echo $count; ?>" />
		        	</li>
		        <?php } ?>
			<?php } ?>
	  </ul>
</div>
<?php echo $content_top; ?>
<div class="container">
  <div class="row top-row news-top-row">
	  <div class="col-sm-12">
		  <h1 class="cat-header"><?php echo $heading_title; ?></h1>
	  </div>
  </div>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>">
      <?php if ($articles) { ?>
      <div class="row news-row">
        <?php foreach ($articles as $article) { ?>
        <div class="product-layout product-list col-md-6 col-sm-6 col-xs-12">
          <div class="product-thumb">
            <div class="image"><a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class="img-responsive" /></a></div>
            <div>
              <div class="caption">
                <div class="h4"><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></div>
                <p><?php echo $article['description']; ?></p>
                	<div class="badge-box">
		                <i class="fa fa-clock-o" aria-hidden="true"></i>
		                <span class="badge"><?php echo $article['date_added']; ?></span>
		            </div>
		            <div class="badge-box">
		                <i class="fa fa-comment-o" aria-hidden="true"></i>
		                <span class="badge"><?php echo $article['comments']; ?></span>
		            </div>
		            <div class="badge-box">
		                <i class="fa fa-eye" aria-hidden="true"></i>
		                <span class="badge"><?php echo $article['viewed']; ?></span>
		            </div>
		            <div class="clearfix"></div>
              </div>
            </div>
          </div>
        </div>
        <?php } ?>
        </div>
      <div class="row pagination-row">
        <div class="col-sm-12 text-center"><?php echo $pagination; ?></div>
      </div>
      <?php } ?>
      <?php if (!$articles) { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php if ($thumb || $description) { ?>
	<div class="desc-cat">
		<div class="container">
		  <div class="row">
		    <?php if ($thumb) { ?>
		    <div class="col-sm-12 cat-img-thumbnail"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" /></div>
		    <?php } ?>
		    <?php if ($description) { ?>
		    <div class="col-sm-12 desc-cat-text"><?php echo $description; ?></div>
		    <div class="col-sm-12 desc-cat-button">
		    	<a class="button-more" id="desc-cat-button"><?php echo $button_continue; ?></a>
		    </div>
		    <?php } ?>
		  </div>
		</div>
	</div>
<?php } ?>
<script>
	function viewport() {
		    var e = window, a = 'inner';
		    if (!('innerWidth' in window)) {
		      a = 'client';
		      e = document.documentElement || document.body;
		    }
		    return { width : e[ a+'Width' ] , height : e[ a+'Height' ] };
		}
	    
        let ismobile = viewport().width;
   
  	    if (ismobile <= 992) {
	  	    $('#content').prepend($('.oct-article-categories-box'));
	  	}    
</script>	
<?php echo $footer; ?>
