package com.example.project.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class ProjectService{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void setDatabase(String databaseName) {
		String sql = "use "+ databaseName; 
		jdbcTemplate.execute(sql);
	}
	public List<String> getTables(){
		String sql = "SHOW TABLES";
		//System.out.println(jdbcTemplate.queryForList(sql, String.class));
		return jdbcTemplate.queryForList(sql, String.class);		
	}
	
	public List<Map<String, Object>> getColumns(String tableName) {
	    String sql = "DESCRIBE " + tableName;
	    try {
	        // Fetch column details from the table
	        return jdbcTemplate.queryForList(sql);
	    } catch (Exception e) {
	        System.out.println("Error fetching columns: " + e.getMessage());
	        return new ArrayList<>(); // Return an empty list in case of error
	    }
	}

    
    public void executeUpdate(String sql) {
        jdbcTemplate.update(sql);
    }
	

}
