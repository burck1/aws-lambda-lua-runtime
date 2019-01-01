-- ##################################################
-- Write to CloudWatch logs
-- ##################################################
io.write("Hello world, from ", _VERSION, "!\n")

-- Get the EVENT as a string from the first argument
local EVENT_DATA=arg[1]
io.write("EVENT_DATA = ", EVENT_DATA, "\n")

-- Get the default environment variables
-- https://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html
io.write("_HANDLER                        = ", os.getenv("_HANDLER"), "\n")
io.write("AWS_REGION                      = ", os.getenv("AWS_REGION"), "\n")
io.write("AWS_LAMBDA_FUNCTION_NAME        = ", os.getenv("AWS_LAMBDA_FUNCTION_NAME"), "\n")
io.write("AWS_LAMBDA_FUNCTION_MEMORY_SIZE = ", os.getenv("AWS_LAMBDA_FUNCTION_MEMORY_SIZE"), "\n")
io.write("AWS_LAMBDA_FUNCTION_VERSION     = ", os.getenv("AWS_LAMBDA_FUNCTION_VERSION"), "\n")
io.write("AWS_LAMBDA_LOG_GROUP_NAME       = ", os.getenv("AWS_LAMBDA_LOG_GROUP_NAME"), "\n")
io.write("AWS_LAMBDA_LOG_STREAM_NAME      = ", os.getenv("AWS_LAMBDA_LOG_STREAM_NAME"), "\n")
io.write("AWS_LAMBDA_LOG_STREAM_NAME      = ", os.getenv("AWS_LAMBDA_LOG_STREAM_NAME"), "\n")
io.write("LANG                            = ", os.getenv("LANG"), "\n")
io.write("TZ                              = ", os.getenv("TZ"), "\n")
io.write("LAMBDA_TASK_ROOT                = ", os.getenv("LAMBDA_TASK_ROOT"), "\n")
io.write("LAMBDA_RUNTIME_DIR              = ", os.getenv("LAMBDA_RUNTIME_DIR"), "\n")
io.write("PATH                            = ", os.getenv("PATH"), "\n")
io.write("LD_LIBRARY_PATH                 = ", os.getenv("LD_LIBRARY_PATH"), "\n")
io.write("AWS_LAMBDA_RUNTIME_API          = ", os.getenv("AWS_LAMBDA_RUNTIME_API"), "\n")

-- Get the bash lambda layer environment variables
-- https://github.com/gkrizek/bash-lambda-layer#notes
io.write("AWS_LAMBDA_REQUEST_ID           = ", os.getenv("AWS_LAMBDA_REQUEST_ID"), "\n")
io.write("AWS_LAMBDA_DEADLINE_MS          = ", os.getenv("AWS_LAMBDA_DEADLINE_MS"), "\n")
io.write("AWS_LAMBDA_FUNCTION_ARN         = ", os.getenv("AWS_LAMBDA_FUNCTION_ARN"), "\n")
io.write("AWS_LAMBDA_TRACE_ID             = ", os.getenv("AWS_LAMBDA_TRACE_ID"), "\n")

-- Get our custom environment variables
-- Set in serverless.yml @ functions.helloLua.environment
io.write("HELLO                           = ", os.getenv("HELLO"), "\n")

-- Write function's return value
io.stderr:write('{"success": true}')