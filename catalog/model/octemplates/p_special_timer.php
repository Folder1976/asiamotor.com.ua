<?php
/**************************************************************/
/*	@copyright	OCTemplates 2018.							  */
/*	@support	https://octemplates.net/					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelOctemplatesPSpecialTimer extends Model {
    public function getProducts($data = array()) {
        $customer_group_id = ($this->customer->isLogged()) ? $this->customer->getGroupId() : $this->config->get('config_customer_group_id');
        
        $sql = "SELECT ps.product_id";

        if (!empty($data['filter_sub_category'])) {
            $sql .= " FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (cp.category_id = p2c.category_id)";
        } else {
            $sql .= " FROM " . DB_PREFIX . "product_to_category p2c";
        }

        $sql .= " LEFT JOIN " . DB_PREFIX . "product p ON (p2c.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_special ps ON (ps.product_id = p.product_id)";

        $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.quantity > 0 AND ps.date_end > NOW() AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND p2s.store_id = '" . (int) $this->config->get('config_store_id') . "'";

        if (!empty($data['filter_category_id'])) {
            if (!empty($data['filter_sub_category'])) {
                $sql .= " AND cp.path_id IN (" . implode(',', $data['filter_category_id']) . ")";
            } else {
                $sql .= " AND p2c.category_id IN (" . implode(',', $data['filter_category_id']) . ")";
            }
        }

        $sql .= " GROUP BY ps.product_id ORDER BY ps.date_end ASC";

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
        }

        $product_data = array();

        $query = $this->db->query($sql);

        $this->load->model('catalog/product');

        foreach ($query->rows as $result) {
            $ps = $this->getProductSpecialDates($result['product_id']);

			$product_data[$result['product_id']] = $this->model_catalog_product->getProduct($result['product_id']);
            $product_data[$result['product_id']]['date_start'] = $ps['date_start'] ? $ps['date_start'] : '0000-00-00';
            $product_data[$result['product_id']]['date_end'] = $ps['date_end'] ? $ps['date_end'] : '0000-00-00';
		}

		return $product_data;
    }

    public function getProductSpecialDates($product_id) {
        $query = $this->db->query("SELECT date_start, date_end FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = '".(int)$product_id."' AND ps.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1");

        if ($query->num_rows) {
            return $query->row;
        } else {
            return false;
        }
    }
}
