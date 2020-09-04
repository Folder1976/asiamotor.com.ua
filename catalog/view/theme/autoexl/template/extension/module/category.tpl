

<div class="box select_car_wrapper navbar-ex1-collapse-car">
  <h3>Выбрать авто</h3>
  <div class="box_content box_content_cat select_car " style="font-family: 'PT Serif', serif;">
    <div id="select_car_mob" class="list-group">
            
      <select name="mark_id" id="mark_id" >
        <option value="0">Выбрать марку</option>
          <?php foreach($marks as $row){ ?>
            <?php if($mark_id == $row['mark_id']){ ?>
              <option selected value="<?php echo $row['mark_id']; ?>"><?php echo $row['mark_name']; ?></option>
            <?php }else{ ?>
              <option value="<?php echo $row['mark_id']; ?>"><?php echo $row['mark_name']; ?></option>
            <?php } ?>
          <?php } ?>
      </select>
      
      <select name="model_id" id="model_id" >
        <option value="0">Выбрать модель</option>
          <?php foreach($models as $row){ ?>
            <?php if($model_id == $row['model_id']){ ?>
              <option selected value="<?php echo $row['model_id']; ?>"><?php echo $row['model_name']; ?></option>
            <?php }else{ ?>
              <option value="<?php echo $row['model_id']; ?>"><?php echo $row['model_name']; ?></option>
            <?php } ?>
          <?php } ?>
      </select>
      
      <select name="year_id" id="year_id" >
        <option value="0">Год выпуска</option>
          <?php foreach($years as $year){ ?>
            <?php if(isset($year_id) AND $year_id == $year){ ?>
              <option selected value="<?php echo $year; ?>"><?php echo $year; ?></option>
            <?php }else{ ?>
              <option value="<?php echo $year; ?>"><?php echo $year; ?></option>
            <?php } ?>
          <?php } ?>
      </select>
      
      <select name="dvigun_id" id="dvigun_id" >
        <option value="0">Выбрать двигатель</option>
          <?php foreach($dviguns as $row){ ?>
            <?php if(isset($dvigun_id) AND $dvigun_id == $row['dvigunkey']){ ?>
              <option selected value="<?php echo $row['dvigunkey']; ?>"><?php echo $row['dvigun']; ?></option>
            <?php }else{ ?>
              <option value="<?php echo $row['dvigunkey']; ?>"><?php echo $row['dvigun']; ?></option>
            <?php } ?>
          <?php } ?>
      </select>
      
      <button id="filtercar" style="font-weight: bold">Выбрать</button>
      <button id="resetcar" style="color:red">Сбросить</button>
    </div>
  </div>
</div>


<div class="box category_wrapper">
  <h3><?php echo $heading_title; ?></h3>
  <div class="box_content box_content_cat" style="font-family: 'PT Serif', serif;">
    <div class="list-group">
      <?php foreach ($categories as $category) { ?>
      <?php if ($category['category_id'] == $category_id) { ?>
      <a href="<?php echo $category['href']; ?>" class="list-group-item active"><?php echo $category['name']; ?></a>
      <?php if ($category['children']) { ?>
      <?php foreach ($category['children'] as $child) { ?>
      <?php if ($child['category_id'] == $child_id) { ?>
      <a href="<?php echo $child['href']; ?>" style="font-size: 12px;background-color: #f5f5f5;" class="list-group-item active">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a>
      <?php } else { ?>
      <a href="<?php echo $child['href']; ?>" style="font-size: 12px;background-color: #f5f5f5;" class="list-group-item">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a>
      <?php } ?>
      <?php } ?>
      <?php } ?>
      <?php } else { ?>
      <a href="<?php echo $category['href']; ?>" class="list-group-item"><?php echo $category['name']; ?></a>
      <?php } ?>
      <?php } ?>
    </div>
  </div>
</div>

<script>
  $(document).on('click', '#resetcar', function(){
    
    $('#mark_id').val(0);
    $('#model_id').find('option:not(:first)').remove();
    $('#year_id').find('option:not(:first)').remove();
    $('#dvigun_id').find('option:not(:first)').remove();
    
    $.ajax({
      url: 'index.php?route=extension/module/category/resetcar',
      type: 'post',
      data: '',
      dataType: 'json',
      beforeSend: function () {
      },
      complete: function () {
      },
      success: function (json) {
          //console.log(json);
          location.reload();
      },
      error: function (xhr, ajaxOptions, thrownError) {
        console.log(thrownError + " " + xhr.statusText + " " + xhr.responseText);
      }
    });
  });
  
  $(document).on('click', '#filtercar', function(){
     $.ajax({
      url: 'index.php?route=extension/module/category/filtercar',
      type: 'post',
      data: '',
      dataType: 'text',
      beforeSend: function () {
      },
      complete: function () {
      },
      success: function (json) {
          //console.log(json);
          location.reload();
      },
      error: function (xhr, ajaxOptions, thrownError) {
        console.log(thrownError + " " + xhr.statusText + " " + xhr.responseText);
      }
    });
  });
  
   $(document).on('change', '#mark_id', function(){
    
    $('#model_id').find('option:not(:first)').remove();
    $('#year_id').find('option:not(:first)').remove();
    $('#dvigun_id').find('option:not(:first)').remove();
    
    $.ajax({
      url: 'index.php?route=extension/module/category/getmodels',
      type: 'post',
      data: $('#mark_id'),
      dataType: 'json',
      beforeSend: function () {
      },
      complete: function () {
      },
      success: function (json) {
        $.each(json, function(value, desc){
            $('#model_id').append($('<option />').prop("value", desc.model_id).text(desc.model_name));
        });
        
        //console.log(json);
      },
      error: function (xhr, ajaxOptions, thrownError) {
        console.log(thrownError + " " + xhr.statusText + " " + xhr.responseText);
      }
    });
  });
  
  $(document).on('change', '#model_id', function(){
    
    $('#year_id').find('option:not(:first)').remove();
    $('#dvigun_id').find('option:not(:first)').remove();

    $.ajax({
      url: 'index.php?route=extension/module/category/getyears',
      type: 'post',
      data: $('#mark_id, #model_id'),
      dataType: 'json',
      beforeSend: function () {
      },
      complete: function () {
      },
      success: function (json) {
        
        $.each(json, function(value, desc){
            $('#year_id').append($('<option />').prop("value", desc).text(desc));
        });
        
        console.log(json);
      },
      error: function (xhr, ajaxOptions, thrownError) {
        console.log(thrownError + " " + xhr.statusText + " " + xhr.responseText);
      }
    });
  });

 $(document).on('change', '#year_id', function(){
  
    $('#dvigun_id').find('option:not(:first)').remove();

    $.ajax({
      url: 'index.php?route=extension/module/category/getdviguns',
      type: 'post',
      data: $('#mark_id, #model_id, #year_id'),
      dataType: 'json',
      beforeSend: function () {
      },
      complete: function () {
      },
      success: function (json) {
        
        $.each(json, function(value, desc){
            $('#dvigun_id').append($('<option />').prop("value", desc.dvigunkey).text(desc.dvigun));
        });
        
        console.log(json);
      },
      error: function (xhr, ajaxOptions, thrownError) {
        console.log(thrownError + " " + xhr.statusText + " " + xhr.responseText);
      }
    });
  });

 $(document).on('change', '#dvigun_id', function(){
    $.ajax({
      url: 'index.php?route=extension/module/category/setdvigun',
      type: 'post',
      data: $('#mark_id, #model_id, #year_id, #dvigun_id'),
      dataType: 'text',
      beforeSend: function () {
      },
      complete: function () {
      },
      success: function (json) {
       
        console.log(json);
      },
      error: function (xhr, ajaxOptions, thrownError) {
        console.log(thrownError + " " + xhr.statusText + " " + xhr.responseText);
      }
    });
  });

$('.select_car_mob_btn').magnificPopup({
  type:'inline',
  midClick: true
});


</script>
<style>
  .select_car select, .select_car button,
  .mfp-content select, .mfp-content button {
    width: 100%;
    display: block;
    background: none;
    text-transform: uppercase;
    font-size: 14px;
    padding: 8px 8px 8px 0px;
    color: #107cab;
    margin-bottom: 3px;
}
.select_car_mob_btn {
  background: #0f97cb;
  background: url('/catalog/view/theme/autoexl/image/menu_ul_white.png');
  color: #fff;
  font-weight: 700;
  height: 52px;
  line-height: 38px;
}
.mfp-content {
  background: #fff;
  padding: 40px 25px 25px;
  margin: 0 auto;
  max-width: 300px;
}
.mfp-content #select_car_mob > * {
  width: 100%;
  margin-bottom: 10px;
}
.mfp-content #select_car_mob .mfp-close {
  width: 44px;
}

@media (min-width: 767px) {
.select_car .list-group.mfp-hide {
  display: block !important;
}
.select_car_mob_btn {
  display: none;
}
}
</style>