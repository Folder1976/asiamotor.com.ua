<div class="panel panel-default oct-article-categories-box">
  <div class="panel-heading"><?php echo $heading_title; ?></div>
  <div class="list-group">
  <?php foreach ($categories as $category) { ?>
    <?php if ($category['oct_blog_category_id'] == $oct_blog_category_id) { ?>
      <a href="<?php echo $category['href']; ?>" class="list-group-item active"><?php echo $category['name']; ?></a>
      <?php if ($category['children']) { ?>
        <?php foreach ($category['children'] as $child) { ?>
          <?php if ($child['oct_blog_category_id'] == $oct_blog_category_child_id) { ?>
            <a href="<?php echo $child['href']; ?>" class="list-group-item active">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a>
          <?php } else { ?>
            <a href="<?php echo $child['href']; ?>" class="list-group-item">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a>
          <?php } ?>
        <?php } ?>
      <?php } ?>
    <?php } else { ?>
      <a href="<?php echo $category['href']; ?>" class="list-group-item"><?php echo $category['name']; ?></a>
    <?php } ?>
  <?php } ?>
  </div>
</div>
<?php if (isset($blog_search) && $blog_search) { ?>
<div class="box oct-article-categories-box">
  <div class="box-heading"><?php echo $heading_search; ?></div>
  <div class="box-content" id="search_block">
  <input type="text" name="search" value="<?php echo $search; ?>" placeholder="" id="input-blog_search" class="form-control" />
  <input type="button" value="<?php echo $button_search; ?>" id="do-search" class="button" />
  </div>
</div>
<script>
  $('#do-search').bind('click', function() {
    url = 'index.php?route=octemplates/blog_search';
  
    var search = $('#search_block input[name=\'search\']').prop('value');
  
    if (search) {
      url += '&search=' + encodeURIComponent(search);
    }  
    location = url;
  });
  
  $('#search_block input[name=\'search\']').bind('keydown', function(e) {
    if (e.keyCode == 13) {
      $('#do-search').trigger('click');
    }
  });
</script>
<?php } ?>