<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-city" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-city" class="form-horizontal">

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-alias">Алиас/ЧПУ</label>
            <div class="col-sm-10">
              <input type="text" name="alias" value="<?php echo $alias; ?>" placeholder="" id="input-alias" class="form-control" />
            </div>
          </div>
		  

          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
            <div class="col-sm-10">
              <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
            </div>
          </div>
		  
		  <div class="form-group required">
            <label class="col-sm-4 control-label"><?php echo $entry_name; ?> @name@</label>
            <div class="col-sm-8">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                <input type="text" name="city_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
              </div>
              <?php if (isset($error_name[$language['language_id']])) { ?>
              <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
              <?php } ?>
              <?php } ?>
            </div>
          </div>

		  <div class="form-group required">
            <label class="col-sm-4 control-label"><?php echo $entry_name; ?> Родительный (Кого? Чего?) @name_rod@</label>
            <div class="col-sm-8">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                <input type="text" name="city_description[<?php echo $language['language_id']; ?>][name_rod]"
				value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['name_rod'] : ''; ?>"
				placeholder="<?php echo $entry_name; ?>" class="form-control" />
              </div>
              <?php } ?>
            </div>
          </div>

		  <div class="form-group required">
            <label class="col-sm-4 control-label"><?php echo $entry_name; ?> Дательный (Кому? Чему?) @name_dat@</label>
            <div class="col-sm-8">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                <input type="text" name="city_description[<?php echo $language['language_id']; ?>][name_dat]"
				value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['name_dat'] : ''; ?>"
				placeholder="<?php echo $entry_name; ?>" class="form-control" />
              </div>
              <?php } ?>
            </div>
          </div>

		  <div class="form-group required">
            <label class="col-sm-4 control-label">Телефон @telephone@</label>
            <div class="col-sm-8">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                <input type="text" name="city_description[<?php echo $language['language_id']; ?>][telephone]"
				value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['telephone'] : ''; ?>"
				placeholder="<?php echo $entry_name; ?>" class="form-control" />
              </div>
              <?php } ?>
            </div>
          </div>

		  <div class="form-group">
            <label class="col-sm-4 control-label">Запасное поле @text1@</label>
            <div class="col-sm-8">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                <input type="text" name="city_description[<?php echo $language['language_id']; ?>][text1]"
				value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['text1'] : ''; ?>"
				placeholder="Запасное поле @text1@" class="form-control" />
              </div>
              <?php } ?>
            </div>
          </div>

		  <div class="form-group">
            <label class="col-sm-4 control-label">Запасное поле @text2@</label>
            <div class="col-sm-8">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                <input type="text" name="city_description[<?php echo $language['language_id']; ?>][text2]"
				value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['text2'] : ''; ?>"
				placeholder="Запасное поле @text2@" class="form-control" />
              </div>
              <?php } ?>
            </div>
          </div>

		  <div class="form-group">
            <label class="col-sm-4 control-label">Запасное поле @text3@</label>
            <div class="col-sm-8">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                <input type="text" name="city_description[<?php echo $language['language_id']; ?>][text3]"
				value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['text3'] : ''; ?>"
				placeholder="Запасное поле @text3@" class="form-control" />
              </div>
              <?php } ?>
            </div>
          </div>

		  <div class="form-group">
            <label class="col-sm-4 control-label">Запасное поле @text4@</label>
            <div class="col-sm-8">
              <?php foreach ($languages as $language) { ?>
              <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                <input type="text" name="city_description[<?php echo $language['language_id']; ?>][text4]"
				value="<?php echo isset($city_description[$language['language_id']]) ? $city_description[$language['language_id']]['text4'] : ''; ?>"
				placeholder="Запасное поле @text4@" class="form-control" />
              </div>
              <?php } ?>
            </div>
          </div>




        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>
