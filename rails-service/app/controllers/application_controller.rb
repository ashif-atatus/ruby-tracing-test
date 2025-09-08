# require "logger"

# CUSTOM_LOGGER= Logger.new($stdout)
# CUSTOM_LOGGER.level = Logger::INFO

# CUSTOM_LOGGER.formatter = proc do |severity, datetime, progname, msg|
#   "#{datetime.utc.iso8601} #{severity} #{progname}: #{msg}\n"
# end

class ApplicationController < ActionController::API
  def index
    # CUSTOM_LOGGER.info("Hello Ruby Tracing Test!")
    # transaction = Atatus.current_transaction

    # transaction_id = transaction.id
    # trace_id = transaction.trace_id
    # span_id = Atatus.current_span.id

    # Rails.logger.info("TRANSACTION_ID: #{transaction_id}")
    # Rails.logger.info("TRACE_ID: #{trace_id}")
    # Rails.logger.info("SPAN_ID: #{span_id}")

    # Rails.logger.info("atatus_apm={:transactionId=>\"779a81cdd99f04d3\", :spanId=>\"18b28b5ef081e37b\", :traceId=>\"fb8bca3a153991242bc2fa704d220efb\"}")
    # 
    Rails.logger.debug("This is a debug message")
    Rails.logger.info("This is an info message")
    Rails.logger.warn("This is a warning message")
    Rails.logger.error("This is an error message")
    Rails.logger.fatal("This is a fatal message")
    Rails.logger.unknown("This is an unknown message")

    render json: {
      message: "Hello Ruby Tracing Test!"
    }
  end

  def health
        render json: { status: :ok }
  end
end
