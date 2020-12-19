package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ApplicationDB {
	
	public ApplicationDB(){
	}

	public Connection getConnection(){
		
		String connectionUrl = "jdbc:mysql://database-2.cghflcehndrg.us-east-2.rds.amazonaws.com:3306/trains";
		Connection connection = null;
		
		try {
            //Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (InstantiationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        try {
            //Create a connection to your DB
            connection = DriverManager.getConnection(connectionUrl,"cs336g17db", "9iS2TWn54BSZWsZ");
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	
	
	public static void main(String[] args) {
		
	}
	
	

}
