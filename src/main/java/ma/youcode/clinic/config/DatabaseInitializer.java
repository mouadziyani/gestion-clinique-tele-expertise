package ma.youcode.clinic.config;

import javax.sql.DataSource;

public class DatabaseInitializer {
    private final DataSource dataSource;

    public DatabaseInitializer(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public void init() {
    }
}
