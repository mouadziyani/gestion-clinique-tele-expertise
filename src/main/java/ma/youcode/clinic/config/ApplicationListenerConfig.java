package ma.youcode.clinic.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import javax.sql.DataSource;

@WebListener
public class ApplicationListenerConfig implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        DataSource dataSource = DatasourceConfig.getDataSource();

        DatabaseInitializer db = new DatabaseInitializer(dataSource);

        db.init();
    }
}
