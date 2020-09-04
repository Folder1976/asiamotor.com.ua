<?php
class ModelCatalogCity extends Model {
	public function addCity($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "city SET
						 alias = '" . $this->db->escape($data['alias']) . "',
						 sort_order = '" . (int)$data['sort_order'] . "'");

		$city_id = $this->db->getLastId();

		foreach ($data['city_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "city_description SET city_id = '" . (int)$city_id . "',
							 language_id = '" . (int)$language_id . "',
							 name = '" . $this->db->escape($value['name']) . "',
							 name_rod = '" . $this->db->escape($value['name_rod']) . "',
							 name_dat = '" . $this->db->escape($value['name_dat']) . "',
							 telephone = '" . $this->db->escape($value['telephone']) . "',
							 text1 = '" . $this->db->escape($value['text1']) . "',
							 text2 = '" . $this->db->escape($value['text2']) . "',
							 text3 = '" . $this->db->escape($value['text3']) . "',
							 text4 = '" . $this->db->escape($value['text4']) . "'
							 ");
		}

		return $city_id;
	}

	public function editCity($city_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "city SET
						 alias = '" . $this->db->escape($data['alias']) . "',
						 sort_order = '" . (int)$data['sort_order'] . "' WHERE city_id = '" . (int)$city_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "city_description WHERE city_id = '" . (int)$city_id . "'");

		foreach ($data['city_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "city_description SET
							 city_id = '" . (int)$city_id . "',
							 language_id = '" . (int)$language_id . "',
							 name = '" . $this->db->escape($value['name']) . "',
							 name_rod = '" . $this->db->escape($value['name_rod']) . "',
							 name_dat = '" . $this->db->escape($value['name_dat']) . "',
							 telephone = '" . $this->db->escape($value['telephone']) . "',
							 text1 = '" . $this->db->escape($value['text1']) . "',
							 text2 = '" . $this->db->escape($value['text2']) . "',
							 text3 = '" . $this->db->escape($value['text3']) . "',
							 text4 = '" . $this->db->escape($value['text4']) . "'
							 ");
		}
	}

	public function deleteCity($city_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "city WHERE city_id = '" . (int)$city_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "city_description WHERE city_id = '" . (int)$city_id . "'");
	}

	public function getCity($city_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "city a LEFT JOIN " . DB_PREFIX . "city_description ad ON (a.city_id = ad.city_id) WHERE a.city_id = '" . (int)$city_id . "' AND ad.language_id = '" . (int)$this->config->get('config_language_id') . "'");

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

	public function getCityDescriptions($city_id) {
		$city_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "city_description WHERE city_id = '" . (int)$city_id . "'");

		foreach ($query->rows as $result) {
			$city_data[$result['language_id']] = $result;
		}

		return $city_data;
	}

	public function getTotalCitys($data) {
		
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "city a LEFT JOIN " . DB_PREFIX . "city_description ad ON (a.city_id = ad.city_id) WHERE ad.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		
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

		
		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getTotalCitysByCityGroupId($alias_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "city WHERE alias_id = '" . (int)$alias_id . "'");

		return $query->row['total'];
	}
}
