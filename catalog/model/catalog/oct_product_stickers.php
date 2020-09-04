<?php
/**************************************************************/
/*	@copyright	OCTemplates 2018.							  */
/*	@support	https://octemplates.net/					  */
/*	@license	LICENSE.txt									  */
/**************************************************************/

class ModelCatalogOctProductStickers extends Model {
	public function getProductSticker($product_sticker_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "oct_product_stickers ps LEFT JOIN " . DB_PREFIX . "oct_product_stickers_description psd ON (ps.product_sticker_id = psd.product_sticker_id) WHERE ps.product_sticker_id = '" . (int)$product_sticker_id . "' AND psd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND ps.status = '1' ORDER BY ps.sort_order ASC");

		return $query->row;
	}
	
	public function getProductStickers($data) {
		if ($data) {
			$sql = "SELECT DISTINCT * FROM " . DB_PREFIX . "oct_product_stickers ps LEFT JOIN " . DB_PREFIX . "oct_product_stickers_description psd ON (ps.product_sticker_id = psd.product_sticker_id) WHERE (";
			
			foreach ($data as $product_sticker_id) {
				$sql .= " ps.product_sticker_id = '" . (int)$product_sticker_id . "' OR";
			}
			
			$sql = rtrim($sql, " OR");
			
			$sql .= ") AND psd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND ps.status = '1' ORDER BY ps.sort_order ASC";
			
			$query = $this->db->query($sql);
			
			return $query->rows;
		} else {
			return;
		}
   }
}