<?php
class ModelCatalogCars extends Model {
	public function getMarks(){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_mark ORDER BY mark_name");
		
		return $query->rows;
	}
	
	public function getModels($mark_id = 0){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_model WHERE mark_id=".$mark_id." ORDER BY model_name");

		return $query->rows;
	}
	
	public function getMark($mark_id = 0){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_mark WHERE mark_id=".$mark_id." LIMIT 1");
		
		return $query->row;
	}
	
	public function getModel($mark_id = 0, $model_id = 0){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_model WHERE mark_id=".$mark_id." AND model_id=".$model_id." LIMIT 1");

		return $query->row;
	}
	
	public function getYears($mark_id = 0, $model_id = 0){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_dvigun cd
								  LEFT JOIN " . DB_PREFIX . "car c ON c.dvigunkey = cd.dvigunkey
								  WHERE c.mark_id=".$mark_id." AND c.model_id=".$model_id." ORDER BY cd.dvigun");

		if($query->num_rows){
			
			$return = array();
			foreach($query->rows as $row){
				
				//$row['goda'] = str_replace(',',';', $row['goda']);
				
				$years = explode(';', trim($row['goda'],';'));
				foreach($years as $year){
					$return[$year] = $year;
				}
			}
			asort($return);
			
		}else{
			$return = array(date('Y'));
		}
		
		return $return;
	}
	
	public function getDviguns($mark_id = 0, $model_id = 0){
		
		if($year == 0) $year = date('Y');
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_dvigun cd
								  LEFT JOIN " . DB_PREFIX . "car c ON c.dvigunkey = cd.dvigunkey
								  WHERE c.mark_id=".$mark_id." AND c.model_id=".$model_id."
								  ORDER BY cd.dvigun");

		return $query->rows;
	}
	
	public function getDvigun($dvigun_id){
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_dvigun WHERE dvigunkey='".$dvigun_id."' LIMIT 1");

		return $query->row;
	}
	
	public function deleteMark($mark_id){
	
		$sql = "SELECT * FROM " . DB_PREFIX . "car WHERE mark_id=".(int)$mark_id;
		$models = $this->db->query($sql);
		foreach($models->rows as $row){
			
			$sql = "DELETE FROM " . DB_PREFIX . "car_primenimost WHERE modelkey='".$row['key']."'";
			echo $sql;
			$this->db->query($sql);
			
			$sql = "DELETE FROM " . DB_PREFIX . "car WHERE `key`=".$row['key'];
			echo $sql;
			$this->db->query($sql);
				
		}
		
		$sql = "DELETE FROM " . DB_PREFIX . "car_model WHERE mark_id=".(int)$mark_id;
		echo $sql;
		$this->db->query($sql);
		
		$sql = "DELETE FROM " . DB_PREFIX . "car_mark WHERE mark_id=".(int)$mark_id;
		echo $sql;
		$this->db->query($sql);
	}
	public function deleteModel($model_id){
		
		$sql = "SELECT * FROM " . DB_PREFIX . "car WHERE model_id=".(int)$model_id;
		$models = $this->db->query($sql);
		foreach($models->rows as $row){
			
			$sql = "DELETE FROM " . DB_PREFIX . "car_primenimost WHERE modelkey='".$row['key']."'";
			echo $sql;
			$this->db->query($sql);
			
			$sql = "DELETE FROM " . DB_PREFIX . "car WHERE `key`=".$row['key'];
			echo $sql;
			$this->db->query($sql);
				
		}
		
		$sql = "DELETE FROM " . DB_PREFIX . "car_model WHERE model_id=".(int)$model_id;
		echo $sql;
		$this->db->query($sql);
	}
}
