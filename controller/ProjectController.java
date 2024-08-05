package com.example.project.controller;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.project.Email.Service.EmailSendIntegration;
import com.example.project.ExceptionHandling.PrimaryKeyCannotBeNullException;
import com.example.project.service.ProjectService;

@Controller
public class ProjectController {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private ProjectService ps;

	@Autowired
	EmailSendIntegration emailSendIntegration;

	private String databaseName;
	private String createdTableName;
	private String PrimaryKey;
	private List<String> columnNames = new ArrayList<>();
	private List<String> columnTypes = new ArrayList<>();



	@GetMapping("home")
	public String home() {
		return "home.jsp";
	}

	@PostMapping("/new")
	public ModelAndView createDatabase(@RequestParam("newDatabaseName") String newDatabaseName) {
		ModelAndView model = new ModelAndView();
		databaseName = newDatabaseName;
		try {
			String sql = "CREATE DATABASE IF NOT EXISTS " + newDatabaseName;
			jdbcTemplate.execute(sql);
			String sql1 = "USE " + newDatabaseName;
			jdbcTemplate.execute(sql1);
			model.setViewName("table.jsp");
			model.addObject("databaseName", newDatabaseName);
		} catch (Exception e) {
			model.setViewName("table.jsp");
			model.addObject("errorMessage", "Failed to create database " + newDatabaseName + ": " + e.getMessage());
		}
		return model;
	}

	@PostMapping("/createTable")
	public ModelAndView createTable(@RequestParam("tableName") String tableName, 
			@RequestParam("columnName") String columnName, 
			@RequestParam("columnType") String columnType) {
		ModelAndView mv = new ModelAndView();
		createdTableName = tableName;
		// add this in a separate class


		if(columnType.equalsIgnoreCase("String") || columnType.equalsIgnoreCase("Text") || columnType.equalsIgnoreCase("AlphaNum")) {
			columnType = "VARCHAR(255)";
		}

		if(columnType.equalsIgnoreCase("Number") || columnType.equalsIgnoreCase("Integer") || columnType.equalsIgnoreCase("int") 
				|| columnType.equalsIgnoreCase("Numeric")) {

			columnType = "INTEGER";
		}

		if(columnType.equalsIgnoreCase("Description")  || columnType.equalsIgnoreCase("Sentence")) {
			columnName = "VARCHAR(MAX)";
		}

		if(columnType.equalsIgnoreCase("date time") || columnType.equalsIgnoreCase("date and time") || columnType.equalsIgnoreCase("date")) {
			columnType = "DATETIME";
		}

		if(columnType.equalsIgnoreCase("Big Integer") || columnType.equalsIgnoreCase("Big Int")) {
			columnType = "BIGINT";
		}

		try {
			columnTypes.add(columnType);
			String sql = "CREATE TABLE " + tableName + " (" + columnName + " " + columnType + ")";
			jdbcTemplate.execute(sql);
			mv.setViewName("Entities.jsp");
			mv.addObject("tableName", tableName);
		} catch (Exception e) {
			columnTypes.remove(columnTypes.size() - 1);
			mv.setViewName("Entities.jsp");
			mv.addObject("errorMessage", "Failed to create the table " + tableName + ": " + e.getMessage());
			return mv;
		}
		return mv;
	}

	@PostMapping("/addColumn")
	public ModelAndView addColumn(@RequestParam("columnName") String columnName, @RequestParam("columnType") String columnType) { 
		// add this in a separate class


		if(columnType.equalsIgnoreCase("String") || columnType.equalsIgnoreCase("Text") || columnType.equalsIgnoreCase("AlphaNum")) {
			columnType = "VARCHAR(255)";
		}

		if(columnType.equalsIgnoreCase("Number") || columnType.equalsIgnoreCase("Integer") || columnType.equalsIgnoreCase("int") 
				|| columnType.equalsIgnoreCase("Numeric")) {

			columnType = "INTEGER";
		}

		if(columnType.equalsIgnoreCase("Description")  || columnType.equalsIgnoreCase("Sentence")) {
			columnType = "TEXT";
		}

		if(columnType.equalsIgnoreCase("datetime") || columnType.equalsIgnoreCase("date and time") || columnType.equalsIgnoreCase("date") || columnType.equalsIgnoreCase("date time")) {
			columnType = "DATETIME";
		}

		if(columnType.equalsIgnoreCase("Big Integer") || columnType.equalsIgnoreCase("Big Int")) {
			columnType = "BIGINT";
		}
		if(columnType.equalsIgnoreCase("Boolean") || columnType.equalsIgnoreCase("Bool")) {
			columnType = "BOOLEAN";
		}

		ModelAndView mv = new ModelAndView();
		try {
			columnTypes.add(columnType);
			String sql = "ALTER TABLE `" + createdTableName + "` ADD COLUMN `" + columnName + "` " + columnType;            
			jdbcTemplate.execute(sql);
			mv.setViewName("Entities.jsp");
			mv.addObject("tableName", createdTableName);
		} catch(Exception e) {
			columnTypes.remove(columnTypes.size() - 1);
			mv.setViewName("Entities.jsp");
			mv.addObject("errorMessage", "Failed to add column " + columnName + ": " + e.getMessage());
			return mv;
		}
		return mv;
	}

	@PostMapping("/isPrimaryKey")
	public ModelAndView addPrimaryKey(@RequestParam String columnName, @RequestParam String columnType) {
		ModelAndView mv = new ModelAndView();
		PrimaryKey = columnName;
		try {
			// Ensure the column type is compatible with AUTO_INCREMENT
			// For example: INT, BIGINT
			if (!columnType.equalsIgnoreCase("INT") && !columnType.equalsIgnoreCase("BIGINT") && !columnType.equalsIgnoreCase("Number")) {
				throw new IllegalArgumentException("AUTO_INCREMENT is only supported for INT and BIGINT types or Number.");
			}
			else {
				columnType = "INTEGER";
			}

			// Modify the SQL to include AUTO_INCREMENT
			columnTypes.add(columnType);
			String sql = "ALTER TABLE " + createdTableName + " ADD COLUMN " + columnName + " " + columnType + " AUTO_INCREMENT PRIMARY KEY";
			jdbcTemplate.execute(sql);

			mv.setViewName("Entities.jsp");
			mv.addObject("tableName", createdTableName);
		} catch(Exception e) {
			columnTypes.remove(columnTypes.size() - 1);	
			mv.setViewName("Entities.jsp");
			mv.addObject("errorMessage", "Failed to add primary key with auto-increment to column " + columnName + ": " + e.getMessage());
			return mv;
		}
		return mv;
	}


	@GetMapping("show")
	public ModelAndView showTables() {
		ps.setDatabase(databaseName);
		List<String> tables = ps.getTables();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("show.jsp");
		mv.addObject("tables", tables);
		return mv;
	}

	@GetMapping("/showTableData")
	public ModelAndView showTableData(@RequestParam("tableName") String tableName) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("TableData.jsp");
		ps.setDatabase(databaseName);

		// set the createdTableName to the tableName obtained on clicking the form on the web
		createdTableName = tableName;

		// Get columns for the table
		List<Map<String, Object>> columns = ps.getColumns(tableName);
		System.out.println(tableName);
		System.out.println(columns.toString());

		List<String> fieldNames = new ArrayList<>();

		// Extract the first value from each sublist in the `values` list
		for (Map<String, Object> map : columns) {
			List<Object> valueList = new ArrayList<>(map.values()); // Convert map values to a list
			if (!valueList.isEmpty()) {
				fieldNames.add(valueList.get(0).toString()); // Get the first value and add to fieldNames
			}
		}

		for (String name : fieldNames) {
			columnNames.add(name);
		}

		System.out.println(fieldNames.toString());

		// Fetch existing rows from the table
		String selectSql = "SELECT * FROM " + tableName;
		List<Map<String, Object>> rows = jdbcTemplate.queryForList(selectSql);

		mv.addObject("tableName", tableName);
		mv.addObject("fieldNames", fieldNames);
		mv.addObject("rows", rows); // Pass rows to JSP

		return mv;
	}




	@PostMapping("/addRow")
	public ModelAndView addRow(@RequestParam Map<String, String> param) {
	    StringBuilder keys = new StringBuilder();
	    StringBuilder values = new StringBuilder();
	    ModelAndView mv = new ModelAndView();
	    mv.setViewName("TableData.jsp");

	    if (param.isEmpty()) {
	        mv.addObject("errorMessage", "No values provided.");
	        mv.addObject("tableName", createdTableName);
	        mv.addObject("fieldNames", param.keySet());
	        return mv;
	    }

	    List<String> orderedColumnTypes = new ArrayList<>(columnTypes); // Assuming columnTypes is List or similar
	    int i = 0;

	    for (Map.Entry<String, String> pairs : param.entrySet()) {
	        String key = pairs.getKey();
	        String value = pairs.getValue();
	        String columnType = orderedColumnTypes.get(i);

	        keys.append(key).append(", ");

	        if (key.equalsIgnoreCase("CurT") && value.equalsIgnoreCase("CURRENT_TIMESTAMP")) {
	            values.append(value).append(", "); // Correct handling of CURRENT_TIMESTAMP
	        } else if (!value.equalsIgnoreCase("null") && !value.equals("")) {
	            switch (columnType.toUpperCase()) {
	                case "INTEGER":
	                case "BIGINT":
	                    try {
	                        Integer.parseInt(value);
	                        values.append(value).append(", ");
	                    } catch (NumberFormatException e) {
	                        mv.addObject("errorMessage", "Invalid integer value for column " + key);
	                        mv.addObject("tableName", createdTableName);
	                        mv.addObject("fieldNames", param.keySet());
	                        return mv;
	                    }
	                    break;

	                case "DATETIME":
	                case "DATE":
	                    values.append("'").append(value).append("', ");
	                    break;

	                case "VARCHAR(255)":
	                case "TEXT":
	                case "CHAR":
	                    values.append("'").append(value).append("', ");
	                    break;

	                case "BOOLEAN":
	                    // Handle boolean values without quotes
	                    if (value.equalsIgnoreCase("true") || value.equalsIgnoreCase("false")) {
	                        values.append(value.toUpperCase()).append(", ");
	                    } else {
	                        mv.addObject("errorMessage", "Invalid boolean value for column " + key);
	                        mv.addObject("tableName", createdTableName);
	                        mv.addObject("fieldNames", param.keySet());
	                        return mv;
	                    }
	                    break;

	                default:
	                    values.append("'").append(value).append("', ");
	                    break;
	            }
	        } else {
	            values.append("null").append(", ");
	        }

	        i++;
	    }

	    // Remove the addition of email_sent column
	    // keys.append("email_sent");
	    // values.append("FALSE");

	    System.out.println(values.toString());

	    String sql = "INSERT INTO " + createdTableName + " (" + keys.substring(0, keys.length() - 2) + ") VALUES (" + values.substring(0, values.length() - 2) + ")";

	    try {
	        jdbcTemplate.execute(sql);
	    } catch (Exception e) {
	        mv.addObject("errorMessage", "Failed to add Row: " + e.getMessage());
	        mv.addObject("tableName", createdTableName);
	        mv.addObject("fieldNames", param.keySet());
	        return mv;    
	    }

	    // Fetch updated rows to display
	    String selectSql = "SELECT * FROM " + createdTableName;
	    List<Map<String, Object>> rows = jdbcTemplate.queryForList(selectSql);

	    mv.addObject("tableName", createdTableName);
	    mv.addObject("fieldNames", param.keySet());
	    mv.addObject("rows", rows); // Pass rows to JSP

	    return mv;
	}



	//	@GetMapping("/remainingTime")
	//	@ResponseBody
	//	public void RemainingTime() {
	//	    String sql_RemainingTime = "select * , CurT - CURRENT_TIMESTAMP as Remaining_Time from " + createdTableName;
	//	    List<Map<String, Object>> allRows = jdbcTemplate.queryForList(sql_RemainingTime);
	//	    System.out.println(allRows.toString());
	//	}

	@GetMapping("/remainingTime")
	//@ResponseBody
	public ModelAndView getRemainingTime() {
	    String sqlRemainingTime = "SELECT Name, Unique_id, CurT, TIMESTAMPDIFF(SECOND, CURRENT_TIMESTAMP, CurT) / 60 AS Remaining_Time, email, subject, body, email_sent FROM " + createdTableName;
	    List<Map<String, Object>> allRows = jdbcTemplate.queryForList(sqlRemainingTime);
	    System.out.println("all rows data "+allRows.toString()); 

	    // Define a DateTimeFormatter
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

	    // Convert LocalDateTime to ISO format
	    for (Map<String, Object> row : allRows) {
	        LocalDateTime curT = (LocalDateTime) row.get("CurT"); // Assuming CurT is LocalDateTime
	        String isoDate = curT.format(formatter);
	        row.put("DueTime", isoDate);
	    }	

	    // Check for emails to send
	    for (Map<String, Object> row : allRows) {
	        BigDecimal remainingTime = (BigDecimal) row.get("Remaining_Time");
	        Boolean emailSent = (Boolean) row.get("email_sent");

	        if (remainingTime != null && remainingTime.intValue() <= 60 && !emailSent) {
	            String email = (String) row.get("email");
	            String subject = (String) row.get("subject");
	            String body = (String) row.get("body");

	            // Send email
	            emailSendIntegration.sendSimpleEmail(email, body, subject);
	            
	            // Update email_sent flag in the database
	            String sqlUpdateEmailSent = "UPDATE " + createdTableName + " SET email_sent = TRUE WHERE Unique_id = ?";
	            jdbcTemplate.update(sqlUpdateEmailSent, row.get("Unique_id"));
	            
	            // Mark as email sent to avoid re-sending
	            row.put("email_sent", true);
	        }
	    }

	    // Create ModelAndView object
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("Dues.jsp"); // Set view name
	    modelAndView.addObject("rows", allRows); // Add object to model

	    return modelAndView;
	}	
}
