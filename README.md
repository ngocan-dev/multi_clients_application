# Multi Clients Application

A Java desktop application for managing furniture-related data with separate interfaces for administrators and clients.

## Project structure

- `src/` — Java source files for admin and client features.
- `database/` — SQL scripts used by the application.
- `build.xml` — Apache Ant build file.
- `manifest.mf` — JAR manifest metadata.

## Requirements

- Java Development Kit (JDK) 8+
- Apache Ant (for command-line builds)

## Build

```bash
ant clean
ant jar
```

## Run

If your build creates an executable JAR in `dist/`, run:

```bash
java -jar dist/multi_clients_application.jar
```

> Note: output JAR name and entry point may vary depending on your Ant configuration in `build.xml`.
