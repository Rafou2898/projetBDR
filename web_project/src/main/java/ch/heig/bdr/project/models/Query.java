package ch.heig.bdr.project.models;

import java.sql.*;

public class Query {
    static final String DB_URL = "jdbc:postgresql://localhost:5432"
            + "/project?"
            + "user=bdr&password=bdr"
            + "&currentSchema=rpg";
    static final String USER = "bdr";
    static final String PASS = "bdr";
    private final String query;

    public Query(String query) {
        this.query = query;
    }

    public void sendQuery() {
        // Open a connection
        try(Connection conn = DriverManager.getConnection(DB_URL);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);) {
            // Extract data from result set
            while (rs.next()) {
                // Retrieve by column name (Need to retrieve it automatically)
                // Smth like if (SELECT) ... to (FROM) on get les noms !
                System.out.print("ID: " + rs.getInt("idarchetypes"));
                System.out.println(", Nom: " + rs.getString("nom"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
