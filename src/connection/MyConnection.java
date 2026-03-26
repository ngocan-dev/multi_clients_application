package connection;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import javax.swing.JOptionPane;

public class MyConnection {
    private static final String DEFAULT_USERNAME = "ITITIU21146"; // Tên đăng nhập SQL Server
    private static final String DEFAULT_PASSWORD = "1";          // Mật khẩu SQL Server
    private static final String DEFAULT_URL = "jdbc:sqlserver://localhost:1433;databaseName=furnitured;encrypt=true;trustServerCertificate=true;";

    private static final String CONFIG_FILE = "db.properties";
    private static final Properties FILE_PROPS = loadFileProperties();

    public static final String username = resolveConfig("DB_USERNAME", "db.username", DEFAULT_USERNAME);
    public static final String password = resolveConfig("DB_PASSWORD", "db.password", DEFAULT_PASSWORD);
    public static final String url = resolveConfig("DB_URL", "db.url", DEFAULT_URL);

    public static Connection con = null;

    public static Connection getConnection() {
        try {
            // Load driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // Kết nối SQL Server
            con = DriverManager.getConnection(url, username, password);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Kết nối thất bại: " + ex.getMessage(), "Lỗi", JOptionPane.WARNING_MESSAGE);
        }
        return con;
    }

    private static String resolveConfig(String envKey, String propKey, String defaultValue) {
        String envValue = System.getenv(envKey);
        if (hasText(envValue)) {
            return envValue;
        }

        String systemPropertyValue = System.getProperty(propKey);
        if (hasText(systemPropertyValue)) {
            return systemPropertyValue;
        }

        String filePropertyValue = FILE_PROPS.getProperty(propKey);
        if (hasText(filePropertyValue)) {
            return filePropertyValue;
        }

        return defaultValue;
    }

    private static Properties loadFileProperties() {
        Properties properties = new Properties();
        try (InputStream input = new FileInputStream(CONFIG_FILE)) {
            properties.load(input);
        } catch (IOException ex) {
            // Optional local config file; defaults and env/system properties still apply.
        }
        return properties;
    }

    private static boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
