<?php

// Heading
$_['heading_title'] = 'Search Relevance PRO [<a href="http://sv2109.com" target="_blank">sv2109.com</a>]';

// Entry
$_['entry_field']               = 'Field';
$_['entry_join']                = 'JOIN for the new table';
$_['entry_where']               = 'WHERE for the new table';
$_['entry_fix_keyboard_layout'] = 'Fix keyboard layout';
$_['entry_sort_order_stock']    = 'Sort order stock';
$_['entry_fields_name']         = 'Fields';
$_['entry_search']              = 'Search';
$_['entry_phrase']              = 'Phrase';
$_['entry_use_morphology']      = 'Use morphology <br/>(stemming)';
$_['entry_use_relevance']       = 'Use relevance';
$_['entry_search_logic']        = 'Search logic for the <br/>multiple words search phrase ';
$_['entry_min_word_length']     = 'Minimum word length for search';
$_['entry_cache_results']       = 'Cache results';
$_['entry_exclude_characters']  = 'Exclude characters';
$_['entry_relevance_start']     = 'Weight for field that <br /> starts with searching word or phrase';
$_['entry_relevance_phrase']    = 'Weight for field that <br /> contains searching phrase';
$_['entry_relevance_word']      = 'Weight for field that <br /> contains searching word';
$_['entry_key']                 = 'Module key';
$_['entry_exclude_words']       = 'Exclude words';
$_['entry_replace_words']       = 'Replace words';

// Text
$_['text_module']               = 'Modules';
$_['text_success']              = 'Success: You have modified module Search Relevance!';
$_['text_edit']                 = 'Edit Search Relevance module';
$_['text_always']               = 'Always';
$_['text_nothing_found']        = 'If nothing found';
$_['text_search_equally']       = 'Exact match';
$_['text_search_contains']      = 'Contains';
$_['text_search_start']         = 'Beginning';
$_['text_search_dont_search']   = "Not use";
$_['text_phrase_cut']           = 'Split into words';
$_['text_phrase_dont_cut']      = 'Search for the whole phrase';
$_['text_logic_or']             = 'OR';
$_['text_logic_and']            = 'AND';

// Tabs
$_['tab_general']               = 'General settings';
$_['tab_relevance']             = 'Relevance settings';
$_['tab_support']               = 'Support';
$_['tab_exclude_words']         = 'Exclude words';
$_['tab_replace_words']         = 'Replace words';
$_['tab_add_fields']            = 'Add fields';

// Fields
$_['field_name']                = 'Name';
$_['field_description']         = 'Description';
$_['field_tags']                = 'Tags';
$_['field_attributes']          = 'Attributes';
$_['field_model']               = 'Model';
$_['field_sku']                 = 'SKU';
$_['field_upc']                 = 'UPC';
$_['field_ean']                 = 'EAN';
$_['field_jan']                 = 'JAN';
$_['field_isbn']                = 'ISBN';
$_['field_mpn']                 = 'MPN';

// Error
$_['error_permission']          = 'Warning: You do not have permission to modify module Search Relevance!';
$_['error_field']               = 'New search field can\'t be empty';
$_['error_warning']             = 'Carefully check the form for errors!';

// Help
$_['help_tab_general']          = '';
$_['help_tab_relevance']        = '';
$_['help_tab_exclude_words']    = 'One word per line';
$_['help_tab_replace_words']    = 'One pair of words per line, words in the pair separated by space. For example: aple apple';
$_['help_tab_add_fields'] = 'Help:<br/>
    <ul>
      <li><b>Field:</b> field for search, for example: p.product_id, pd.meta_title, pa.text и т.д.</li>
      <li><b>JOIN for the new table: </b> SQL code for new table, for example: "LEFT JOIN oc_product_attribute pa ON (p.product_id=pa.product_id)" <br />
			  These fields are already used by module, you don\'t need to add them in the JOIN column:
				<ul>
				  <li>product p</li>
					<li>product_description pd</li>
					<li>product_attribute pa (if search by attributes is enabled)</li>
				  <li>category_path cp (if sub category search is enabled)</li>
					<li>product_to_category p2c (if category search is enabled)</li>
					<li>product_to_store p2s</li>
				</ul>
			</li>
			<li><b>WHERE for the new table: </b> for example: "pa.language_id = pd.language_id"</li>			
    </ul>';

$_['help_fix_keyboard_layout'] = 'Correct the wrong keyboard layout, for example: дфзещз-> laptop';
$_['help_sort_order_stock'] = 'Out of stock products will display in the end';


$_['help_support'] = '
<br />
<b>If this module does not work or you have a problem with installing or using this module you can:</b>
<ul>
  <li>email me at <a href="mailto:sv2109@gmail.com?subject=Search Relevance module">sv2109@gmail.com</a></li>
  <li>create a ticket on the <a href="http://sv2109.com/en/tickets">http://sv2109.com/en/tickets</a></li>
  <li>write a comment on the module page</li>
</ul>
<br/>
<b>You can also contact me if:</b>
<ul>
  <li>you need help with your OpenCart</li>
  <li>you need to create any other module for OpenCart</li> 
</ul>
<br/>
<div style="font-size: 150%;">Other useful modules you can find <a href="http://sv2109.com/en/modules">here</a>:</div>
<br/>
<a href="http://sv2109.com/en/modules"><img src="http://sv2109.com/i/ssb.png" alt=""><img src="http://sv2109.com/i/srb.png" alt=""><img src="http://sv2109.com/i/isb.png" alt=""><img src="http://sv2109.com/i/fcsb.png" alt="">
<br/><img src="http://sv2109.com/i/acb.png" alt=""><img src="http://sv2109.com/i/asb.png" alt=""><img src="http://sv2109.com/i/iocb.png" alt=""><img src="http://sv2109.com/i/tab.png" alt=""></a>
';