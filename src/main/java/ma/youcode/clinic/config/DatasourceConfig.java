package ma.youcode.clinic.config;

import com.mysql.cj.jdbc.MysqlDataSource;

import javax.sql.DataSource;

public class DatasourceConfig {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/gestion_clinic";
    private static final String DB_USER = "clinic";
    private static final String DB_PASSWORD = "1234";

    public static DataSource getDataSource() {
        MysqlDataSource dataSource = new MysqlDataSource();

        dataSource.setURL(DB_URL);
        dataSource.setUser(DB_USER);
        dataSource.setPassword(DB_PASSWORD);

        return dataSource;
    }
}