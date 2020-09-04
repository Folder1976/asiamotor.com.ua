<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-attribute">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <!--td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td-->
                  <td class="text-left">Марка авто</td>
                  <td class="text-left">Модель</td>
                  <td class="text-right">Года</td>
                  <td class="text-right">Двигатель</td>
                  <td class="text-right"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($cars) { ?>
                <?php foreach ($cars as $car) { ?>
                <tr style="background-color: #E9FFAF;">
                  <td class="text-left" colspan="4"><?php echo $car['mark_name']; ?></td>
                  <td class="text-right">
                    <a href="javascript:;" data-mark_id="<?php echo $car['mark_id']; ?>" data-model_id="0" title="<?php echo $button_delete; ?>" class="delete_key btn btn-danger"><i class="fa fa-trash-o"></i></a>
                  </td>
                </tr>
                
                    <?php foreach ($car['models'] as $model) { ?>
                    <tr>
                      <td class="text-left"></td>
                      <td class="text-left" colspan="3"><?php echo $model['model_name']; ?></td>
                      <td class="text-right">
                        <a href="javascript:;" data-mark_id="<?php echo $car['mark_id']; ?>" data-model_id="<?php echo $model['model_id']; ?>" title="<?php echo $button_delete; ?>" class="delete_key btn btn-danger"><i class="fa fa-trash-o"></i></a>
                      </td>
                    </tr>
                    <?php } ?>
                
                
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="5"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
  $(document).on('click', '.delete_key', function(){
    
    var mark_id = $(this).data('mark_id');
    var model_id = $(this).data('model_id');
    
    $(this).parents('tr').hide();
    
    console.log(mark_id+' '+model_id);
    $.ajax({
      url: 'index.php?route=catalog/cars/delete&token=<?php echo $_GET['token']; ?>',
      type: 'post',
      data: 'mark_id='+mark_id+'&model_id='+model_id,
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
</script>
<?php echo $footer; ?>
