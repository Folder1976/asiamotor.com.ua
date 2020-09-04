<?php

// Heading
$_['heading_title']             = 'Поиск с морфологией и релевантностью PRO [<a href="http://sv2109.com" target="_blank">sv2109.com</a>]';

// Entry
$_['entry_field']               = 'Поле';
$_['entry_join']                = 'JOIN для новой таблицы';
$_['entry_where']               = 'WHERE для новой таблицы';
$_['entry_fix_keyboard_layout'] = 'Исправлять раскладку клавиатуры';
$_['entry_sort_order_stock']    = 'Учитывать наличие на складе при сортировке';
$_['entry_fields_name']         = 'Поля';
$_['entry_search']              = 'Где искать';
$_['entry_phrase']              = 'Фраза из нескольких слов';
$_['entry_use_morphology']      = 'Использовать морфологию';
$_['entry_use_relevance']       = 'Использовать релевантность';
$_['entry_search_logic']        = 'Логика поиска для фраз из нескольких слов';
$_['entry_min_word_length']     = 'Минимальная длина слова для поиска';
$_['entry_cache_results']       = 'Кешировать результаты поиска';
$_['entry_exclude_characters']  = 'Исключить символы из поиска';
$_['entry_relevance_start']     = 'Вес вхождения в начало';
$_['entry_relevance_phrase']    = 'Вес вхождения целой фразы';
$_['entry_relevance_word']      = 'Вес вхождения слова ';
$_['entry_key']                 = 'Ключ';
$_['entry_exclude_words']       = 'Исключить слова';
$_['entry_replace_words']       = 'Заменить слова';

// Text
$_['text_module']               = 'Модули';
$_['text_success']              = 'Модуль удачно обновлен!';
$_['text_edit']                 = 'Ректирование модуля';
$_['text_always']               = 'Всегда';
$_['text_nothing_found']        = 'Когда ничего не найдено';
$_['text_search_equally']       = 'Точное совпадение';
$_['text_search_contains']      = 'Вхождение';
$_['text_search_start']         = 'Начало';
$_['text_search_dont_search']   = 'Не искать';
$_['text_phrase_cut']           = 'Разбивать на слова';
$_['text_phrase_dont_cut']      = 'Искать по целой фразе';
$_['text_logic_or']             = 'ИЛИ';
$_['text_logic_and']            = 'И';

// Tabs
$_['tab_general']               = 'Основные настройки';
$_['tab_relevance']             = 'Настройки релевантности';
$_['tab_support']               = 'Поддержка';
$_['tab_exclude_words']         = 'Исключить слова';
$_['tab_replace_words']         = 'Заменить слова';
$_['tab_add_fields']            = 'Добавить поля';

// Fields
$_['field_name']                = 'Название';
$_['field_description']         = 'Описание';
$_['field_tags']                = 'Теги';
$_['field_attributes']          = 'Атрибуты';
$_['field_model']               = 'Модель';
$_['field_sku']                 = 'SKU';
$_['field_upc']                 = 'UPC';
$_['field_ean']                 = 'EAN';
$_['field_jan']                 = 'JAN';
$_['field_isbn']                = 'ISBN';
$_['field_mpn']                 = 'MPN';

// Error
$_['error_permission']          = 'Внимание: Вы не имеете права модифицировать модуль Поиск с морфологией и релевантностью!';
$_['error_field']               = 'Новое поле для поиска не может быть пустым';
$_['error_warning']             = 'Внимательно проверьте форму на ошибки!';

// Help
$_['help_tab_general'] = 'Помощь:<br/>
    <ul>
      <li>отключите поиск по полям где он не нужен, это увеличит скорость поиска</li>
      <li>для полей Модель, SKU, UPC, EAN, JAN, ISBN, MPN и Название лучше использовать поиск или по началу слова или точное совпадение, тогда будет работать индекс это увеличит скорость поиска</li>
    </ul>';
$_['help_tab_relevance'] = 'Помощь:<br/>
    <ul>
      <li>чем меньше пунктов релевантности выбрано, тем выше скорость поиска но тем ниже его релевантность</li>
      <li>чтобы не использовать релевантность по какому-то полю, установите значение - 0</li>
      <li>вес вхождения в начало означает что поле начинается на искомую фразу или слово</li>
      <li>вес вхождения фразы означает что поле содержит точное вхождение этой фразы (актуально для фраз из нескольких слов)</li>
      <li>для полей Модель, SKU, UPC, EAN, JAN, ISBN, MPN и Название лучше использовать вес вхождени по началу, тогда будет работать индекс это увеличит скорость поиска</li>
    </ul>';
$_['help_tab_exclude_words'] = 'Одно слово на строку';
$_['help_tab_replace_words'] = 'Одна пара слов на строку, слова в паре разделены пробелом. Например: aple apple';
$_['help_tab_add_fields'] = 'Помощь:<br/>
    <ul>
      <li><b>Поле:</b> поле, по которому Вы хотите осуществлять поиск, например: p.product_id, pd.meta_title, pa.text и т.д.</li>
      <li><b>JOIN для новой таблицы: </b> SQL код для добавления новой таблицы, например: "LEFT JOIN oc_product_attribute pa ON (p.product_id=pa.product_id)" <br />
			  Вот перечень полей, которые уже используются в модуле, их не нужно добавлять:
				<ul>
				  <li>product p</li>
					<li>product_description pd</li>
					<li>product_attribute pa (если включен поиск по атрибутам)</li>
				  <li>category_path cp (если включено искать в подкатегориях)</li>
					<li>product_to_category p2c (если включено искать в категории)</li>
					<li>product_to_store p2s</li>
				</ul>
			</li>
			<li><b>WHERE для новой таблицы: </b> SQL код для условия WHERE для новой таблицы, например: "pa.language_id = pd.language_id"</li>
    </ul>';

$_['help_fix_keyboard_layout'] = 'Исправлять неправильную раскладку клавиатуры, например: yjen,er->ноутбук';
$_['help_sort_order_stock'] = 'Товары, которых нет в наличии будут отображаться последними';

$_['help_support'] = '
<br />
<b>Если у вас возникли проблемы с установкой или использованием этого модуля, то вы можете:</b>
<ul>
  <li>Написать мне на <a href="mailto:sv2109@gmail.com?subject=Search MR module">sv2109@gmail.com</a></li>
  <li>Создать тикет на <a href="http://sv2109.com/ru/tickets">http://sv2109.com/ru/tickets</a></li>
  <li>Написать комментарий на странице модуля</li>
</ul>
<br/>
<b>Вы так же можете ко мне обратиться если:</b>
<ul>
  <li>вам нужна помощь с вашим OpenCart-ом</li>
  <li>вам нужно создать любой другой модуль для OpenCart</li> 
</ul>
<br/>
<div style="font-size: 150%;">Другие полезные модули вы можете найти <a href="http://sv2109.com/ru/modules">тут</a>:</div>
<br/>
<a href="http://sv2109.com/ru/modules"><img src="http://sv2109.com/i/ssb.png" alt=""><img src="http://sv2109.com/i/srb.png" alt=""><img src="http://sv2109.com/i/isb.png" alt=""><img src="http://sv2109.com/i/fcsb.png" alt="">
<br/><img src="http://sv2109.com/i/acb.png" alt=""><img src="http://sv2109.com/i/asb.png" alt=""><img src="http://sv2109.com/i/iocb.png" alt=""><img src="http://sv2109.com/i/tab.png" alt=""></a>
';