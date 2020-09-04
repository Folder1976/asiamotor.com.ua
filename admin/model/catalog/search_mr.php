<?php

class ModelCatalogSearchMr extends Model {

	public function getDefaultOptions() {

		return array(
			'key' => '5d94882896107716d5553227bd33031f',
			'min_word_length' => 2,
			'cache_results' => 1,
			'fix_keyboard_layout' => 0,
			'sort_order_stock' => 1,
			'fields' => array(
				'name' => array(
					'search' => 'contains',
					'phrase' => 'cut',
					'use_morphology' => 1,
					'use_relevance' => 1,
					'logic' => 'OR',
					'relevance' => array(
						'start' => 80,
						'phrase' => 60,
						'word' => 40
					)
				),
				'description' => array(
					'search' => 'contains',
					'phrase' => 'cut',
					'use_morphology' => 1,
					'use_relevance' => 1,
					'logic' => 'OR',
					'relevance' => array(
						'start' => 0,
						'phrase' => 20,
						'word' => 10
					)
				),
				'tags' => array(
					'search' => 'contains',
					'phrase' => 'cut',
					'use_morphology' => 1,
					'use_relevance' => 1,
					'logic' => 'OR',
					'relevance' => array(
						'start' => 0,
						'phrase' => 0,
						'word' => 45
					)
				),
				'attributes' => array(
					'search' => 0,
					'phrase' => 'cut',
					'use_morphology' => 1,
					'use_relevance' => 1,
					'logic' => 'OR',
					'relevance' => array(
						'start' => 0,
						'phrase' => 0,
						'word' => 0
					)
				),
				'model' => array(
					'search' => 0,
					'phrase' => 'cut',
					'use_morphology' => 1,
					'use_relevance' => 1,
					'logic' => 'OR',
					'exclude_characters' => '-/_',
					'relevance' => array(
						'start' => 0,
						'phrase' => 0,
						'word' => 0
					)
				),
				'sku' => array(
					'search' => 0,
					'phrase' => 'cut',
					'use_morphology' => 1,
					'use_relevance' => 1,
					'logic' => 'OR',
					'relevance' => array(
						'start' => 0,
						'phrase' => 0,
						'word' => 0
					)
				),
				'upc' => array(
					'search' => 0,
					'phrase' => 'cut',
					'use_morphology' => 1,
					'use_relevance' => 1,
					'logic' => 'OR',
					'relevance' => array(
						'start' => 0,
						'phrase' => 0,
						'word' => 0
					)
				),
				'ean' => array(
					'search' => 0,
					'phrase' => 'cut',
					'use_morphology' => 1,
					'use_relevance' => 1,
					'logic' => 'OR',
					'relevance' => array(
						'start' => 0,
						'phrase' => 0,
						'word' => 0
					)
				),
				'jan' => array(
					'search' => 0,
					'phrase' => 'cut',
					'use_morphology' => 1,
					'use_relevance' => 1,
					'logic' => 'OR',
					'relevance' => array(
						'start' => 0,
						'phrase' => 0,
						'word' => 0
					)
				),
				'isbn' => array(
					'search' => 0,
					'phrase' => 'cut',
					'use_morphology' => 1,
					'use_relevance' => 1,
					'logic' => 'OR',
					'relevance' => array(
						'start' => 0,
						'phrase' => 0,
						'word' => 0
					)
				),
				'mpn' => array(
					'search' => 0,
					'phrase' => 'cut',
					'use_morphology' => 1,
					'use_relevance' => 1,
					'logic' => 'OR',
					'relevance' => array(
						'start' => 0,
						'phrase' => 0,
						'word' => 0
					)
				),
			),
		);
	}

	public function getFields() {

		return array(
			'name',
			'description',
			'tags',
			'attributes',
			'model',
			'sku',
			'upc',
			'ean',
			'jan',
			'isbn',
			'mpn');
	}

	public function install() {
		
				
		$a6102cb98a21d0cd139b7cec10d6d41f7 = array (
						'model' => true,
			'sku' => true,
			'upc' => true,
			'ean' => true,
			'jan' => true,
			'isbn' => true,
			'mpn' => true
		);
		
		$a9ef17827ad94aa2dba8cb6b192134cdf = $this->db->query("SHOW INDEX FROM " . DB_PREFIX . "product");
		
		foreach ($a9ef17827ad94aa2dba8cb6b192134cdf->rows as $a9cea3f16ec1fb6493966c82222400143) {
						if (isset($a9cea3f16ec1fb6493966c82222400143['Column_name']) && array_key_exists($a9cea3f16ec1fb6493966c82222400143['Column_name'], $a6102cb98a21d0cd139b7cec10d6d41f7)) {
				$a6102cb98a21d0cd139b7cec10d6d41f7[$a9cea3f16ec1fb6493966c82222400143['Column_name']] = false;
			}
		}
		
		foreach ($a6102cb98a21d0cd139b7cec10d6d41f7 as $a3473947a95d3198fc40700c91ab33f47 => $afe0541c34c14a914e2c9291fe3137f70) {
			if ($afe0541c34c14a914e2c9291fe3137f70) {
				$this->db->query("ALTER TABLE " . DB_PREFIX . "product ADD INDEX ( " . $a3473947a95d3198fc40700c91ab33f47 . " )");
			}
		}				
	}
}
//author sv2109 (sv2109@gmail.com) license for 1 product copy granted for ydimas (ydimas@gmail.com asiamotor.com.ua)
