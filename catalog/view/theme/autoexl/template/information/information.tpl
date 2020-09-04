<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
      <div class="info_page">
        <?php echo $description; ?>
      </div>
      <?php echo $content_bottom; ?>
    </div>
    <?php echo $column_right; ?></div>
  
    <?php if(isset($citys)){ ?>
    <div class="col-xs-12">
      <div class="sitemap">
          <div class="col-xs-8">
            <h2 class="blue"><a href="javascript:;" class="view_citys">Список городов доставки:</a></h2>
          </div>
          <div class="col-xs-4">
            <h3 class="blue text-right"><a href="javascript:;" class="view_citys"  style="color: #E00000 !important;">Развернуть список</a></h2>  
          </div>
          <div class="box clear">
            <div class="box-content">
              <div class="box-content-shirma">
              </div>
              <ul class="col5">
                <?php foreach($citys as $row){ ?>
                <li>
                  <a href="<?php echo $main_href; ?>/<?php echo $row['alias']; ?>"><?php echo $row['name']; ?></a><br>
                </li>
                <?php } ?>
              </ul>
            </div>
          </div>
          
      </div>
    </div>
    <?php } ?>
</div>
<?php echo $footer; ?>
<script>
  $(document).on('click', '.view_citys', function(){
    $('.box-content').css("max-height","max-content");
  });
</script>
<style>
  
  .box-content{
    max-height: 200px;
    overflow: hidden;
  }
  
  .sitemap ul {    
      list-style: none;
  }
  
  .sitemap ul.col5 {
      columns: 5;
  }
  @media (max-width: 1199px) and (min-width: 992px){
    .sitemap ul.col5 {
      columns: 4;
    }
  }
  @media (max-width: 991px) and (min-width: 768px){
    .sitemap ul.col5 {
        columns: 3;
    }
  }
  @media (max-width: 767px){
    .sitemap ul.col5 {
        columns: 1;
    }
  }
</style>