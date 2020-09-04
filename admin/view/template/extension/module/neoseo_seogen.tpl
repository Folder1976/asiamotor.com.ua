<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php');
$widgets = new NeoSeoWidgets('neoseo_seogen_', $params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;

function button_rewrite($field, $value)
{
    ?>
    <input type="hidden" name="<?php echo $field; ?>" value="<?php echo $value; ?>"/>
    <div class="input-group-btn">
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <?php if (!$value) { ?>
                <i class="fa fa-times"></i> Не перезаписывать
            <?php } else { ?>
                <i class="fa fa-check"></i> Перезаписывать
            <?php } ?>
            <span class="caret"></span>
        </button>
        <ul class="rewrite dropdown-menu dropdown-menu-right">
            <li><a href="#0"><i class="fa fa-times"></i> Не перезаписывать</a></li>
            <li><a href="#1"><i class="fa fa-check"></i> Перезаписывать</a></li>
        </ul>
    </div><!-- /btn-group -->
    <?php
}

function dropdown_rewrite($field, $value)
{
    ?>
    <br>
    <select class="form-control" name="<?php echo $field; ?>" value="<?php echo $value; ?>">
        <option value="0"><i class="fa fa-times"></i> Не перезаписывать</option>
        <option value="1" <?php if ($value) { ?>selected="selected"<?php } ?> ><i class="fa fa-check"></i>Перезаписывать</option>
    </select><!-- /btn-group -->
    <?php
}

?>

<div id="content">

    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if (!isset($license_error)) { ?>
                    <a onclick="$('#form').attr('action', '<?php echo $save; ?>'); $('#form').submit();" title="<?php echo $button_save; ?>" class="btn btn-primary">
                        <i class="fa fa-save"></i> <?php echo $button_save; ?>
                    </a>
                    <a onclick="$('#form').attr('action', '<?php echo $save_and_close; ?>'); $('#form').submit();" title="<?php echo $button_save_and_close; ?>" class="btn btn-default">
                        <i class="fa fa-save"></i> <?php echo $button_save_and_close; ?>
                    </a>
                <?php } else { ?>
                    <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>" class="btn btn-primary"/>
                        <i class="fa fa-check"></i> <?php echo $button_recheck; ?>
                    </a>
                <?php } ?>
                <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default">
                    <i class="fa fa-close"></i> <?php echo $button_close; ?>
                </a>
            </div>
            <img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
            <h1><?php echo $heading_title_raw . " " . $text_module_version; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>

    <div class="container-fluid">
        <?php if ($error_warning) { ?>
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <?php if (isset($success) && $success) { ?>
            <div class="alert alert-success">
                <i class="fa fa-check-circle"></i>
                <?php echo $success; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-body">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                    <?php if (!isset($license_error)) { ?>
                        <li><a href="#tab-products" data-toggle="tab"><?php echo $tab_products; ?></a></li>
                        <li><a href="#tab-categories" data-toggle="tab"><?php echo $tab_categories; ?></a></li>
                        <li><a href="#tab-manufacturers" data-toggle="tab"><?php echo $tab_manufacturers; ?></a></li>
                        <li><a href="#tab-articles" data-toggle="tab"><?php echo $tab_articles; ?></a></li>
						<li><a href="#tab-blogs" data-toggle="tab"><?php echo $tab_blogs; ?></a></li>
                        <li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
                    <?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">

                            <?php if (!isset($license_error)) { ?>

                                <?php $widgets->dropdown('status', array(0 => $text_disabled, 1 => $text_enabled)); ?>
                                <?php $widgets->input('limit_title'); ?>
                                <?php $widgets->input('limit_description'); ?>
                                <?php $widgets->dropdown('language', $select_languages); ?>
                                <?php $widgets->textarea('remove_list'); ?>
                                <?php $widgets->text('cron'); ?>

                            <?php } else { ?>

                                <?php echo $license_error; ?>

                            <?php } ?>

                        </div>

                        <?php if (!isset($license_error)) { ?>
                            <div class="tab-pane" id="tab-products">
                                <table class="table" id="table_products">
                                    <tr align="right">
                                        <td colspan="3">
                                            <div id="progress-products" class="progress" style="margin-top:20px; display:none">
                                                <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">0%</div>
                                            </div>
                                            <a onclick="generateProducts();" class="btn btn-primary"><i class="fa fa-cog"></i>&nbsp;<?php echo $text_generate; ?></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_products_seo_url; ?></td>
                                        <td class="col-xs-9">
                                            <div class="input-group">
                                                <input class="form-control" name="neoseo_seogen_products[seo_url]" value="<?php echo $neoseo_seogen_products['seo_url']; ?>"/>
                                                <?php echo button_rewrite("neoseo_seogen_products[seo_url_rewrite]", $neoseo_seogen_products['seo_url_rewrite']); ?>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_products_h1; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_products_h1_<?php echo $language['language_id']?>" name="neoseo_seogen_products[<?php echo $language['language_id']; ?>][h1]" value="<?php echo isset($neoseo_seogen_products[$language['language_id']]) ? $neoseo_seogen_products[$language['language_id']]['h1'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_products[" . $language['language_id'] . "][h1_rewrite]", $neoseo_seogen_products[$language['language_id']]['h1_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_products_title; ?>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_products_title_<?php echo $language['language_id']?>" name="neoseo_seogen_products[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($neoseo_seogen_products[$language['language_id']]) ? $neoseo_seogen_products[$language['language_id']]['title'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_products[" . $language['language_id'] . "][title_rewrite]", $neoseo_seogen_products[$language['language_id']]['title_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_products_keywords; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_products_keywords_<?php echo $language['language_id']?>" name="neoseo_seogen_products[<?php echo $language['language_id']; ?>][keywords]" value="<?php echo isset($neoseo_seogen_products[$language['language_id']]) ? $neoseo_seogen_products[$language['language_id']]['keywords'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_products[" . $language['language_id'] . "][keywords_rewrite]", $neoseo_seogen_products[$language['language_id']]['keywords_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_products_description; ?></td>
                                        <td class="col-xs-9">

                                            <ul class="nav nav-tabs">
                                                <?php foreach ($languages as $language) { ?>
                                                    <li class="<?php echo $language['language_id'] == 1 ? 'active' : ''; ?>">
                                                        <a href="#products-<?php echo $language['language_id']; ?>" data-toggle="tab">
                                                            <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>">
                                                            <?php echo $language['name']; ?>
                                                        </a>
                                                    </li>
                                                <?php } ?>
                                            </ul>
                                            <div class="tab-content">
                                                <?php foreach ($languages as $language) { ?>
                                                    <div class="tab-pane <?php echo $language['language_id'] == 1 ? 'active' : ''; ?>" id="products-<?php echo $language['language_id']; ?>">
                                                        <textarea rows="6" class="form-control" type="text" id="neoseo_seogen_products_description_<?php echo $language['language_id']?>" name="neoseo_seogen_products[<?php echo $language['language_id']; ?>][description]"><?php echo isset($neoseo_seogen_products[$language['language_id']]) ? $neoseo_seogen_products[$language['language_id']]['description'] : ''; ?></textarea>
                                                        <?php echo dropdown_rewrite("neoseo_seogen_products[" . $language['language_id'] . "][description_rewrite]", $neoseo_seogen_products[$language['language_id']]['description_rewrite']); ?>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        <?php } ?>

                        <?php if (!isset($license_error)) { ?>
                            <div class="tab-pane" id="tab-categories">
                                <table class="table" id="table_categories">
                                    <tr style="text-align: right;">
                                        <td colspan="3">
                                            <div id="progress-categories" class="progress" style="margin-top:20px; display:none">
                                                <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">0%</div>
                                            </div>
                                            <a onclick="generateCategories();" class="btn btn-primary"><i class="fa fa-cog"></i>&nbsp;<?php echo $text_generate; ?></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_categories_seo_url; ?></td>
                                        <td class="col-xs-9">
                                            <div class="input-group">
                                                <input class="form-control" name="neoseo_seogen_categories[seo_url]" value="<?php echo $neoseo_seogen_categories['seo_url']; ?>"/>
                                                <?php echo button_rewrite("neoseo_seogen_categories[seo_url_rewrite]", $neoseo_seogen_categories['seo_url_rewrite']); ?>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_categories_h1; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_categories_h1_<?php echo $language['language_id']?>" name="neoseo_seogen_categories[<?php echo $language['language_id']; ?>][h1]" value="<?php echo isset($neoseo_seogen_categories[$language['language_id']]) ? $neoseo_seogen_categories[$language['language_id']]['h1'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_categories[" . $language['language_id'] . "][h1_rewrite]", $neoseo_seogen_categories[$language['language_id']]['h1_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_categories_title; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_categories_title_<?php echo $language['language_id']?>" name="neoseo_seogen_categories[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($neoseo_seogen_categories[$language['language_id']]) ? $neoseo_seogen_categories[$language['language_id']]['title'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_categories[" . $language['language_id'] . "][title_rewrite]", $neoseo_seogen_categories[$language['language_id']]['title_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_categories_keywords; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_categories_keywords_<?php echo $language['language_id']?>" name="neoseo_seogen_categories[<?php echo $language['language_id']; ?>][keywords]" value="<?php echo isset($neoseo_seogen_categories[$language['language_id']]) ? $neoseo_seogen_categories[$language['language_id']]['keywords'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_categories[" . $language['language_id'] . "][keywords_rewrite]", $neoseo_seogen_categories[$language['language_id']]['keywords_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_categories_description; ?></td>
                                        <td class="col-xs-9">

                                            <ul class="nav nav-tabs">
                                                <?php foreach ($languages as $language) { ?>
                                                    <li class="<?php echo $language['language_id'] == 1 ? 'active' : ''; ?>">
                                                        <a href="#categories-<?php echo $language['language_id']; ?>" data-toggle="tab">
                                                            <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>">
                                                            <?php echo $language['name']; ?>
                                                        </a>
                                                    </li>
                                                <?php } ?>
                                            </ul>
                                            <div class="tab-content">
                                                <?php foreach ($languages as $language) { ?>
                                                    <div class="tab-pane <?php echo $language['language_id'] == 1 ? 'active' : ''; ?>" id="categories-<?php echo $language['language_id']; ?>">
                                                        <textarea rows="6" class="form-control" id="neoseo_seogen_categories_description_<?php echo $language['language_id']?>" type="text" name="neoseo_seogen_categories[<?php echo $language['language_id']; ?>][description]"><?php echo isset($neoseo_seogen_categories[$language['language_id']]) ? $neoseo_seogen_categories[$language['language_id']]['description'] : ''; ?></textarea>
                                                        <?php echo dropdown_rewrite("neoseo_seogen_categories[" . $language['language_id'] . "][description_rewrite]", $neoseo_seogen_categories[$language['language_id']]['description_rewrite']); ?>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        <?php } ?>

                        <?php if (!isset($license_error)) { ?>
                            <div class="tab-pane" id="tab-manufacturers">
                                <table class="table" id="table_manufacturers">
                                    <tr style="text-align: right;">
                                        <td colspan="3">
                                            <div id="progress-manufacturers" class="progress" style="margin-top:20px; display:none">
                                                <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">0%
                                                </div>
                                            </div>
                                            <a onclick="generateManufacturers();" class="btn btn-primary"><i
                                                        class="fa fa-cog"></i>&nbsp;<?php echo $text_generate; ?></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"> <?php echo $entry_manufacturers_seo_url; ?></td>
                                        <td class="col-xs-9">
                                            <div class="input-group">
                                                <input class="form-control" name="neoseo_seogen_manufacturers[seo_url]" value="<?php echo $neoseo_seogen_manufacturers['seo_url']; ?>"/>
                                                <?php echo button_rewrite("neoseo_seogen_manufacturers[seo_url_rewrite]", $neoseo_seogen_manufacturers['seo_url_rewrite']); ?>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_manufacturers_h1; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_manufacturers_h1_<?php echo $language['language_id']?>" name="neoseo_seogen_manufacturers[<?php echo $language['language_id']; ?>][h1]" value="<?php echo isset($neoseo_seogen_manufacturers[$language['language_id']]) ? $neoseo_seogen_manufacturers[$language['language_id']]['h1'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_manufacturers[" . $language['language_id'] . "][h1_rewrite]", $neoseo_seogen_manufacturers[$language['language_id']]['h1_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_manufacturers_title; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_manufacturers_title_<?php echo $language['language_id']?>" name="neoseo_seogen_manufacturers[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($neoseo_seogen_manufacturers[$language['language_id']]) ? $neoseo_seogen_manufacturers[$language['language_id']]['title'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_manufacturers[" . $language['language_id'] . "][title_rewrite]", $neoseo_seogen_manufacturers[$language['language_id']]['title_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_manufacturers_keywords; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_manufacturers_keywords_<?php echo $language['language_id']?>" name="neoseo_seogen_manufacturers[<?php echo $language['language_id']; ?>][keywords]" value="<?php echo isset($neoseo_seogen_manufacturers[$language['language_id']]) ? $neoseo_seogen_manufacturers[$language['language_id']]['keywords'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_manufacturers[" . $language['language_id'] . "][keywords_rewrite]", $neoseo_seogen_manufacturers[$language['language_id']]['keywords_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_manufacturers_description; ?></td>
                                        <td class="col-xs-9">
                                            <ul class="nav nav-tabs">
                                                <?php foreach ($languages as $language) { ?>
                                                    <li class="<?php echo $language['language_id'] == 1 ? 'active' : ''; ?>">
                                                        <a href="#manufacturers-<?php echo $language['language_id']; ?>" data-toggle="tab">
                                                            <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>">
                                                            <?php echo $language['name']; ?>
														</a>
													</li>
                                                <?php } ?>
                                            </ul>
                                            <div class="tab-content">
                                                <?php foreach ($languages as $language) { ?>
                                                    <div class="tab-pane <?php echo $language['language_id'] == 1 ? 'active' : ''; ?>" id="manufacturers-<?php echo $language['language_id']; ?>">
                                                        <textarea rows="6" class="form-control" type="text" id="neoseo_seogen_manufacturers_description_<?php echo $language['language_id']?>" name="neoseo_seogen_manufacturers[<?php echo $language['language_id']; ?>][description]"><?php echo isset($neoseo_seogen_manufacturers[$language['language_id']]) ? $neoseo_seogen_manufacturers[$language['language_id']]['description'] : ''; ?></textarea>
                                                        <?php echo dropdown_rewrite("neoseo_seogen_manufacturers[" . $language['language_id'] . "][description_rewrite]", $neoseo_seogen_manufacturers[$language['language_id']]['description_rewrite']); ?>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        <?php } ?>

                        <?php if (!isset($license_error)) { ?>
                            <div class="tab-pane" id="tab-articles">
                                <table class="table" id="table_articles">
                                    <tr style="text-align: right;">
                                        <td colspan="3">
                                            <div id="progress-informations" class="progress" style="margin-top:20px; display:none">
                                                <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">0%
                                                </div>
                                            </div>
                                            <a onclick="generateInformations();" class="btn btn-primary"><i class="fa fa-cog"></i>&nbsp;<?php echo $text_generate; ?></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_articles_seo_url; ?></td>
                                        <td class="col-xs-9">
                                            <div class="input-group">
                                                <input class="form-control" name="neoseo_seogen_articles[seo_url]" value="<?php echo $neoseo_seogen_articles['seo_url']; ?>"/>
                                                <?php echo button_rewrite("neoseo_seogen_articles[seo_url_rewrite]", $neoseo_seogen_articles['seo_url_rewrite']); ?>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_articles_h1; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_articles_h1_<?php echo $language['language_id']?>" name="neoseo_seogen_articles[<?php echo $language['language_id']; ?>][h1]" value="<?php echo isset($neoseo_seogen_articles[$language['language_id']]) ? $neoseo_seogen_articles[$language['language_id']]['h1'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_articles[" . $language['language_id'] . "][h1_rewrite]", $neoseo_seogen_articles[$language['language_id']]['h1_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_articles_title; ?></td>
                                        <td class="col-xs-9"><?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_articles_title_<?php echo $language['language_id']?>" name="neoseo_seogen_articles[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($neoseo_seogen_articles[$language['language_id']]) ? $neoseo_seogen_articles[$language['language_id']]['title'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_articles[" . $language['language_id'] . "][title_rewrite]", $neoseo_seogen_articles[$language['language_id']]['title_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_articles_keywords; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" id="neoseo_seogen_articles_keywords_<?php echo $language['language_id']?>" name="neoseo_seogen_articles[<?php echo $language['language_id']; ?>][keywords]" value="<?php echo isset($neoseo_seogen_articles[$language['language_id']]) ? $neoseo_seogen_articles[$language['language_id']]['keywords'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_articles[" . $language['language_id'] . "][keywords_rewrite]", $neoseo_seogen_articles[$language['language_id']]['keywords_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_articles_description; ?></td>
                                        <td class="col-xs-9">
                                            <ul class="nav nav-tabs">
                                                <?php foreach ($languages as $language) { ?>
                                                    <li class="<?php echo $language['language_id'] == 1 ? 'active' : ''; ?>">
                                                        <a href="#description-<?php echo $language['language_id']; ?>" data-toggle="tab">
                                                            <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>">
                                                            <?php echo $language['name']; ?>
														</a>
													</li>
                                                <?php } ?>
                                            </ul>
                                            <div class="tab-content">
                                                <?php foreach ($languages as $language) { ?>
                                                    <div class="tab-pane <?php echo $language['language_id'] == 1 ? 'active' : ''; ?>" id="description-<?php echo $language['language_id']; ?>">
                                                        <textarea rows="6" class="form-control" id="neoseo_seogen_articles_description_<?php echo $language['language_id']?>" type="text" name="neoseo_seogen_articles[<?php echo $language['language_id']; ?>][description]"><?php echo isset($neoseo_seogen_articles[$language['language_id']]) ? $neoseo_seogen_articles[$language['language_id']]['description'] : ''; ?></textarea>
                                                        <?php echo dropdown_rewrite("neoseo_seogen_articles[" . $language['language_id'] . "][description_rewrite]", $neoseo_seogen_articles[$language['language_id']]['description_rewrite']); ?>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        <?php } ?>

                        <?php if (!isset($license_error)) { ?>
                            <div class="tab-pane" id="tab-blogs">
                                <table class="table" id="table_blogs">
                                    <tr style="text-align: right;">
                                        <td colspan="3">
                                            <div id="progress-blogs" class="progress" style="margin-top:20px; display:none">
                                                <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">0%
                                                </div>
                                            </div>
                                            <a onclick="generateBlogs();" class="btn btn-primary"><i class="fa fa-cog"></i>&nbsp;<?php echo $text_generate; ?></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_blogs_seo_url; ?></td>
                                        <td class="col-xs-9">
                                            <div class="input-group">
                                                <input class="form-control" name="neoseo_seogen_blogs[seo_url]" value="<?php echo $neoseo_seogen_blogs['seo_url']; ?>"/>
                                                <?php echo button_rewrite("neoseo_seogen_blogs[seo_url_rewrite]", $neoseo_seogen_blogs['seo_url_rewrite']); ?>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_blogs_h1; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" name="neoseo_seogen_blogs[<?php echo $language['language_id']; ?>][h1]" value="<?php echo isset($neoseo_seogen_blogs[$language['language_id']]) ? $neoseo_seogen_blogs[$language['language_id']]['h1'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_blogs[" . $language['language_id'] . "][h1_rewrite]", $neoseo_seogen_blogs[$language['language_id']]['h1_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_blogs_title; ?></td>
                                        <td class="col-xs-9"><?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" name="neoseo_seogen_blogs[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($neoseo_seogen_blogs[$language['language_id']]) ? $neoseo_seogen_blogs[$language['language_id']]['title'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_blogs[" . $language['language_id'] . "][title_rewrite]", $neoseo_seogen_blogs[$language['language_id']]['title_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_blogs_keywords; ?></td>
                                        <td class="col-xs-9">
                                            <?php foreach ($languages as $language) { ?>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>"></span>
                                                    <input class="form-control" type="text" name="neoseo_seogen_blogs[<?php echo $language['language_id']; ?>][keywords]" value="<?php echo isset($neoseo_seogen_blogs[$language['language_id']]) ? $neoseo_seogen_blogs[$language['language_id']]['keywords'] : ''; ?>"/>
                                                    <?php echo button_rewrite("neoseo_seogen_blogs[" . $language['language_id'] . "][keywords_rewrite]", $neoseo_seogen_blogs[$language['language_id']]['keywords_rewrite']); ?>
                                                </div>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col-xs-3"><?php echo $entry_blogs_description; ?></td>
                                        <td class="col-xs-9">
                                            <ul class="nav nav-tabs">
                                                <?php foreach ($languages as $language) { ?>
                                                    <li class="<?php echo $language['language_id'] == 1 ? 'active' : ''; ?>">
                                                        <a href="#blog-description-<?php echo $language['language_id']; ?>" data-toggle="tab">
                                                            <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>">
                                                            <?php echo $language['name']; ?>
														</a>
													</li>
                                                <?php } ?>
                                            </ul>
                                            <div class="tab-content">
                                                <?php foreach ($languages as $language) { ?>
                                                    <div class="tab-pane <?php echo $language['language_id'] == 1 ? 'active' : ''; ?>" id="blog-description-<?php echo $language['language_id']; ?>">
                                                        <textarea rows="6" class="form-control" type="text" name="neoseo_seogen_blogs[<?php echo $language['language_id']; ?>][description]"><?php echo isset($neoseo_seogen_blogs[$language['language_id']]) ? $neoseo_seogen_blogs[$language['language_id']]['description'] : ''; ?></textarea>
                                                        <?php echo dropdown_rewrite("neoseo_seogen_blogs[" . $language['language_id'] . "][description_rewrite]", $neoseo_seogen_blogs[$language['language_id']]['description_rewrite']); ?>
                                                    </div>
                                                <?php } ?>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        <?php } ?>

                        <?php if (!isset($license_error)) { ?>
                            <div class="tab-pane" id="tab-logs">
                                <?php $widgets->debug_and_logs('debug', array(0 => $text_disabled, 1 => $text_enabled), $clear, $button_clear_log); ?>
                                <textarea class="form-control" style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
                            </div>
                        <?php } ?>

                        <div class="tab-pane" id="tab-support">
                            <?php echo $mail_support; ?>
                        </div>

                        <div class="tab-pane" id="tab-license">
                            <?php echo $module_licence; ?>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <a id="generate_url" style="display: none" href="<?php echo $generate ?>"></a>
</div>
<script>
    $('.rewrite a').click(function (e) {
        e.preventDefault();
        var value = $(this).attr('href').replace("#", "");
        var textValue = $(this).html();
        $(this).parents(".input-group").find("[type=hidden]").val(value);
        $(this).parents(".input-group").find("button").html(textValue);
    });
</script>
<?php echo $footer; ?>
<script type="text/javascript"><!--
    if (window.location.hash.indexOf('#tab') == 0 && $("[href=" + window.location.hash + "]").length) {
        $(".panel-body > .nav-tabs li").removeClass("active");
        $("[href=" + window.location.hash + "]").parents('li').addClass("active");
        $(".panel-body:first .tab-content:first .tab-pane:first").removeClass("active");
        $(window.location.hash).addClass("active");
    }
    $(".nav-tabs li a").click(function () {
        var url = $(this).prop('href');
        window.location.hash = url.substring(url.indexOf('#'));
    });
    // Специальный фикс системной функции, поскольку даниель понятия не имеет о том что в url может быть еще и hash
    // и по итогу этот hash становится частью token
    function getURLVar(key) {
        var value = [];

        var url = String(document.location);
        if (url.indexOf('#') != -1) {
            url = url.substring(0, url.indexOf('#'));
        }
        var query = url.split('?');

        if (query[1]) {
            var part = query[1].split('&');

            for (i = 0; i < part.length; i++) {
                var data = part[i].split('=');

                if (data[0] && data[1]) {
                    value[data[0]] = data[1];
                }
            }

            if (value[key]) {
                return value[key];
            } else {
                return '';
            }
        }
    }

    //--></script>
<script type="text/javascript"><!--

    var products = [];
    var productsCurrent = [];
    var generateProgressId = 0;
    var generateUrl = '';

    function generateNext() {
        var product = productsCurrent.shift();
        if (!product) {
            $(generateProgressId).hide();
            return;
        }

        var index = products.length - productsCurrent.length;
        var total = products.length;
        var percent = Number(index * 100 / total).toFixed(0);
        $(generateProgressId + " .progress-bar").prop("aria-valuenow", percent);
        $(generateProgressId + " .progress-bar").css("width", percent + "%");
        $(generateProgressId + " .progress-bar").html(index + " из " + total);

        $.ajax({
            url: generateUrl,
            data: {id: product},
            dataType: 'json'
        }).done(function () {
            generateNext();
        });
    }

    function generateProducts() {
        generateUrl = '<?php echo str_replace("&amp;", "&", $urlify_product_url); ?>';
        generateProgressId = '#progress-products';
        $(generateProgressId).show();

        $.ajax({
            url: generateUrl,
            dataType: 'json'
        }).done(function (json) {
            products = json;
            productsCurrent = products.slice(0);
            generateNext();
        });
    }

    function generateCategories() {
        generateUrl = '<?php echo str_replace("&amp;", "&", $urlify_category_url); ?>';
        generateProgressId = '#progress-categories';
        $(generateProgressId).show();

        $.ajax({
            url: generateUrl,
            dataType: 'json'
        }).done(function (json) {
            products = json;
            productsCurrent = products.slice(0);
            generateNext();
        });
    }

    function generateManufacturers() {
        generateUrl = '<?php echo str_replace("&amp;", "&", $urlify_manufacturer_url); ?>';
        generateProgressId = '#progress-manufacturers';
        $(generateProgressId).show();

        $.ajax({
            url: generateUrl,
            dataType: 'json'
        }).done(function (json) {
            products = json;
            productsCurrent = products.slice(0);
            generateNext();
        });
    }

    function generateInformations() {
        generateUrl = '<?php echo str_replace("&amp;", "&", $urlify_information_url); ?>';
        generateProgressId = '#progress-informations';
        $(generateProgressId).show();

        $.ajax({
            url: generateUrl,
            dataType: 'json'
        }).done(function (json) {
            products = json;
            productsCurrent = products.slice(0);
            generateNext();
        });
    }

    function generateBlogs() {
        generateUrl = '<?php echo str_replace("&amp;", "&", $urlify_blog_url); ?>';
        generateProgressId = '#progress-blogs';
        $(generateProgressId).show();

        $.ajax({
            url: generateUrl,
            dataType: 'json'
        }).done(function (json) {
            products = json;

			if (typeof products.no_records !== 'undefined') {
				$(generateProgressId).hide();
				return;
			}

            productsCurrent = products.slice(0);
            generateNext();
        });
    }
    //--></script>
<script>
$(document).ready(function(e) {
	var elements = [];
	<?php foreach($languages as $language){ ?>
		elements.push("#neoseo_seogen_products_h1_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_products_keywords_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_products_title_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_products_description_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_categories_h1_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_categories_keywords_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_categories_title_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_categories_description_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_manufacturers_h1_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_manufacturers_keywords_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_manufacturers_title_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_manufacturers_description_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_articles_h1_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_articles_keywords_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_articles_title_<?php echo $language['language_id']?>");
		elements.push("#neoseo_seogen_articles_description_<?php echo $language['language_id']?>");
	<?php } ?>
	elements = elements.join(',');
	$(elements).emojiPicker({
		height: '220',
		position: 'left',
	});
});
</script>