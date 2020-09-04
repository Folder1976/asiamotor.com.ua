<?php
class ModelCatalogInformation extends Model {
	public function getInformation($information_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE i.information_id = '" . (int)$information_id . "' AND id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1'");

		return $query->row;
	}


			public function getOCTInformations($informations_id) {
			if(!empty($informations_id)){
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE (i.information_id IN (" . implode(",", $informations_id) . ")) AND id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' AND i.bottom = '1' AND i.sort_order >= 0 ORDER BY i.sort_order, LCASE(id.title) ASC");
		
				return $query->rows;
			} else {
				return array();
			}
			}
	      
	public function getInformations() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' ORDER BY i.sort_order, LCASE(id.title) ASC");

		return $query->rows;
	}

	public function getInformationLayoutId($information_id) {
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");

		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return 0;
		}
	}
	
	public function getCityId($alias){
		
		$sql = "SELECT * FROM " . DB_PREFIX . "city a
			LEFT JOIN " . DB_PREFIX . "city_description ad ON (a.city_id = ad.city_id)
				WHERE ad.language_id = '" . (int)$this->config->get('config_language_id') . "'
				AND a.alias='".$alias."'
				LIMIT 1";

		$query = $this->db->query($sql);

		return $query->row;
		
	}
	
	public function getCitys($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "city a LEFT JOIN " . DB_PREFIX . "city_description ad ON (a.city_id = ad.city_id) WHERE ad.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND (LOWER(ad.name) LIKE '" . $this->db->escape($data['filter_name']) . "%'";
			$sql .= " OR LOWER(a.alias) LIKE '" . $this->db->escape($data['filter_name']) . "%'";
			$sql .= " OR LOWER(ad.name_rod) LIKE '" . $this->db->escape($data['filter_name']) . "%'";
			$sql .= " OR LOWER(ad.telephone) LIKE '" . $this->db->escape($data['filter_name']) . "%'";
			$sql .= " OR LOWER(ad.text1) LIKE '" . $this->db->escape($data['filter_name']) . "%'";
			$sql .= " OR LOWER(ad.text2) LIKE '" . $this->db->escape($data['filter_name']) . "%'";
			$sql .= " OR LOWER(ad.text3) LIKE '" . $this->db->escape($data['filter_name']) . "%'";
			$sql .= " OR LOWER(ad.text4) LIKE '" . $this->db->escape($data['filter_name']) . "%'";
			$sql .= " OR LOWER(ad.name_dat) LIKE '" . $this->db->escape($data['filter_name']) . "%')";
		}

		$sort_data = array(
			'ad.name',
			'alias',
			'a.sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY ad.name";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
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

		return $query->rows;
	}
}