<?php
/**************************************************************/
/*	@copyright	OCTemplates 2018.							  */
/*	@support	https://octemplates.net/					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelCatalogOctProductsFromCategory extends Model {    
    public function getProductsID($data) {
        $customer_group_id = $this->config->get('config_customer_group_id');
        
        $products_data  = array();
        $where = array();
                
        if (!empty($data['category'])) {
	        $sql = "SELECT p.product_id, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int) $customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int) $customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special";
	        
	        if (!empty($data['sub_category'])) {
	            $sql .= " FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (cp.category_id = p2c.category_id)";
	        } else {
	            $sql .= " FROM " . DB_PREFIX . "product_to_category p2c";
	        }
	        
	        $sql .= " LEFT JOIN " . DB_PREFIX . "product p ON (p2c.product_id = p.product_id)";
	        
	        $sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'";
	        
	        if (!empty($data['category'])) {
	            if (!empty($data['sub_category'])) {
	                $sql .= " AND cp.path_id IN (" . implode(',', $data['category']) . ")";
	            } else {
	                $sql .= " AND p2c.category_id IN (" . implode(',', $data['category']) . ")";
	            }
	        }
	        
	        if (isset($data['show_no_quantity_products']) && $data['show_no_quantity_products']) {
		        $sql .= ' AND p.quantity > 0';
	        }
	        
	        $sql .= " GROUP BY p.product_id";
	
			$sort_data = array(
				'pd.name',
				'p.model',
				'p.quantity',
				'p.price',
				'rating',
				'p.sort_order',
				'p.date_added'
			);
	
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				if ($data['sort'] == 'pd.name' || $data['sort'] == 'p.model') {
					$sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
				} elseif ($data['sort'] == 'p.price') {
					$sql .= " ORDER BY (CASE WHEN special IS NOT NULL THEN special WHEN discount IS NOT NULL THEN discount ELSE p.price END)";
				} else {
					$sql .= " ORDER BY " . $data['sort'];
				}
			} else {
				$sql .= " ORDER BY p.sort_order";
			}
	
			if (isset($data['order']) && ($data['order'] == 'desc')) {
				$sql .= " DESC, LCASE(pd.name) DESC";
			} else {
				$sql .= " ASC, LCASE(pd.name) ASC";
			}
	        
	        if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}
	
				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}
	
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}
			
	        $query = $this->db->query($sql);
			
	        if ($query->rows) {
	            foreach ($query->rows as $r) {
	                $products_data[$r['product_id']] = $r['product_id'];
	        	}
	        }
        }
        
        if (isset($data['specials']) && $data['specials']) {
	    	$sql = "SELECT DISTINCT ps.product_id FROM " . DB_PREFIX . "product_special ps LEFT JOIN " . DB_PREFIX . "product p ON (ps.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))";
	    	
	    	if (isset($data['show_no_quantity_products']) && $data['show_no_quantity_products']) {
		        $sql .= ' AND p.quantity > 0';
	        }
	        
	    	$sql .= " GROUP BY ps.product_id LIMIT " .  (int)$data['specials'];
	    	
	    	$query_specials = $this->db->query($sql);
	    	
	    	if ($query_specials->rows) {
	            foreach ($query_specials->rows as $r) {
		            if (!isset($products_data[$r['product_id']])) {
	                	$products_data[$r['product_id']] = $r['product_id'];
	                }
	        	}
	        }
	    }
        
        if (isset($data['latest']) && $data['latest']) {
	        $sql = "SELECT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
	        
	        if (isset($data['show_no_quantity_products']) && $data['show_no_quantity_products']) {
		        $sql .= ' AND p.quantity > 0';
	        }
	        
	        $sql .= " ORDER BY p.date_added DESC LIMIT " . (int)$data['latest'];
	        
	        $query_latest = $this->db->query($sql);
	        
	        if ($query_latest->rows) {
	            foreach ($query_latest->rows as $r) {
		            if (!isset($products_data[$r['product_id']])) {
	                	$products_data[$r['product_id']] = $r['product_id'];
	                }
	        	}
	        }
        }
        
        return $products_data;
    }
}