package ma.youcode.clinic.config;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DatasourceConfig {
    public static DataSource getDataSource() {
        try {
            InitialContext context = new InitialContext();

            return (DataSource) context.lookup(
                    "java:comp/env/jdbc/clinicDB"
            );

        } catch (NamingException e) {
            throw new RuntimeException(
                    "Impossible de récupérer le DataSource",
                    e
            );
        }
    }
}