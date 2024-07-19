# Cli-Kit
An implementation for application-manager-template that comes with a set of useful linux cli applications.

# Application Manager

Application Manager is a tool designed to create and manage CLI applications. It provides a structured way to register and manage applications,
making them globally accessible from any location using sudo or a local user.

## Introduction
The Application Manager is used to register CLI applications. This is achieved by adding an application-specific folder to the application's directory. Each application is represented by a bash script with a .amc extension, signifying an "Application Manager Command" (AMC). This script serves as the main file for the application.  

Once an AMC file is added, the Application Manager registers it as a global CLI application. This is achieved by creating a symbolic link to the AMC file in the `/usr/local/bin` directory, effectively installing the application system-wide.  

In addition to this, Application Manager includes a management service that monitors the applications folder for changes. When a change is detected (e.g., a new AMC is added, an existing AMC is modified, or an AMC is deleted), the management service automatically reinstalls and updates the corresponding application.

## Installation

To install Application Manager, follow these steps:

1. Clone the repository.
2. Run the `init` command. This will initialize Application Manager and start its services, including the management service that monitors the applications folder for changes.
```shell
./path_to_package/applications-manager/init
```

## Usage

To create a new application:

1. Create a new folder inside the `applications` folder. This folder will house your new application.
2. Inside this new folder, create a bash script file with the `.amc` extension. This will be the main script for your application, and its filename will serve as the CLI command name for the application.

Here's an example of a simple AMC named `hello.amc`:

```bash
#!/usr/bin/env bash
echo "Hello, world!"
```

To run the application, simply type the command name in the terminal:

```shell
> hello
Hello, world!
```

## Advanced Usage

For more advanced usage, you can use the `run_command` function from the `common` script file. This function allows you to run subcommands, providing a flexible way to extend your application's functionality.

You can also use the `log` function from the `common` script file to log messages. The logging service automatically saves these messages to a log file in the application folder, ensuring that you have a record of important events and errors.

Here's an example of how to use these functions:

```bash
#!/usr/bin/env bash
. "/path/to/common"

log "info" "Starting application..."

run_command "/path/to/subcommands" "$1"
```

In this example, `log` is used to log an informational message, and `run_command` is used to run a subcommand based on the first argument passed to the script.

Remember to replace `"/path/to/common"` and `"/path/to/subcommands"` with the actual paths to your `common` script file and subcommands folder, respectively.
