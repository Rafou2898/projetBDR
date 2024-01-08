package ch.heig.bdr.project.util;

import java.sql.*;

public class Query {
    private Connection connection;

    public Connection setConnection() throws SQLException {
        return DriverManager
                .getConnection("jdbc:postgresql://localhost:5432"
                        + "/project?"
                        + "user=bdr&password=bdr"
                        + "&currentSchema=rpg");
    }

    public Query() {
        try {
            this.connection = setConnection();
        } catch (SQLException e) {
            System.out.println("Exception: " + e);
        }

    }



}
