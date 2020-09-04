<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><span style="margin:0;line-height: 24px;">NeoSeo Обмен с 1C</span>';
$_['heading_title_raw'] = 'NeoSeo Обмен с 1C';

//Tabs
$_['tab_general'] = 'Параметры';
$_['tab_logs'] = 'Логи';
$_['tab_product'] = 'Товары';
$_['tab_price'] = 'Цены';
$_['tab_quantity'] = 'Остатки';
$_['tab_category'] = 'Категории';
$_['tab_manufacturer'] = 'Производители';
$_['tab_attribute'] = 'Атрибуты';
$_['tab_option'] = 'Опции';
$_['tab_order'] = 'Заказы';
$_['tab_support'] = 'Поддержка';
$_['tab_license'] = 'Лицензия';
$_['tab_filter'] = 'Фильтр';

// Text
$_['text_module'] = 'Модули';
$_['text_success'] = 'Настройки модуля обновлены!';
$_['text_import_warning'] = 'Импорт может отнять длительное время';
$_['text_upload_success'] = 'Импорт завершен';
$_['text_upload_error'] = 'Что-то пошло не так. Загляните в логи';
$_['text_max_filesize'] = 'Загружаемый файл не должен превышать %s Мб';
$_['text_success_clear'] = 'Логи успешно очищены';
$_['text_bynone'] = 'Отключено';
$_['text_bysku'] = 'По артикулу';
$_['text_byname'] = 'По артикулу, затем по имени';
$_['text_bymodel'] = 'По артикулу в модели';
$_['text_bycode'] = 'По внутреннему коду 1с';
$_['text_byupc'] = 'По UPC коду';
$_['text_disable_out_of_stock'] = 'Отсутствующие';
$_['text_disable_out_of_stock_null_price'] = 'Отсутствующие и с нулевой ценой';
$_['text_disable_out_of_stock_without_images'] = 'Отсутствующие и без основного изображения';
$_['text_disable_null_price'] = 'С нулевой ценой';
$_['text_disable_without_images'] = 'Без основного изображения';
$_['text_disable_null_quantity'] = 'С нулевым остатком';
$_['text_order_export_exchange1c'] = 'Выгрузить заказ в 1С:';
$_['text_order_export_exchange1c_status_yes'] = 'Заказ будет выгружен в 1С';
$_['text_order_export_exchange1c_status_not'] = 'Заказ не будет выгружаться в 1С';
$_['text_export_status'] = 'По статусам';
$_['text_export_mark'] = 'По метке в заказе';
$_['text_cleaned'] = 'Очищено';
$_['text_err_cleaned'] = 'Метки уже очищены';
$_['text_success'] = 'Настройки модуля обновлены!';
$_['text_module'] = 'Модули';
$_['button_upload'] = 'Загрузить';
$_['text_price_default'] = 'Цена на сайте';
$_['text_default'] = 'Как есть';
$_['text_product_min'] = 'Продукту минимальную цену, опции плюсом к ней';
$_['text_product_max'] = 'Продукту максимальную цену, опции минусом к ней';
$_['text_transaction_always'] = 'Всегда';
$_['text_transaction_change'] = 'Если сумма или дата оплаты изменены';
$_['text_tools'] = '
    <p>Если вы по какой-то причине не можете загрузить данные напрямую через ссылку, то вы все еще можете сделать это вручную.</p>
    <p>Вам понадобится архив, который формирует 1c, либо можете загрузить по очереди файлы import.xml и offers.xml. Порядок очень важен, поскольку товары создаются при подгрузке файла import.xml, а на offers.xml уже обновляются остатки и цены</p>
';
$_['text_setting_price_type'] = 'Настройка основной цены и скидок товара';
$_['text_setting_special_price_type'] = 'Настройка акционных цен товара';

$_['text_neoseo_filter'] = 'NeoSeo Фильтр';
$_['text_ocfilter'] = 'OcFilter';
$_['text_filter'] = 'Стандартный фильтр';

//Buttons
$_['button_insert'] = 'Добавить';
$_['button_import'] = 'Импорт';
$_['button_export'] = 'Скачать заказы';
$_['button_export_product'] = 'Скачать товары';
$_['button_save'] = 'Сохранить';
$_['button_save_and_close'] = 'Сохранить и Закрыть';
$_['button_close'] = 'Закрыть';
$_['button_recheck'] = 'Проверить еще раз';
$_['button_clear_log'] = 'Очистить логи';
$_['button_delete_orders'] = 'Удалить заказы';
$_['button_delete_categories'] = 'Удалить категории';
$_['button_delete_manufacturers'] = 'Удалить производителей';
$_['button_delete_products'] = 'Удалить товары';
$_['button_delete_1c_products'] = 'Удалить только 1С товары';
$_['button_delete_products_warehouses'] = 'Удалить остатки по складам';
$_['button_delete_attributes'] = 'Удалить атрибуты';
$_['button_delete_options'] = 'Удалить опции';
$_['button_delete_links'] = 'Удалить связи';
$_['button_delete_export_list_orders'] = 'Очистить метки о выгрузке заказов';
$_['button_download_log'] = 'Скачать файл логов';

// Entry
$_['entry_seo_url_field'] = 'Обновлять ЧПУ товара';
$_['entry_seo_url_field_desc'] = 'Укажите название свойства из файла обмена';
$_['entry_update_related_products'] = 'Обновлять сопутствующие товары';
$_['entry_update_related_products_desc'] = 'Значение «Сопутствующие товары» должно быть в свойствах товара. Задается через «;», пример «А001; 12548; СМ001» ';
$_['entry_update_related_products_mode'] = 'По какому параметру выбирать товар для сопутствующих товаров';
$_['entry_use_tree_delete'] = 'Древовидное удаление изображений';
$_['entry_use_tree_delete_desc'] = 'Включите только если на вашем хостинге есть проблема с сохранением изображений из 1С и если есть полная выгрузка картинок';
$_['entry_order_manufacturer'] = 'Выгружать производителя в заказы:';
$_['entry_status'] = 'Статус:';
$_['entry_debug'] = 'Отладка:';
$_['entry_sql_before'] = 'SQL до обработки остатков:';
$_['entry_sql_before_desc'] = 'Если у вас есть какая-то специфическая логика обновления базы перед импортом данных из 1с - вы можете реализовать ее с помощью серии SQL запросов, разделенных точкой с запятой - ";"';
$_['entry_sql_after'] = 'SQL после обработки остатков:';
$_['entry_sql_after_desc'] = 'Если у вас есть какая-то специфическая логика обновления базы после импорта данных из 1с - вы можете реализовать ее с помощью серии SQL запросов, разделенных точкой с запятой - ";"';
$_['entry_username'] = 'Логин:';
$_['entry_password'] = 'Пароль:';
$_['entry_price_name'] = 'Название цены:';
$_['entry_price_name_desc'] = '1С выгружает несколько цен по товару, вы можете указать какую именно использовать. Оставьте поле пустым чтобы взять первую по списку.';
$_['entry_update_attribute'] = 'Обновлять аттрибуты товаров:';
$_['entry_update_attribute_desc'] = 'Выключите, если вам вообще не нужны атрибуты товара из 1с';
$_['entry_update_attribute_group'] = 'Обновлять группы аттрибутов';
$_['entry_update_attribute_group_desc'] = 'Выключите, если хотите чтобы все аттрибуты попадали в Общие';
$_['entry_attribute_group_prefix'] = 'Символ для разделение группы и атрибута';
$_['entry_attribute_group_prefix_desc'] = 'Символ, из 1С который разделяет группу и аттрибут, для примера Общие.ширина, где разделителем есть точка';
$_['entry_update_price'] = 'Обновлять цены:';
$_['entry_update_price_desc'] = 'Выключите, если вам не нужны цены из 1с';
$_['entry_update_currency_plus'] = 'Пересчитать цены всех товаров:';
$_['entry_update_currency_plus_desc'] = 'Если необходимо использовать модуль Валюта Плюс, включите данную опцию и после обмена будет вызвана функция перерасчета цен во всех товарах';
$_['entry_new_price_column'] = 'Укажете новое поле для основной цены в таблице';
$_['entry_new_price_column_desc'] = 'Например baseprice - имя поля в таблице товаров, основная цена будет добавлена в данное поле, основная цена обновляться не будет.';
$_['entry_update_quantity'] = 'Обновлять остатки:';
$_['entry_update_quantity_desc'] = 'Выключите, если вам не нужны остатки из 1с';
$_['entry_update_images'] = 'Обновлять изображения:';
$_['entry_update_images_desc'] = 'Выключите, если вам не нужны изображения товара из 1с';
$_['entry_update_categories'] = 'Обновлять категории товаров:';
$_['entry_update_categories_desc'] = 'Выключите, если вам не нужна привязка товара к категориям из 1с. В этом случае, новые товары будут созданы без привязки к категориям вообще';
$_['entry_create_product'] = 'Добавлять новые товары:';
$_['entry_create_product_desc'] = 'Выключите, если вам нужна синхронизация остатков и\или цен только по имеющимся в магазине товарам';
$_['entry_product_status'] = 'Начальный статус новых товаров';
$_['entry_product_status_desc'] = 'Если нужна дополнительная обработка товаров, пришедших из 1с, то выключите';
$_['entry_disable_missing'] = 'Отключать товары';
$_['entry_disable_missing_desc'] = 'Отключать товары, которые соответствуют выбранным параметрам. И наоборот, включать те товары, которые не соответствуют';
$_['entry_ip_list'] = 'Разрешенные IP адреса';
$_['entry_ip_list_desc'] = 'Список IP адресов, с которых разрешено обращаться к вашей синхронизации. Каждый адрес с новой строки. Пустой список - без ограничений.';
$_['entry_fill_parent_cats'] = 'Заполнять родительские категории:';
$_['entry_fill_parent_cats_desc'] = 'Если включено, то товару будут назначены все категории от текущей, до корневой. Иначе будет установлена только категория самого нижнего уровня';
$_['entry_order_statuses'] = 'Выгружать заказы со статусом:';
$_['entry_final_order_status'] = 'Статус выгруженых заказов:';
$_['entry_order_status_notify'] = 'Уведомлять пользователей о смене статуса:';
$_['entry_flush_product'] = 'Сбрасывать товары:';
$_['entry_flush_category'] = 'Сбрасывать категории:';
$_['entry_flush_manufacturer'] = 'Сбрасывать производителей:';
$_['entry_flush_quantity'] = 'Сбрасывать количество товаров:';
$_['entry_flush_attribute'] = 'Сбрасывать атрибуты:';
$_['entry_order_date'] = 'Последний обмен:';
$_['entry_link'] = 'Ссылка для обмена:';
$_['entry_lookup_product'] = 'Синхронизация товаров';
$_['entry_lookup_product_desc'] = 'Рекомендуется синхронизировать только по артикулу';
$_['entry_ignore_table_quantities'] = 'Игнорировать количество в таблице и брать количество из цен предложений';
$_['entry_create_category'] = 'Добавлять новые категории';
$_['entry_create_category_desc'] = 'Выключите, если вам нужны только те категории, что уже занесены в магазин';
$_['entry_category_status'] = 'Начальный статус новых категорий';
$_['entry_category_status_desc'] = 'Выключите, если нужна преварительная обработка новых категорий';
$_['entry_category_top_status'] = 'Добавлять новые категории в меню';
$_['entry_category_top_status_desc'] = 'Включите, если хотите чтобы все новые категории автоматически отображались в меню';
$_['entry_category_update_name'] = 'Обновлять название категорий';
$_['entry_category_update_name_desc'] = 'Выключите, если нет нужды в синхронизации названий категорий с 1с';
$_['entry_create_attribute'] = 'Добавлять новые аттрибуты';
$_['entry_create_attribute_desc'] = 'Выключите, если вам нужны только те атрибуты, что уже занесены в магазин';
$_['entry_create_manufacturer'] = 'Добавлять новых производителей';
$_['entry_create_manufacturer_desc'] = 'Выключите, если вам нужны только те производители, что уже занесены в магазин';
$_['entry_customer_phone'] = 'Добавлять телефон к имени клиента';
$_['entry_customer_phone_desc'] = 'Если не добавить, то в 1с будет создан 1 александр на все заказы по александрам, которые не указали фамилию';
$_['entry_order_currency'] = 'Валюта заказа:';
$_['entry_order_currency_desc'] = 'Укажите обозначение вашей валюты согласно настройкам в 1с';
$_['entry_update_name'] = 'Обновлять наименование:';
$_['entry_update_name_desc'] = 'Выключите, если наименование вам нужно только при создании товара, а дальше вы будете редактировать его в самом магазине';
$_['entry_update_description'] = 'Обновлять описание:';
$_['entry_update_description_desc'] = 'Выключите, если описание вам нужно только при создании товара, а дальше вы будете редактировать его в самом магазине';
$_['entry_category_links'] = 'Связи между категориями';
$_['entry_category_links_desc'] = 'Если вам нужно чтобы категория 1с соответствовала нескольким категориям в магазине или же вам нужно чтобы категория 1с с одним именем, соответствовала категории магазина с другим - вы можете задать правила в этом поле<br>Формат:<br>кровати : Мебель \ Мебель детская \ кровати<br>ножницы : Канцтовары для школы \ Ножницы ; Канцтовары для офиса \ Ножницы';
$_['entry_create_option'] = 'Добавлять новые опции';
$_['entry_create_option_desc'] = 'Выключите, если вам нужны только те свойства, что уже занесены в магазин';
$_['entry_update_option'] = 'Обновлять опции у товаров';
$_['entry_update_option_desc'] = 'Выключите, если вам вообще не нужны свойства товара из 1с';
$_['entry_order_utf8'] = 'Выгрузка в UTF-8:';
$_['entry_order_utf8_desc'] = 'Старые системы понимают только win1251, новым нужно ставить utf8';
$_['entry_order_status_notify'] = 'Уведомить покупателя:';
$_['entry_order_status_notify_desc'] = 'Уведомить покупателя об изменении статуса заказа';
$_['entry_model_in_id'] = 'Выводить в ИД товара значение поля Модель:';
$_['entry_model_in_id_desc'] = 'Включите, если необходимо заменить значение ИД 1с товара на значение из поля Модель';
$_['entry_transaction_status'] = 'Добавлять транзакции к заказу:';
$_['entry_final_list_order_statuses'] = 'Соответвие статусов в магазине после выгрузки в 1С';
$_['entry_final_list_order_statuses_desc'] = 'Укажите соответствия статусов заказа после выгрузки заказа в 1с (Отменяет пункт "Статус выгруженых заказов"). Если поле пустое - отключено. Слева - до выгрузки, справа - после <br> <b>Пример:</b> <br>Ожидаем оплату = Резервирование <br> Оплачено = В обработке';
$_['entry_extra_customer'] = 'Выгружать расширенные данные по покупателю';
$_['entry_extra_customer_desc'] = 'Укажите <b>Тег;Таблица БД;Поле</b>, если нужно выгружать дополнительные теги в тег <b>Контрагент</b>, где <b>Тег</b> - название тега, который будет помещен в тег Адрес, <b>Таблица БД</b> - таблица из которой будет взято поле <b>Поле</b> - поле таблицы, из которого будет взято значение и помещено в тег. Обязательное наличие в таблице поля customer_id. Разбор указанных тегов должен быть настроен в 1с. Каждая запись с новой строки. <br> <b>Пример:</b> <br> Пол;oc_customer_simple_fields;gender';
$_['entry_extra_property'] = "Произвольные значения в теге 'ЗначенияРеквизитов'";
$_['entry_extra_property_desc'] = 'Если в заказе Вам нужно выгружать произвольные значения реквизитов, укажите <b>Название;Таблица БД;Поле</b>, если нужно выгружать расширенный адрес, где <b>Название</b> - название ЗначениеРеквизита, который будет помещен в тег Адрес, <b>Таблица БД</b> - таблица из которой будет взято поле, <b>Поле</b> - поле таблицы, из которого будет взято значение и помещено в тег. Обязательное наличие в таблице поля order_id. Разбор указанных тегов должен быть настроен в 1с. Каждая запись с новой строки. <br> <b>Пример:</b> <br> Индекс;oc_order;shipping_postcode<br> Улица;oc_order_simple_fields;shipping_address_street';
$_['entry_extra_address'] = 'Выгружать расширенный адрес';
$_['entry_extra_address_desc'] = 'По умолчанию адрес выгружается одной строкой. Укажите <b>Тег;Таблица БД;Поле</b>, если нужно выгружать расширенный адрес, где <b>Тег</b> - название тега, который будет помещен в тег Адрес, <b>Таблица БД</b> - таблица из которой будет взято поле, <b>Поле</b> - поле таблицы, из которого будет взято значение и помещено в тег. Обязательное наличие в таблице поля order_id. Разбор указанных тегов должен быть настроен в 1с. Каждая запись с новой строки. <br> <b>Пример:</b> <br> Индекс;oc_order;shipping_postcode<br> Улица;oc_order_simple_fields;shipping_address_street';
$_['entry_order_status_marge_list'] = 'Соответвие статусов сайта и 1с';
$_['entry_order_status_marge_list_desc'] = 'Укажите соответствия статусов заказа к статусам 1с. Слева - сайт, справа - 1с <br> <b>Пример:</b> <br> Сделка завершена = Сделка выполнена <br> В обработке = В работе';
$_['entry_order_status_override'] = 'Игнорировать:';
$_['entry_order_status_override_desc'] = 'Включить игнорирование, если статус заказа был автоматически изменён системой Anti-Fraud';
$_['entry_product_subtract'] = 'Вычитать со склада:';
$_['entry_product_subtract_desc'] = 'Это значение будет использовано при создании новых продуктов в процессе обмена';
$_['entry_product_fullname'] = 'Использовать полное наименование:';
$_['entry_product_fullname_desc'] = 'Если включено, то для названия товара будет использоваться его атрибут ПолноеНаименование в случае его наличия';
$_['entry_product_fulldescription'] = 'Описание товара брать из поля полное наименование:';
$_['entry_product_fulldescription_desc'] = 'Если включено, то для описания товара будет использоваться его атрибут ПолноеНаименование в случае его наличия';
$_['entry_product_dimension'] = 'Обновлять Размеры (Д x Ш x В):';
$_['entry_product_dimension_desc'] = 'Если включено, то Размеры (Д x Ш x В) из свойств товара будут записаны в соответсвтующие поля в карточке товара, иначе будут записаны в атрибуты товара';
$_['entry_product_export_model_to_sku'] = 'Выгружать в 1с модель как артикль';
$_['entry_product_export_model_to_sku_desc'] = 'Если включено, при выгрузке товаров в 1с, артикль будет браться с поля модель';

$_['entry_use_warehouse'] = 'Использовать склады:';
$_['entry_use_warehouse_desc'] = 'Если включено, информация о складах и остатках товаров по ним будет подтягиваться из файла offers.xml';
$_['entry_main_warehouse'] = 'Основной склад:';
$_['entry_main_warehouse_desc'] = 'Если указать название склада, то в качестве остатка по товару будет использоваться не общий остаток, а остаток по указанному складу';
$_['entry_use_related_options'] = 'Использовать связные опции:';
$_['entry_use_related_options_desc'] = 'Если в 1с используется 2 и более опции на товар, то это единственный способ правильно принять данные из offers.xml. Модуль связных опций должен быть установлен';
$_['entry_ignore_attributes'] = "Исключать атрибуты";
$_['entry_ignore_attributes_desc'] = "Список атрибутов для исключения. Каждый атрибут на отдельной строке";
$_['entry_unit_field'] = 'Поле Товар/ЕдиницаИзмерения';
$_['entry_unit_field_desc'] = 'Куда писать поле Товар/ЕдиницаИзмерения, если оно будет найдено в файле обмена. Варианты - mpn, upc, ean и т.д. Если не хотите записывать, оставьте поле пустым';
$_['entry_order_customer'] = 'Покупатель';
$_['entry_order_customer_desc'] = 'Если заполнено, то все заказы будут выгрузаться под этим покупателем';
$_['entry_code_field'] = 'Поле Товар/Код';
$_['entry_code_field_desc'] = 'Куда писать поле Товар/Код, если оно будет найдено в файле обмена. Варианты - mpn, upc, ean и т.д. Если не хотите записывать, оставьте поле пустым';
$_['entry_barcode_field'] = 'Поле Товар/ШтрихКод';
$_['entry_barcode_field_desc'] = 'Куда писать Товар/ШтрихКод, если оно будет найдено в файле обмена. Варианты - mpn, upc, ean и т.д. Если не хотите записывать, оставьте поле пустым';
$_['entry_update_sku'] = 'Обновлять артикул';
$_['entry_update_sku_desc'] = 'Полезно для синхронных изменений с 1с';
$_['entry_option_price'] = 'Цена опции';
$_['entry_option_price_desc'] = 'Если оставить цену опций как есть, то надо ставить специальный модуль для опций, который правильно будет обрабатывать их цену';
$_['entry_delete_zero_option'] = 'Удаление нулевых опций';
$_['entry_delete_zero_option_desc'] = 'Если после обмена часть опций получат нулевой остаток, то они будут удалены, чтобы не мешать на сайте';
$_['entry_product_stock_status'] = 'Начальный статус наличия новых товаров:';
$_['entry_product_stock_status_desc'] = 'Укажите статус наличия, который нужно выставлять созданным продуктам';
$_['entry_special_group_id'] = 'Група покупателей для акционной цены';
$_['entry_price_special'] = 'Акционная цена';
$_['entry_price_special_desc'] = 'Если поле заполнено, то по всем товарам в обмене очищается список акций. Если товару указана акционная цена, то товару будет установлена бессрочная акция на эту цену, а цены опций будут выровнены по цене акции';
$_['entry_order_export_type'] = 'Как выбирать заказы для выгрузки';
$_['entry_limit_orders'] = 'Количество выгружаемых заказов';
$_['entry_limit_orders_desc'] = 'Лимит заказов на одну синхронизацию. 0 = без ограничения (все заказы).<br><b>Внимание!</b> Если "Статус выгруженых заказов" будет в списке "Выгружать заказы со статусом" - Заказы не лимитируются, выберите тип выгрузки - по меткам';
$_['entry_sync_missing_status'] = 'Спец. Тег для статуса если товара нет на складе';
$_['entry_sync_missing_status_desc'] = 'Укажите имя тега отвечающего за значение статуса товара которого нет в наличии.<br> Оставьте поле пустым если Вам не нужно учитывать статусы отсуствия товара.';
$_['entry_default_missing_status'] = 'Статус по умолчанию для товаров которых нет в наличии';
$_['entry_default_missing_status_desc'] = 'Статус устанавливается если присутсвует спец. тег для статусов';
$_['entry_product_languages'] = 'Обновлять описание и название товаров на языке:';
$_['entry_product_languages_desc'] = 'Если оставить пустым - будут обновлятся все языки';
$_['entry_category_languages'] = 'Обновлять название категорий на языке:';
$_['entry_category_languages_desc'] = 'Если оставить пустым - будут обновлятся все языки';
$_['entry_forbidden_options'] = 'Не выгружать опции';
$_['entry_forbidden_options_desc'] = 'Введите названия опций которые нужно исключить из выгрузки, каждая опция с новой строки';
$_['entry_category_forced'] = 'Принудительно выгружать в определенную категорию';
$_['entry_category_forced_id'] = 'Категория для принудительной выгрузки';
$_['entry_order_shipping_links'] = 'Выгрузка методов доставки';
$_['entry_order_shipping_links_desc'] = 'Укажите соответствия методов доставки к номенклатуре 1с. Если частное соответствие не будет найдено, то будет использоваться общее по shipping в секции выгрузки итогов заказа<br><b>Пример:</b><br>dostavkaplus.sh1 = 0000-0000-1111<br>dostavkaplus.sh2 = 0000-0000-2222';
$_['entry_order_payment_links'] = 'Выгрузка методов оплаты';
$_['entry_order_payment_links_desc'] = 'Укажите соответствия методов оплаты к номенклатуре 1с. Если частное соответствие не будет найдено, то будет использоваться общее по payment в секции выгрузки итогов заказа<br><b>Пример:</b><br>paymentplus.sh1 = 0000-0000-1111<br>paymentplus.sh2 = 0000-0000-2222';

$_['entry_order_total_links'] = 'Выгрузка итогов заказа';
$_['entry_order_total_links_desc'] = 'Укажите соответствия итогов заказа ( сертификаты, купоны, доставка ) к номенклатуре 1с. Для указания общего соответствия по доставке используется код shipping<br><b>Пример:</b><br>shipping = 0000-0000-3333<br>coupon = 0000-0000-4444';
$_['entry_config_price_type'] = 'Тип выгружаемой цены:';
$_['entry_customer_group'] = 'Группа покупателей:';
$_['entry_quantity'] = 'Количество:';
$_['entry_priority'] = 'Приоритет:';

$_['entry_currency_convertor'] = 'Конвертировать валюты:';
$_['entry_currency_convertor_desc'] = 'Если валюта предложения будет соответствовать одной из списка, то она будет автоматиески сконвертирована по курсу валют в магазине.<br><b>Пример</b> списка соответствий:<br>Руб:RUB,Дол:USD';
$_['entry_enable_zip'] = 'Требовать архив:';
$_['entry_enable_zip_desc'] = 'Требовать со стороны 1с архив вместо отдельных файлов. Ускоряет обмен';
$_['entry_delete_offers'] = 'Удалять файл предложений:';
$_['entry_delete_offers_desc'] = 'Эта опция добавлена в качестве защиты от тупости сервиса moysklad.ru, который не дожидается окончания обработка файла предложений и шлет запрос на его обработку повторно 4 раза подряд. Поэтому мы просто удаляем файл предложений сразу после его прочтения и на повторные запросы разводим руками, дескать мы не при делах. Костыль, но как-то же надо жить';

$_['entry_extra_comment'] = 'Расширенное примечание:';
$_['entry_extra_comment_desc'] = 'В примечание к заказу добавляются все детали по заказу';

$_['entry_option_type'] = 'Тип опций';
$_['entry_option_type_desc'] = '';
$_['text_option_type_select'] = 'Выпадающий список';
$_['text_option_type_radio'] = 'Переключатель';
$_['entry_option_source'] = 'Забирать опции из поля Характеристики товара';
$_['entry_option_source_desc'] = 'Если отключено значение опций будет браться сначала с поля "ЗначениеСвойств", затем из Характеристик, если включено - наоборот';

$_['entry_option_required'] = 'Опция обязательна';
$_['entry_option_required_desc'] = 'Включите, чтобы покупатель не мог оформить заказ без выбора опции';

$_['entry_option_by_box'] = 'Создавать опции по упаковкам';
$_['entry_option_by_box_desc'] = 'Если в атрибутах приходит Упаковка_1,Упаковка_2,Упаковка_3 то эти атрибуты трансформируются в опции, а количество из атрибута записывается в Балы опции. При выгрузке в 1с балы будут использоваться как коэффициент, на которой будет умножаться реальное количество';

$_['entry_totals_positive'] = 'Все итоги заказа должны быть положительными';
$_['entry_totals_positive_desc'] = 'Нужно для того случая когда выгрузка идет в 1с и 1с не понимает отрицательную сумму. Ей нужна положительная';

$_['entry_attribute_routing'] = 'Перенаправление свойств:';
$_['entry_attribute_routing_desc'] = 'Если надо какое-то свойство записать именно в товар, а не в список свойств, то укажите название свойства и поле таблицы товара через знак равенства.<br><b>Пример</b> списка соответствий:<br>Вес=weight<br>Артикул=model';

$_['entry_missing_quantity_is_zero'] = 'Отсутствие количества считать нулем:';
$_['entry_missing_quantity_is_zero_desc'] = 'Часть конфигураций 1с упорото не хотят выгружать количество если товара нет в наличии, в итоге в магазине появляются фантомные остатки. Если это ваш случай - включите опцию и отсутствие остатка будет означать его нулевое значение';

$_['entry_upload'] = 'Выберите файл:';

$_['entry_unit_links'] = 'Соответствия базовых единиц опциям';
$_['entry_unit_links_desc'] = 'Укажите текст, который должен быть передан в качестве базовой единицы в 1с, согласно имени опции<br><b>Пример</b><br>блок=1<br>упаковка=2';

$_['entry_update_filter'] = 'Обновлять фильтр исходя из значений атрибутов';
$_['entry_update_filter_desc'] = 'Значения фильтра будут актуализироваться исходя из значений атрибутов, назначенных товару. Попутно опциям будут добавляться те категории, в товарах которых они встречаются';
$_['entry_update_option_product_filter'] = 'Обновлять фильтр исходя из значений опций товара';
$_['entry_update_option_product_filter_desc'] = 'Значения фильтра будут актуализироваться исходя из значений опций, назначенных товару.';
$_['entry_option_product_filter'] = 'Исключить опции товара из фильтра';
$_['entry_option_product_filter_desc'] = 'Укажите перечень опций товара, которые не нужно добавлять в фильтр. Каждая опция на отдельной строке.';
$_['entry_get_from_naclad'] = 'Получать цену и количество товара в заказе из накладной';
$_['entry_get_from_naclad_desc'] = 'Данная опция доступна если у Вас используется модуль Накладная';

$_['entry_get_orders_from_1c'] = 'Получать и обновлять статусы заказа из 1с';
$_['entry_get_orders_from_1c_desc'] = 'Актуально в том случе, если 1с передает статусы заказов на сайт.';

$_['entry_clear_system_cache'] = 'Очищать системный кэш после обмена';
$_['entry_clear_system_cache_desc'] = 'Очищать кэш после обработки offers.xml';
$_['entry_clear_image_cache'] = 'Очищать кэш изображений после обмена';
$_['entry_clear_image_cache_desc'] = 'Очищать кэш после обработки offers.xml';

$_['entry_clear_neoseo_filter_cache'] = 'Очищать кэш модуля NeoSeo Фильтр';
$_['entry_clear_neoseo_filter_cache_desc'] = 'Кэш модуля NeoSeo Фильтр будет очищен, если модуль установлен.';
$_['entry_update_date'] = 'Отключить обновление даты товары.';
$_['entry_update_date_desc'] = 'При обмене с 1С, не менять дату изменения товара, если остаток товара не изменился';

$_['entry_use_fraction_quantity'] = 'Использовать дробный остаток';
$_['entry_use_fraction_quantity_desc'] = 'При использовании данной опции дробный остаток должен поддерживаться у Вас на сайте';

$_['entry_search_option_for_sku'] = 'Выполнять поиск опций по артикулу';
$_['entry_search_option_for_sku_desc'] = 'Данную опцию следует применять только в том случае, если опции с сайта являются отдельными товарами в 1с.';
$_['entry_option_field_sku'] = 'Поле артикула опции';
$_['entry_option_field_sku_desc'] = 'Необходимо указать поле в таблице product_option_value, в котором хранится значение артикула. Используется только при включенной опции "Выполнять поиск опций по артикулу". <br>Например, sku, model, optsku.';
$_['entry_option_sku_add_product_sku'] = 'Артикул опции содержит артикул товара';
$_['entry_option_sku_add_product_sku_desc'] = 'Используется только в том случае, если из 1с приходит полный артикул, а на сайте в артикуле опции хранится часть артикула, а также только при включенной опции "Выполнять поиск опций по артикулу". <br>Например, с 1с приходит артикул 111-222, где 111 - это артикул товара на сайте, а -222 это артикул опции.';
$_['entry_option_sku_symbol_add_product_sku'] = 'Символ, который соединяет артикул товара и артикул опции';
$_['entry_option_sku_symbol_add_product_sku_desc'] = 'Используется только при включенной опции "Артикул опции содержит артикул товара".<br> Например, -, если поле не заполнено, тогда определить где артикул товара, а где опции невозможно..';

$_['entry_set_auto_tag_order'] = 'Установить метку заказу автоматически при его редактировании';
$_['entry_set_auto_tag_order_desc'] = 'Используется при включенной опции "Как выбирать заказы для выгрузки" - по метке в заказе.';
$_['entry_exclude_auto_tag_order'] = 'Исключать автоматическую установку метки для заказов со статусом';
$_['entry_exclude_auto_tag_order_desc'] = 'Используется при включенной опции "Установить метку заказу автоматически при его редактировании".';

$_['entry_use_filter'] = 'Использовать фильтр';

$_['entry_delete_special_price'] = 'Удалять акционные цены перед их обновлением';

// Error
$_['error_permission'] = 'У Вас нет прав для управления этим модулем!';
$_['error_post_size'] = "Увеличьте значения параметров post_max_size и upload_max_filesize, чтобы они превышали размер архива";
$_['error_empty_archive'] = "Архив пустой или имеет неправильную структуру. Правильная структура предполагает наличие файлов сразу в корне архива";
$_['error_download_logs'] = 'Файл логов пустой или отсутствует!';

$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';
$_['mail_support'] = '';
$_['module_licence'] = '';
$_['text_module_version'] = '';
$_['text_module_version']='158';
$_['error_license_missing']='<h3 style = "color: red"> Missing file with key! </h3>

<p> To obtain a file with a key, contact NeoSeo by email <a href="mailto:license@neoseo.com.ua"> license@neoseo.com.ua </a>, with the following: </p>

<ul>
	<li> the name of the site where you purchased the module, for example, https://neoseo.com.ua </li>
	<li> the name of the module that you purchased, for example: NeoSeo Sharing with 1C: Enterprise </li>
	<li> your username (nickname) on this site, for example, NeoSeo</li>
	<li> order number on this site, e.g. 355446</li>
	<li> the main domain of the site for which the key file will be activated, for example, https://neoseo.ua</li>
</ul>

<p>Put the resulting key file at the root of the site, that is, next to the robots.txt file and click the "Check again" button.</p>';
$_['error_ioncube_missing']='<h3 style="color: red">No IonCube Loader! </h3>

<p>To use our module, you need to install the IonCube Loader.</p>

<p>For installation please contact your hosting TS</p>

<p>If you can not install IonCube Loader yourself, you can also ask for help from our specialists at <a href="mailto:support@neoseo.com.ua"> support@neoseo.com.ua </a> </p>';
$_['module_licence']='<h2>NeoSeo Software License Terms</h2>
<p>Thank you for purchasing our web studio software.</p>
<p>Below are the legal terms that apply to anyone who visits our site and uses our software products or services. These Terms and Conditions are intended to protect your interests and interests of LLC NEOSEO and its affiliated entities and individuals (hereinafter referred to as "we", "NeoSeo") acting in the agreements on its behalf.</p>
<p><strong>1. Introduction</strong></p>
<p>These Terms of Use of NeoSeo (the "Terms of Use"), along with additional terms that apply to a number of specific services or software products developed and presented on the NeoSeo website (s), contain terms and conditions that apply to each and every one of them. the visitor or user ("User", "You" or "Buyer") of the NeoSeo website, applications, add-ons and components offered by us along with the provision of services and the website, unless otherwise noted (all services and software, software Modules offered through the NeoSeo website or auxiliary servers Isa, web services, etc. Applications on behalf NeoSeo collectively referred to as - "NeoSeo Service" or "Services").</p>
<p>NeoSeo Terms are a binding contract between NeoSeo and you - so please carefully read them.</p>
<p>You may visit and/or use the NeoSeo Services only if you fully agree to the NeoSeo Terms: By using and/or signing up to any of the NeoSeo Services, you express and agree to these Terms of Use and other NeoSeo terms, for example, provide programming services in the context of typical and non-typical tasks that are outlined here: <a href = "https://neoseo.com.ua/vse-chto-nujno-znat-klienty "target ="_blank" class ="external"> https://neoseo.com.ua/vse-chto-nujno-znat-klienty </a>, (hereinafter the NeoSeo Terms).</p>
<p>If you are unable to read or agree to the NeoSeo Terms, you must immediately leave the NeoSeo Website and not use the NeoSeo Services.</p>
<p>By using our Software products, Services, and Services, you acknowledge that you have read our Privacy Policy at <a href = "https://neoseo.com.ua/policy-konfidencialnosti "target ="_blank " class ="external"> https://neoseo.com.ua/politika-konfidencialnosti </a> (" Privacy Policy ")</p>
<p>This document is a license agreement between you and NeoSeo.</p>
<p>By agreeing to this agreement or using the software, you agree to all these terms.</p>
<p>This agreement applies to the NeoSeo software, any fonts, icons, images or sound files provided as part of the software, as well as to all NeoSeo software updates, add-ons or services, if not applicable to them. miscellaneous. This also applies to NeoSeo apps and add-ons for the SEO-Store, which extend its functionality.</p>
<p>Prior to your use of some of the application features, additional NeoSeo and third party terms may apply. For the correct operation of some applications, additional agreements are required with separate terms and conditions of privacy, for example, with services that provide SMS-notification services.</p>
<p>Software is not sold, but licensed.</p>
<p>NeoSeo retains all rights (for example, the rights provided by intellectual property laws) that are not explicitly granted under this agreement. For example, this license does not entitle you to:</p>
<li> <span> </span> <span> </span> separately use or virtualize software components; </li>
<li> publish or duplicate (with the exception of a permitted backup) software, provide software for rental, lease or temporary use; </li>
<li> transfer the software (except as provided in this agreement); </li>
<li> Try to circumvent the technical limitations of the software; </li>
<li> study technology, decompile or disassemble the software, and make appropriate attempts, other than those to the extent and in cases where (a) it provides for the right; (b) authorized by the terms of the license to use the components of the open source code that may be part of this software; (c) necessary to make changes to any libraries licensed under the small GNU General Public License, which are part of the software and related; </li>
<p> You have the right to use this software only if you have the appropriate license and the software was properly activated using the genuine product key or in another permissible manner.
</p>
<p> The cost of the SEO-Shop license does not include installation services, settings, and more of its stylization, as well as other paid/free add-ons. These services are optional, the cost depends on the number of hours required for the implementation of the hours, here: <a href = "https://neoseo. com.ua/vse-chto-nujno-znat-klienty "target =" _ blank "class =" external "> https://neoseo.com.ua/vse-chto-nujno-znat-klienty </a>
</p>
<p> The complete version of the document can be found here:
</p>
<p> <a href="https://neoseo.com.ua/usloviya-licenzionnogo-soglasheniya" target="_blank" class="external"> https://neoseo.com.ua/usloviya-licenzionnogo-soglasheniya </a>
</p>';
$_['mail_support']='<h2>Terms of free and paid information and technical support in <a class="external" href="https://neoseo.com.ua/" target="_blank"> NeoSeo</a>.</h2>

<p>Since we are confident that any quality work must be paid, all consultations requiring preliminary preparation of the answer, pay, including and case studies: &quot; look, and why your module is not working here? &quot;</p>

<p>If the answer to your question is already ready, you will receive it for free. But if you need to spend time answering the question, studying files, finding a bug and analyzing it, then we&#39;ll ask you to make a payment before you can answer.</p>

<p>We are <strong>helping to install</strong> and <strong> fix bugs when installing </strong>our modules in our order.</p>

<p>For any questions, please contact support@neoseo.com.ua.</p>

<p>See the full version of the license agreement here:<strong> </strong><a class="external" href="https://neoseo.com.ua/usloviya-licenzionnogo-soglasheniya" target="_blank"> https://neoseo.com .ua/usloviya-licenzionnogo-soglasheniya</a></p>

<p><strong>Special offer: write review - get an add-on as a gift :)</strong></p>

<p>Dear Customers of web studio NeoSeo,</p>

<p>Tell us, what could be better for the development of the company than public reviews? This is a great way to hear your Client and make your products and service even better.</p>

<p>Please, leave a review about cooperation with our web studio or about our software solutions (add-ons) on our Facebook, Google, pages, Google, Yandex and OpenCartForum.com. pages.</p>

<p>Write as it is, it is important for us to hear an honest and objective assessment, and as a sign of gratitude for the time spent writing reviews, we have prepared a nice bonus. Detailed conditions are here: <a href="https://neoseo.com.ua/akciya-modul-v-podarok " target="_blank">https://neoseo.com.ua/akciya-modul-v-podarok </a></p>

<p>Once again, thank you very much for being with us!</p>

<p>The NeoSeo Team</p>';
