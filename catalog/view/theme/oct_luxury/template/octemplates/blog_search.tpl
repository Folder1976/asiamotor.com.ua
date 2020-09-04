<?php echo $header; ?>
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
<?php echo $content_top; ?>
<div class="container">
	<div class="row top-row">
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
      <div class="row">
        <div class="col-sm-10">
          <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" class="form-control oct-blog-search-input" />
        </div>
        <div class="col-sm-2">
	        <input type="button" value="<?php echo $button_search; ?>" id="button-search" class="btn btn-primary" />
	     </div>     
      </div>
      
      <h2 class="oct-blog-search-h2"><?php echo $text_search; ?></h2>
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

      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
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
<script><!--
$('#button-search').bind('click', function() {
    url = 'index.php?route=octemplates/blog_search';
  
    var search = $('#content input[name=\'search\']').prop('value');
  
    if (search) {
      url += '&search=' + encodeURIComponent(search);
    }
  
    var category_id = $('#content select[name=\'category_id\']').prop('value');
  
    if (category_id > 0) {
      url += '&category_id=' + encodeURIComponent(category_id);
    }
  
    var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');
  
    if (sub_category) {
      url += '&sub_category=true';
    }
  
    var filter_description = $('#content input[name=\'description\']:checked').prop('value');
  
    if (filter_description) {
      url += '&description=true';
    }
  
    location = url;
  });
  
  $('#content input[name=\'search\']').bind('keydown', function(e) {
    if (e.keyCode == 13) {
      $('#button-search').trigger('click');
    }
  });
  
  $('select[name=\'category_id\']').on('change', function() {
    if (this.value == '0') {
      $('input[name=\'sub_category\']').prop('disabled', true);
    } else {
      $('input[name=\'sub_category\']').prop('disabled', false);
    }
  });
  
  $('select[name=\'category_id\']').trigger('change');
--></script>
<?php echo $footer; ?>
